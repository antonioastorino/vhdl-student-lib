LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity CLA_4b is
port (x_in	: in std_logic_vector(3 downto 0);
		y_in	: in std_logic_vector(3 downto 0);
		Cin	: in std_logic;
		sum	: out std_logic_vector(3 downto 0);
		Cout	: out std_logic);
end CLA_4b;


architecture Behavioral of CLA_4b is

signal    h_sum : std_logic_vector(3 downto 0);
signal    G : std_logic_vector(3 downto 0);
signal    P : std_logic_vector(3 downto 0);
signal    Cin_internal  : std_logic_vector(3 downto 1);

begin
   h_sum <= x_in xor y_in;
   G <= x_in and y_in;
   P <= x_in or y_in;
   process (G, P, Cin, Cin_internal)
   begin
	Cin_internal(1) <= G(0) or (P(0) and Cin);
	inst: for I in 1 to 2 loop
		Cin_internal(i+1) <= G(i) or (P(i) and Cin_internal(i));
			end loop;
   Cout <= G(3) or (P(3) and Cin_internal(3));
   end process;

   sum(0) <= h_sum(0) xor Cin;
   sum(3 downto 1) <= h_sum(3 downto 1) xor Cin_internal(3 downto 1);
end Behavioral;