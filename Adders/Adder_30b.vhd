
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_30b is
    Port ( A : in  std_logic_vector (29 downto 0);
           B : in  std_logic_vector (29 downto 0);
           C : out  std_logic_vector (29 downto 0);
           Cin : in  std_logic;
           Cout : out  std_logic);
end Adder_30b;

architecture Structural of Adder_30b is
component CLA_4b is
    port (x_in      :  in   std_logic_vector(3 downto 0);
         y_in      :  in   std_logic_vector(3 downto 0);
         Cin  :  in   std_logic;
         sum  :  out   std_logic_vector(3 downto 0);
         Cout :  out  std_logic);
end component;

component FA is
port (Cin, x, y: in std_logic;
		s, Cout: out std_logic);
end component;

signal wCin : std_logic_vector(8 downto 0);

begin
	REG_GEN:
	for I in 0 to 6 generate
		CLAX : CLA_4b port map(	A(3+I*4 downto I*4),
										B(3+I*4 downto I*4),
										wCin(I),
										C(3+I*4 downto I*4),
										wCin(I+1));
	end generate;
	FA0 : FA port map(	wCin(7),
								A(28),
								B(28),
								C(28),
								wCin(8));
	FA1 : FA port map(	wCin(8),
								A(29),
								B(29),
								C(29),
								Cout);
	wCin(0) <= Cin;
end Structural;

