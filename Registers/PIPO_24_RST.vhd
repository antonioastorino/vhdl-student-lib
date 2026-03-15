library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PIPO_24_RST is
port (Din : in std_logic_vector(23 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(23 downto 0));
end PIPO_24_RST;

architecture Structural of PIPO_24_RST is

component FFD_RST is
	port (D, CLK, RST : in std_logic;
		Q : out std_logic);

	end component;

begin
	REG_GEN:
	for I in 0 to 23 generate
		FFX : FFD_RST port map(Din(I), CLK, RST, Dout(I));
	end generate;
end Structural;