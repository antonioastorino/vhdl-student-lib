library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_21 is
port (a, b, s : in std_logic;
		c : out std_logic);
end MUX_21;

architecture Behavioral of MUX_21 is
begin
process (a, b, s)
	begin
		if s = '0' then
			c <= a;
		else c <= b;
		end if;
	end process;
end Behavioral;
