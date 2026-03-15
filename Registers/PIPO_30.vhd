library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PIPO_30 is
	port (Din : in std_logic_vector(29 downto 0);
		CLK : in std_logic;
		Dout : out std_logic_vector(29 downto 0));
end PIPO_30;

architecture Structural of PIPO_30 is
	component FFD is
		port (D, CLK : in std_logic;
		Q : out std_logic);
	end component;
begin
	REG_GEN:
	for I in 0 to 29 generate
		FFX : FFD port map(Din(I), CLK, Dout(I));
	end generate;
end Structural;
