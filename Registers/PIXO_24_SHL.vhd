
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PIXO_24_SHL is
port (SH, CLK : in std_logic;
		Din : in std_logic_vector (23 downto 0);
		Dout : out std_logic_vector (23 downto 0));
end PIXO_24_SHL;

architecture Structural of PIXO_24_SHL is 
component MUX_21 is
	port (a, b, s : in std_logic;
			c : out std_logic);
end component;

component  FFD is
		port (D, CLK : in std_logic;
		Q : out std_logic);
end component;

signal W0, W1 : std_logic_vector (23 downto 0);

begin
	GEN_MUX:
	for I in 1 to 23 generate
		MUX : MUX_21 port map (Din(I), W1(I-1), SH, W0(I));
	end generate;
	GEN_FF:
	for I in 0 to 23 generate
		FFX : FFD port map (W0(I), CLK, W1(I));
	end generate;
	MUX0 : MUX_21 port map (Din(0), '0', SH, W0(0));
	extra_link:
	for I in 0 to 23 generate
		Dout(I) <= W1(I);
	end generate;
end Structural;
