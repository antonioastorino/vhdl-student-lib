library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FIR_filter is
    Port ( Xi, Ai	: in std_logic_vector (11 downto 0);
           ST_F, RST, COEFF, CLK_M : in std_logic;
			  READY, N_S, WARN1, WARN2 : out std_logic;
			  RES : out std_logic_vector (29 downto 0)
			  );
end FIR_filter;

architecture Structural of FIR_filter is
component FIFO_64w_12b is
	port (Xin : in std_logic_vector (11 downto 0);
			CLK, LD_DW : in std_logic;
			Xout : out std_logic_vector (11 downto 0));
end component;

component Booth_Mult is
    Port ( A : in  std_logic_vector (11 downto 0);
           B : in  std_logic_vector (11 downto 0);
           RES : out  std_logic_vector (23 downto 0);
           ST : in  std_logic;
			  RST_MULT : in  std_logic;
           CLK : in  std_logic;
           B_R : out  std_logic;
           WARN : out  std_logic);
end component;

component Adder_30b is
    Port ( A : in  std_logic_vector (29 downto 0);
           B : in  std_logic_vector (29 downto 0);
           C : out  std_logic_vector (29 downto 0);
           Cin : in  std_logic;
           Cout : out  std_logic);
end component;

component PIPO_30_RST is
	port (Din : in std_logic_vector(29 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(29 downto 0));
end component;

component PIPO_30 is
	port (Din : in std_logic_vector(29 downto 0);
		CLK : in std_logic;
		Dout : out std_logic_vector(29 downto 0));
end component;

component AND_30_2b is
	port (BUS_30b : in std_logic_vector(29 downto 0);
			SIGN_1b : in std_logic;
			ANDout : out std_logic_vector(29 downto 0));
end component;

component Counter_6b_RST is
	port (CLK, RST : in std_logic;
			Count : out std_logic_vector (5 downto 0));
end component;

component CU_filter is
    Port ( ST_F, RST, B_R, LOAD, N_C, CLK_M, COEFF : in std_logic;
			  N_S, READY, CLK_A, CLK_X, LD_DW, CLK_ACC,
			  CLK_AUX, CLK_OUT, ST_MULT, WARN : out std_logic
			  );
end component;

component PIPO_24 is
	port (Din : in std_logic_vector(23 downto 0);
		CLK : in std_logic;
		Dout : out std_logic_vector(23 downto 0));
end component;

signal wCLK_X, wCLK_A, wLD_DW, wST_MULT, wB_R, wCLK_OUT, wCLK_AUX,
		 wCLK_ACC, wOR, wOR2, wAND : std_logic;
signal wM1out, wM2out : std_logic_vector (11 downto 0);
signal wPROD, wAUX : std_logic_vector (23 downto 0);
signal wB, wSUM, wACCout, wPROD_30 : std_logic_vector (29 downto 0);
signal wCOUNT : std_logic_vector (5 downto 0);
begin
--Scommentare queste righe e commentare le analoghe successive per avere un filtro da 4 taps			
--			wOR2 <= wCOUNT(1) or not wCOUNT(0);
--			wOR <= wCOUNT(1) or  wCOUNT(0);
--			wAND <= wCOUNT(1) and wCOUNT(0);
	wOR2 <= wCOUNT(5) or wCOUNT(4) or wCOUNT(3) or wCOUNT(2) or wCOUNT(1) or not wCOUNT(0);
	wOR <= wCOUNT(5) or wCOUNT(4) or wCOUNT(3) or wCOUNT(2) or wCOUNT(1) or wCOUNT(0);
	wAND <= wCOUNT(5) and wCOUNT(4) and wCOUNT(3) and wCOUNT(2) and wCOUNT(1) and wCOUNT(0);

	wPROD_30 <= wPROD(23)&wPROD(23)&wPROD(23)&wPROD(23)&wPROD(23)&wPROD(23)&wPROD(23 downto 0);
	mem1 : FIFO_64w_12b port map (Xi, wCLK_X, wLD_DW, wM1out);
	mem2 : FIFO_64w_12b port map (Ai, wCLK_A, wLD_DW, wM2out);
	MULTIPLIER : Booth_Mult port map (wM1out, wM2out, wAUX, wST_MULT, RST, CLK_M, wB_R, WARN1);
	ADDER : Adder_30b port map (wPROD_30, wB, wSUM, '0');
	REG_OUT : PIPO_30_RST port map (wSUM, wCLK_OUT, RST, RES);
	REG_ACC : PIPO_30 port map (wSUM, wCLK_ACC, wACCout);
	REG_AUX : PIPO_24 port map (wAUX, wCLK_AUX, wPROD);
	GATE : AND_30_2b port map (wACCout, wOR2, wB);
	COUNTER : Counter_6b_RST port map (wCLK_ACC, RST, wCOUNT);
	CU_FIR: CU_filter port map (	ST_F, RST, wB_R, wAND, wOR, CLK_M, COEFF,
											N_S, READY, wCLK_A, wCLK_X, wLD_DW, wCLK_ACC,
											wCLK_AUX, wCLK_OUT, wST_MULT, WARN2); 
end Structural;