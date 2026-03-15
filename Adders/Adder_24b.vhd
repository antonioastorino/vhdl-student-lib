library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_24b is
    Port ( A : in  std_logic_vector (23 downto 0);
           B : in  std_logic_vector (23 downto 0);
           C : out  std_logic_vector (23 downto 0);
           Cin : in  std_logic;
           Cout : out  std_logic);
end Adder_24b;

architecture Behavioral of Adder_24b is
component CLA_4b is
    port (x_in      :  in   std_logic_vector(3 downto 0);
         y_in      :  in   std_logic_vector(3 downto 0);
         Cin  :  in   std_logic;
         sum  :  out   std_logic_vector(3 downto 0);
         Cout :  out  std_logic);
end component;

signal wCin : std_logic_vector(5 downto 0);

begin
	REG_GEN:
	for I in 0 to 4 generate
		CLAX : CLA_4b port map(	A(3+I*4 downto I*4),
										B(3+I*4 downto I*4),
										wCin(I),
										C(3+I*4 downto I*4),
										wCin(I+1));
	end generate;
	CLA5 : CLA_4b port map(	A(23 downto 20),
									B(23 downto 20),
									wCin(5),
									C(23 downto 20),
									Cout);
	wCin(0) <= Cin;
end Behavioral;