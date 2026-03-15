library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_41_8b is
port (a, b, c, d : in std_logic_vector (7 downto 0);
		s : in std_logic_vector (1 downto 0);
		e : out std_logic_vector (7 downto 0));
end MUX_41_8b;

architecture Behavioral of MUX_41_8b is begin
process (a, b, c, d, s)
	begin
		if 	s = "00" then 	e <= a;
		elsif s = "01" then 	e <= b;
		elsif	s = "10" then 	e <= c;
		else						e <= d;
		end if;
	end process;
end Behavioral;

