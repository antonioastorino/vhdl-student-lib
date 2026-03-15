library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FIFO_64w_12b is
	port (Xin : in std_logic_vector (11 downto 0);
			CLK, LD_DW : in std_logic;
			Xout : out std_logic_vector (11 downto 0));
end FIFO_64w_12b;

architecture Structural of FIFO_64w_12b is
component MUX_21 is
port (a, b, s : in std_logic;
		c : out std_logic);
end component;

component FFD is
port (D, CLK : in std_logic;
		Q : out std_logic);
end component;

--Scommentare queste righe e commentare le analoghe successive per avere un registro da 4 parole
--TYPE LINKS12x64 is array (11 downto 0) of std_logic_vector (3 downto 0);
--TYPE LINKS12x1 is array (11 downto 0) of std_logic;
--
--
--signal CLK_and_LD, CLK_and_1 : std_logic;
--signal wc : LINKS12x1;
--signal wQ : LINKS12x64;
--
--
--begin
--	CLK_and_LD <= CLK and LD_DW;
--	CLK_and_1 <= CLK and '1';
--	COL:
--	for J in 0 to 11 generate
--		ROW:
--			for I in 1 to 2 generate
--				FFX : FFD port map(wQ(J)(I-1), CLK_and_LD, wQ(J)(I));
--			end generate;
--			FF0 : FFD port map(wQ(J)(3), CLK_and_LD, wQ(J)(0));
--			FF63 : FFD port map(wc(J), CLK_and_1, wQ(J)(3));
--			MUX0 : MUX_21 port map(Xin(J), wQ(J)(2), LD_DW, wc(J));
--			Xout(J) <= wQ(J)(3);
--	end generate;
--end Structural;


TYPE LINKS12x64 is array (11 downto 0) of std_logic_vector (63 downto 0);
TYPE LINKS12x1 is array (11 downto 0) of std_logic;


signal CLK_and_LD, CLK_and_1 : std_logic;
signal wc : LINKS12x1;
signal wQ : LINKS12x64;


begin
	CLK_and_LD <= CLK and LD_DW;
	CLK_and_1 <= CLK and '1';
	COL:
	for J in 0 to 11 generate
		ROW:
			for I in 1 to 62 generate
				FFX : FFD port map(wQ(J)(I-1), CLK_and_LD, wQ(J)(I));
			end generate;
			FF0 : FFD port map(wQ(J)(63), CLK_and_LD, wQ(J)(0));
			FF63 : FFD port map(wc(J), CLK_and_1, wQ(J)(63));
			MUX0 : MUX_21 port map(Xin(J), wQ(J)(62), LD_DW, wc(J));
			Xout(J) <= wQ(J)(63);
	end generate;
end Structural;
