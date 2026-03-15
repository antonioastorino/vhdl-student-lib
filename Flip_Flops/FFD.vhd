library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFD is
port (D, CLK : in std_logic := '0';
		Q : out std_logic := '0');
end FFD;

architecture Behavioral of FFD is
begin
process (CLK)
	begin
		if (CLK='1' and CLK'event) then
			Q <= D;
		end if;
	end process;
end Behavioral;
