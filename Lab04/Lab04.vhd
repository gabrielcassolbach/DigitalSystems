-- Laboratório 04 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab04 is
    port (
       fpga_clk: in std_logic;
       hex0: out std_logic_vector (6 downto 0)
    );
end Lab04;

architecture struct of Lab04 is

--signals
signal x: std_logic_vector (3 downto 0) := (others => '0');
signal rightClk: std_logic;
signal j3, k3, j2, k2, j1, k1, j0, k0: std_logic;

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

--component
component clock_converter
port (	clk: in std_logic; 
        slowClk: out std_logic);
end component;

--component
component display_converter is
port (  x: in std_logic_vector (3 downto 0);
		seg: out std_logic_vector (6 downto 0));
end component;

    begin    
    -- set clock to a low frequency
    clk_converter: clock_converter port map (clk => fpga_clk, slowClk => rightClk);

    -- state-machine:
    flip_flop1: jk_ff port map (j => j0, k => k0, clk => rightClk, reset => '0', preset => '0', q => x(0));
    flip_flop2: jk_ff port map (j => j1, k => k1, clk => rightClk, reset => '0', preset => '0', q => x(1));
    flip_flop3: jk_ff port map (j => j2, k => k2, clk => rightClk, reset => '0', preset => '0', q => x(2));
    flip_flop4: jk_ff port map (j => j3, k => k3, clk => rightClk, reset => '0', preset => '0', q => x(3));
    
    --logical-relations:
    j3 <= (x(2) and x(1)) or ((not x(0)) and x(2)); 
    k3 <= ((not x(2)) and (not x(1)) and x(0)) or (x(2) and x(1)); 
    j2 <= ((not x(3)) and x(0)) or (x(3) and x(1)); 
    k2 <= (x(1) and x(0)) or ((not x(3)) and (not x(0))); 
    j1 <= ((not x(2)) and (not x(0))) or (x(3) and x(2)) or (x(2) and x(0));
    k1 <= (x(1) and (not x(2))) or ((not x(3)) and (not x(0))); 
    j0 <= (x(3) and x(2) and x(1)) or ((not x(3)) and (not x(2))) or ((not x(3)) and (not x(1))); 
    k0 <= ((not x(3)) and (not x(1))) or (x(3) and (not x(2)) and (not (x(1)))) or (x(3) and x(2) and x(1)); 

    --output:
    display00: display_converter port map (x => x, seg => hex0);
    end struct;