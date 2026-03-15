library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MULT_FSM is
    Port (	ST : in  std_logic;
				RST_MULT : in  std_logic;
				END_MULT : in  std_logic;
				CLK : in  std_logic;
				B_R : out  std_logic;
				RST : out  std_logic;
				SH : out  std_logic;
				CLK_AB : out  std_logic;
				CLK_RES : out  std_logic;
				WARN : out  std_logic);
end MULT_FSM;

architecture Behavioral of MULT_FSM is
	type STATE_TYPE is (S0, S1, S2, S3, S4, s5, s6, s7);
	signal CURRENT_STATE, NEXT_STATE: STATE_TYPE;
	signal SIGNout : std_logic_vector (5 downto 0);

begin
	B_R <=		SIGNout (5);
	RST <=		SIGNout (4);
	SH <=			SIGNout (3);
	CLK_AB <= 	SIGNout (2);
	CLK_RES <= 	SIGNout (1);
	WARN <=		SIGNout (0);
	COMBIN: process(CURRENT_STATE, ST, END_MULT)
	begin
	case CURRENT_STATE is
		when S0 =>
			SIGNout <= "010000";
			if ST = '0' then NEXT_STATE <= S0;
				else NEXT_STATE <= S1;
			end if;
      when S1 =>
			SIGNout <= "100100";
			NEXT_STATE <= S2;
      when S2 =>
			SIGNout <= "101000";
			NEXT_STATE <= S3;
      when S3 =>
			SIGNout <= "101110";
			if END_MULT = '0' then
				NEXT_STATE <= S2;
			else
				if ST = '0' then
					NEXT_STATE <= S0;
				else NEXT_STATE <= S4;
				end if;
			end if;
      when S4 =>
			SIGNout <= "000001";
			if ST = '0' then
				NEXT_STATE <= S0;
			else NEXT_STATE <= S4;
			end if;
		when others =>
			NEXT_STATE <= S0; -- errors reset the machine
			SIGNout <= "000001"; -- warning
    end case;
end process;
	SYNCH: process (CLK, RST_MULT)
	begin
		if RST_MULT = '1' then
			CURRENT_STATE <= S0;
		elsif CLK = '1' and CLK'event then
			CURRENT_STATE <= NEXT_STATE;
		end if;
	end process;
end Behavioral;

