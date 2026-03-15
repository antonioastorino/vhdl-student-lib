library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
port (Cin, x, y: in std_logic;
		s, Cout: out std_logic);
end FA;

architecture behavior of FA is
begin
	s <= x XOR y XOR Cin ;
	Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y) ;
end behavior ;