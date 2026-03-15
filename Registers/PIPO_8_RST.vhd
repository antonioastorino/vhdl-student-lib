library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PIPO_8_RST is
port (Din : in std_logic_vector(7 downto 0);

		CLK, RST : in std_logic;

		Dout : out std_logic_vector(7 downto 0));

end PIPO_8_RST;

architecture Structural of PIPO_8_RST is

component FFD_RST is
	port (D, CLK, RST : in std_logic;
		Q : out std_logic);

	end component;

begin
	REG_GEN:

	for I in 0 to 7 generate

		FFX : FFD_RST port map(Din(I), CLK, RST, Dout(I));

	end generate;

end Structural;