library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Booth_Mult is
    Port ( A : in  std_logic_vector (11 downto 0);
           B : in  std_logic_vector (11 downto 0);
           RES : out  std_logic_vector (23 downto 0);
           ST : in  std_logic;
			  RST_MULT : in  std_logic;
           CLK : in  std_logic;
           B_R : out  std_logic;
           WARN : out  std_logic);
end Booth_Mult;

architecture Structural of Booth_Mult is
component PIXO_13_SHR is
port (SH, CLK : in std_logic;
		Din : in std_logic_vector (12 downto 0);
		Dout : out std_logic_vector (12 downto 0));
end component;

component PIXO_24_SHL is
port (SH, CLK : in std_logic;
		Din : in std_logic_vector (23 downto 0);
		Dout : out std_logic_vector (23 downto 0));
end component;

component PIPO_24_RST is
port (Din : in std_logic_vector(23 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(23 downto 0));
end component;

component MUX_41_24b is
port (a, b, c, d : in std_logic_vector (23 downto 0);
		s : in std_logic_vector (1 downto 0);
		e : out std_logic_vector (23 downto 0));
end component;

component Adder_24b is
    Port ( A : in  std_logic_vector (23 downto 0);
           B : in  std_logic_vector (23 downto 0);
           C : out  std_logic_vector (23 downto 0);
           Cin : in  std_logic;
           Cout : out  std_logic);
end component;

component Counter_4b_not_RST is
	port(	CLK, RST : in std_logic;
			Count : out std_logic_vector(3 downto 0));
end component;

component MULT_FSM is
Port (	ST : in  std_logic;
			RST_MULT : in  std_logic;
			END_MULT : in  std_logic;
			CLK : in  std_logic;
			B_R : out  std_logic;
			RST : out  std_logic;
			SH : out  std_logic;
			CLK_AB : out  std_logic;
			CLK_RES : out  std_logic;
			WARN : out  std_logic);
end component;

signal wSH, wRST, wCLK_AB, wCLK_RES, wCin, wEND_MULT: std_logic;
signal wAin, wAout : std_logic_vector (12 downto 0);
signal wBin, wBout, wBoutN, wCLAout, wMUXout, wRES: std_logic_vector (23 downto 0);
signal wCount : std_logic_vector (3 downto 0);
signal wS : std_logic_vector (1 downto 0);

begin
	wEND_MULT <= (not wCount(0) and not wCount(1)) and (wCount(2) and wCount(3));
	wAin(12 downto 0) <= A(11 downto 0)&'0';
	wBin(23 downto 0) <= B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11)&B(11 downto 0);
	wBoutN <= not wBout;
	wCin <= not wAout(0) and wAout(1);
	wS(0) <= wAout(0);
	wS(1) <= wAout(1);
	RES <= wRES;
	REGA : PIXO_13_SHR port map (wSH, wCLK_AB, wAin, wAout);
	REGB : PIXO_24_SHL port map (wSH, wCLK_AB, wBin, wBout);
	REG_RES : PIPO_24_RST port map (wCLAout, wCLK_RES, wRST, wRES);
	MUX : MUX_41_24b port map ("000000000000000000000000", wBout, wBoutN,
										"000000000000000000000000", wS, wMUXout);
	ADDER :  Adder_24b port map (wRES, wMUXout, wCLAout, wCin);
	COUNTER : Counter_4b_not_RST port map (wCLK_AB, wRST, wCount);
	
	MULT_CU : MULT_FSM port map (ST, RST_MULT, wEND_MULT, CLK, B_R, wRST, wSH, wCLK_AB, wCLK_RES, WARN);
end Structural;

