--Função principal do laboratório 02.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab02 is 
	port (
		fpga_clk: in std_logic;
		f_j: in std_logic;
		f_k: in std_logic;
		debug_vector: out std_logic_vector (3 downto 0);
		debug_vector2: out std_logic_vector (3 downto 0);
		debug_vector3: out std_logic_vector (3 downto 0);
		debug_vector4: out std_logic_vector (3 downto 0)
	);
end Lab02;

architecture struct of Lab02 is

--signal
signal rstSignal: std_logic;
signal rstSignal2: std_logic;
signal rstCtrl: std_logic_vector (3 downto 0);
signal rstCtrl2: std_logic_vector (3 downto 0);
signal q_out: std_logic_vector (3 downto 0);
signal q_out2: std_logic_vector (3 downto 0);
signal auxV: std_logic_vector (4 downto 0);
signal auxV2: std_logic_vector (4 downto 0);

--component 
component jk_ff
port (j, k, clk, reset, preset: in std_logic;		
	  q, qb: out std_logic);
end component;

--component
component fourBitsAdder
port (	a, b: in std_logic_vector (3 downto 0);
		c_in: in std_logic; 
		s: out std_logic_vector (4 downto 0));
end component;

	begin
		control_ffjk1: jk_ff port map (j => f_j, k => f_k, clk => ((not q_out(3)) and (not q_out(1))) xor rstSignal, reset => '0', preset => '0', q => rstSignal);
		rstCtrl <=  (rstSignal & rstSignal & rstSignal & rstSignal);
		
		flip_flop1: jk_ff port map (j => f_j, k => f_k, clk => fpga_clk, reset => rstCtrl(0), preset => '0', q => q_out(0)); 
		flip_flop2: jk_ff port map (j => f_j, k => f_k, clk => q_out(0), reset => rstCtrl(1), preset => '0', q => q_out(1)); 
		flip_flop3: jk_ff port map (j => f_j, k => f_k, clk => q_out(1), reset => rstCtrl(2), preset => '0', q => q_out(2)); 
		flip_flop4: jk_ff port map (j => f_j, k => f_k, clk => q_out(2), reset => rstCtrl(3), preset => '0', q => q_out(3)); 

		control_ffjk2: jk_ff port map (j => f_j, k => f_k, clk => ((not q_out2(3)) and (not q_out2(1))) xor rstSignal2, reset => '0', preset => '0', q => rstSignal2);
		rstCtrl2 <=  (rstSignal2 & rstSignal2 & rstSignal2 & rstSignal2);

		flip_flop5: jk_ff port map (j => f_j, k => f_k, clk => rstSignal, reset => rstCtrl2(0), preset => '0', q => q_out2(0)); 
		flip_flop6: jk_ff port map (j => f_j, k => f_k, clk => q_out2(0), reset => rstCtrl2(1), preset => '0', q => q_out2(1)); 
		flip_flop7: jk_ff port map (j => f_j, k => f_k, clk => q_out2(1), reset => rstCtrl2(2), preset => '0', q => q_out2(2)); 
		flip_flop8: jk_ff port map (j => f_j, k => f_k, clk => q_out2(2), reset => rstCtrl2(3), preset => '0', q => q_out2(3)); 
	
		debug_vector <= not q_out;
		debug_vector2 <= not q_out2;

		subtractor1: fourBitsAdder port map (a => q_out, b => '1' & '0' & '0' & '1', c_in => '1', s => auxV);
		subtractor2: fourBitsAdder port map (a => q_out2, b => '1' & '0' & '0' & '1', c_in => '1', s => auxV2);

		debug_vector3 <= auxV (3 downto 0);
		debug_vector4 <= auxV2 (3 downto 0);

	end struct;
