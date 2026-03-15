library ieee ;
use ieee.std_logic_1164.all;

entity FFT_RST is
	port (T, CLK, RST : in std_logic := '0';
			Q : out std_logic);
end FFT_RST;

architecture Behav of FFT_RST is
signal CURR_STATE, NEXT_STATE : std_logic := '0';
begin
process (CLK, RST, T)
begin
	if CLK = '1' and CLK'event and T = '1' then
		 CURR_STATE <= NEXT_STATE;
	end if;
	if RST = '1' then
		CURR_STATE <= '0';	
	end if;
end process;
	Q <= CURR_STATE;
	NEXT_STATE <= not CURR_STATE;
end Behav;