library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_41_24b is
port (a, b, c, d : in std_logic_vector (23 downto 0);
		s : in std_logic_vector (1 downto 0);
		e : out std_logic_vector (23 downto 0));
end MUX_41_24b;

architecture Behavioral of MUX_41_24b is begin
process (a, b, c, d, s)
	begin
	
	case s is
		when "00" =>	e <= a;
		when "01" =>	e <= b;
		when "10" =>	e <= c;
		when "11" =>	e <= d;
		when others =>	e <= a;
	end case;
end process;
end Behavioral;

