library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_21_8b is
port (a, b : in std_logic_vector (7 downto 0);
		s : in std_logic;
		c : out std_logic_vector (7 downto 0));
end MUX_21_8b;

architecture Behavioral of MUX_21_8b is begin
process (a, b, s)
	begin
		if s = '0' then
			c <= a;
		else c <= b;
		end if;
	end process;
end Behavioral;
