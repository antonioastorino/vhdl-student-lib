library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFD_RST is
port (D, CLK, RST : in std_logic := '0';
		Q : out std_logic := '0');
end FFD_RST;

architecture Behavioral of FFD_RST is
begin
process (CLK, RST)
	begin
		if RST = '1' then
			Q <= '0';
		elsif (CLK='1' and CLK'event) then
			Q <= D;
		end if;
	end process;
end Behavioral;
