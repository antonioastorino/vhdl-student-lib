library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CU_filter is
    Port ( ST_F, RST, B_R, LOAD, N_C, CLK_M, COEFF : in std_logic;
			  N_S, READY, CLK_A, CLK_X, LD_DW, CLK_ACC, CLK_OUT, ST_MULT, WARN : out std_logic
			  );
end CU_filter;

architecture Behavioral of CU_filter is
	type STATE_TYPE is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);
	signal CURRENT_STATE, NEXT_STATE: STATE_TYPE;
	signal SIGNout : std_logic_vector (8 downto 0);
begin
	N_S <=		SIGNout (8);
	READY <=		SIGNout (7);
	CLK_A <=		SIGNout (6);
	CLK_X <=		SIGNout (5);
	LD_DW <=		SIGNout (4);
	CLK_ACC <=	SIGNout (3);
	CLK_OUT <= 	SIGNout (2);
	ST_MULT <= 	SIGNout (1);
	WARN <=		SIGNout (0);
	SYNC: process (CLK_M, RST)
	begin
		if RST = '1' then
			CURRENT_STATE <= S0;
		elsif CLK_M = '1' and CLK_M'event then
			CURRENT_STATE <= NEXT_STATE;
		end if;
	end process;

	COMBIN: process(CURRENT_STATE, ST_F, B_R, LOAD, N_C, CLK_M, COEFF)
	begin
	case CURRENT_STATE is
		when S0 =>
			SIGNout <= "010000000";
			if ST_F = '0' then NEXT_STATE <= S0;
			else
				if COEFF = '0' then
					NEXT_STATE <= S6;
				else
					NEXT_STATE <= S1;
					end if;
			end if;
      when S1 =>
			SIGNout <= "001001000";
			NEXT_STATE <= S2;
      when S2 =>
			SIGNout <= "100000000";
			NEXT_STATE <= S3;
      when S3 =>
			SIGNout <= "100010000";
			NEXT_STATE <= S4;
      when S4 =>
			SIGNout <= "101010000";
			NEXT_STATE <= S5;
		when S5 =>
			SIGNout <= "100000000";
			if N_C = '0' then
				if ST_F = '0' then
					NEXT_STATE <= S0;
				else
					NEXT_STATE <= S13;
				end if;
			else 
				if ST_F = '0' then
					NEXT_STATE <= S5;
				else
					NEXT_STATE <= S1;
				end if;
			end if;
		when S6 =>
			SIGNout <= "000100000";
			NEXT_STATE <= S7;
		when S7 =>
			SIGNout <= "100000010";
			if B_R = '0' then
				NEXT_STATE <= S7;
			else
				NEXT_STATE <= S8;
			end if;
		when S8 =>
			SIGNout <= "100010000";
			if B_R = '0' then
				NEXT_STATE <= S9;
			else
				NEXT_STATE <= S8;
			end if;
		when S9 =>
			SIGNout <= "100010000";
			NEXT_STATE <= S10;
		when S10 =>
			SIGNout <= "100010000";		
			if LOAD = '0' then
				NEXT_STATE <= S11;
			else
				NEXT_STATE <= S12;
			end if;
		when S11 =>
			SIGNout <= "101111000";
			NEXT_STATE <= S7;
		when S12 =>
			SIGNout <= "101011100";
			NEXT_STATE <= S0;
		when S13 =>
			SIGNout <= "000000001";
			if ST_F = '0' then
				NEXT_STATE <= S0;
			else
				NEXT_STATE <= S13;
			end if;
		when others =>
			NEXT_STATE <= S0; -- errors reset the machine
			SIGNout <= "000000001";
    end case;
end process;
end Behavioral;