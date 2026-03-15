library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_30_2b is
	port (BUS_30b : in std_logic_vector(29 downto 0);
			SIGN_1b : in std_logic;
			ANDout : out std_logic_vector(29 downto 0));
end AND_30_2b;

architecture Structural of AND_30_2b is
begin
	AND_GEN:
	for I in 0 to 29 generate
		ANDout(I) <= BUS_30b(I) and SIGN_1b;
	end generate;
end Structural;
