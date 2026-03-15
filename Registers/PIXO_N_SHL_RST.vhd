library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PIXO_N_SHL_RST is
generic (N : integer);
port (SH, RST, CLK : in std_logic;
		Din : in std_logic_vector (N-1 downto 0);
		Dout : out std_logic_vector (N-1 downto 0));
end PIXO_N_SHL_RST;

architecture Structural of PIXO_N_SHL_RST is
component MUX_21 is
	port (a, b, s : in std_logic;
			c : out std_logic);
end component;

component  FFD_RST is
		port (D, CLK, RST : in std_logic;
		Q, QN : out std_logic);
end component;

signal W0, W1 : std_logic_vector (N-1 downto 0);

begin
	GEN_MUX:
	for I in 1 to N-1 generate
		MUX : MUX_21 port map (Din(I), W1(I-1), SH, W0(I));
	end generate;
	GEN_FF:
	for I in 0 to N-1 generate
		FFX : FFD_RST port map (W0(I), CLK, RST, W1(I));
	end generate;
	MUX0 : MUX_21 port map (Din(0), '0', SH, W0(0));
	extra_link:
	for I in 0 to N-1 generate
		Dout(I) <= W1(I);
	end generate;
end Structural;