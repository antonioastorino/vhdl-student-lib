library ieee ;
use ieee.std_logic_1164.all;

entity Counter_6b_RST is
	port (CLK, RST : in std_logic;
			Count : out std_logic_vector (5 downto 0));
end Counter_6b_RST;

architecture struct of Counter_6b_RST is
component PIPO_6_RST is
	port (Din : in std_logic_vector(5 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(5 downto 0));
end component;

component CLA_4b is
    port (	x_in : in   std_logic_vector(3 downto 0);
				y_in : in   std_logic_vector(3 downto 0);
				Cin :  in   std_logic;
				sum : out   std_logic_vector(3 downto 0);
				Cout : out  std_logic);
end component;

component FA is
port (Cin, x, y: in std_logic;
		s, Cout: out std_logic);
end component;


signal wDout, wSum : std_logic_vector (5 downto 0);
signal wCin : std_logic_vector(1 downto 0);

begin
	REG_OUT : PIPO_6_RST port map (wSum, CLK, RST, wDout);
	ADDER : CLA_4b port map (wDout(3 downto 0), "0001", '0', wSum(3 downto 0), wCin(0));
	FA0 : FA port map(	wCin(0),
								wDout(4),
								'0',
								wSum(4),
								wCin(1));
	FA1 : FA port map(	wCin(1),
								wDout(5),
								'0',
								wSum(5));
	Count <= wDout;
end struct;