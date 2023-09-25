Library IEEE;
use ieee.std_logic_1164.all;

entity pisoConverter is
    port (
        sw_keys: in std_logic_vector (7 downto 0);
        key0: in std_logic;
        key1: in std_logic;
        s_out: out std_logic
    );
end pisoConverter;

architecture gate_level of pisoConverter is

--signals
signal ff_output01: std_logic := '0';
signal ff_output02: std_logic := '0';
signal ff_output03: std_logic := '0';
signal ff_output04: std_logic := '0';
signal ff_output05: std_logic := '0';
signal ff_output06: std_logic := '0';
signal ff_output07: std_logic := '0';
signal ff_output08: std_logic := '0';

signal mux01_output: std_logic;
signal mux02_output: std_logic;
signal mux03_output: std_logic;
signal mux04_output: std_logic;
signal mux05_output: std_logic;
signal mux06_output: std_logic;
signal mux07_output: std_logic;

--component
component multiplex is 
port (  a, b: in std_logic;
        control_signal: in std_logic; 
        c: out std_logic);
end component;

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
    -- flip-flops.
    flip_flop1: jk_ff port map (j => sw_keys(0), k => not sw_keys(0), clk => key1, reset => '0', preset => '0', q => ff_output01);
    flip_flop2: jk_ff port map (j => mux01_output, k => not mux01_output, clk => key1, reset => '0', preset => '0', q => ff_output02);
    flip_flop3: jk_ff port map (j => mux02_output, k => not mux02_output, clk => key1, reset => '0', preset => '0', q => ff_output03);
    flip_flop4: jk_ff port map (j => mux03_output, k => not mux03_output, clk => key1, reset => '0', preset => '0', q => ff_output04);
    flip_flop5: jk_ff port map (j => mux04_output, k => not mux04_output, clk => key1, reset => '0', preset => '0', q => ff_output05);
    flip_flop6: jk_ff port map (j => mux05_output, k => not mux05_output, clk => key1, reset => '0', preset => '0', q => ff_output06);
    flip_flop7: jk_ff port map (j => mux06_output, k => not mux06_output, clk => key1, reset => '0', preset => '0', q => ff_output07);
    flip_flop8: jk_ff port map (j => mux07_output, k => not mux07_output, clk => key1, reset => '0', preset => '0', q => ff_output08);

    -- multiplexors.
    mux01: multiplex port map (control_signal => key0, a => sw_keys(1), b => ff_output01, c => mux01_output);
    mux02: multiplex port map (control_signal => key0, a => sw_keys(2), b => ff_output02, c => mux02_output);
    mux03: multiplex port map (control_signal => key0, a => sw_keys(3), b => ff_output03, c => mux03_output);
    mux04: multiplex port map (control_signal => key0, a => sw_keys(4), b => ff_output04, c => mux04_output);
    mux05: multiplex port map (control_signal => key0, a => sw_keys(5), b => ff_output05, c => mux05_output);
    mux06: multiplex port map (control_signal => key0, a => sw_keys(6), b => ff_output06, c => mux06_output);
    mux07: multiplex port map (control_signal => key0, a => sw_keys(7), b => ff_output07, c => mux07_output);

    --output.
    s_out <= ff_output08;

    end gate_level;

