library ieee ;
use ieee.std_logic_1164.all;
entity Counter_4b_RST is
	port(	CLK, RST : in std_logic;
			Count : out std_logic_vector(3 downto 0));
end Counter_4b_RST;


library ieee ;
use ieee.std_logic_1164.all;

entity F_Count_4b is
	port (Fin : in std_logic_vector (3 downto 0);
			Fout : out std_logic_vector (3 downto 0));
end F_Count_4b;

architecture Behav of F_Count_4b is begin
process (Fin)
begin
	case Fin is
	when "0000" => Fout <= "0001";
	when "0001" => Fout <= "0010";
	when "0010" => Fout <= "0011";
	when "0011" => Fout <= "0100";
	when "0100" => Fout <= "0101";
	when "0101" => Fout <= "0110";
	when "0110" => Fout <= "0111";
	when "0111" => Fout <= "1000";
	when "1000" => Fout <= "1001";
	when "1001" => Fout <= "1010";
	when "1010" => Fout <= "1011";
	when "1011" => Fout <= "1100" after 10 ns;
	when "1100" => Fout <= "1101";
	when "1101" => Fout <= "1110";
	when "1110" => Fout <= "1111";
	when "1111" => Fout <= "0000";
	when others => Fout <= "0000";
	end case;

end process;	
end Behav;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

architecture Structural of Counter_4b_RST is

component F_Count_4b is
	port (Fin : in std_logic_vector (3 downto 0);
			Fout : out std_logic_vector (3 downto 0));
end component;

component PIPO_4_RST is
	port (Din : in std_logic_vector(3 downto 0);
		CLK, RST : in std_logic;
		Dout : out std_logic_vector(3 downto 0));
end component;

signal NextState, CurrentState : std_logic_vector (3 downto 0);

begin
	F : F_Count_4b port map (CurrentState, NextState);
	State : PIPO_4_RST port map (NextState, CLK, RST, CurrentState);
	Count <= CurrentState;
end Structural;