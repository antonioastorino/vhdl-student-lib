library ieee ;
use ieee.std_logic_1164.all;

entity F_func is
	port (Fin : in std_logic_vector (1 downto 0);
			Fout : out std_logic_vector (1 downto 0));
end F_func;
architecture Structural of F_func is begin
	Fout(1) <= Fin(0) xor Fin(1);
	Fout(0) <= not Fin(0);
end Structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PIPO_2 is
	port (Din : in std_logic_vector(1 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(1 downto 0));
end PIPO_2;

architecture Structural of PIPO_2 is
	component FFD_RST is
		port (D, CLK, RST : in std_logic;
		Q : out std_logic);
	end component;
begin
	REG_GEN:
	for I in 0 to 1 generate
		FFX : FFD_RST port map(Din(I), CLK, RST, Dout(I));
	end generate;
end Structural;

library ieee ;
use ieee.std_logic_1164.all;
entity Counter_2b is
	port(	CLK, RST : in std_logic;
			Count : out std_logic_vector(1 downto 0));
end Counter_2b;
architecture Structural of Counter_2b is
signal NextState, CurrentState : std_logic_vector (1 downto 0);
component F_func is
	port (Fin : in std_logic_vector (1 downto 0);
			Fout : out std_logic_vector (1 downto 0));
end component;
component PIPO_2 is
	port (Din : in std_logic_vector(1 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(1 downto 0));
end component;
begin
	F : F_func port map (CurrentState, NextState);
	State : PIPO_2 port map (NextState, CLK, RST, CurrentState);
	Count <= CurrentState;
end Structural;