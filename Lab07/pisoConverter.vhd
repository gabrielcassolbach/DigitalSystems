Library IEEE;
use ieee.std_logic_1164.all;

-- pisoConverter working correctly.
entity pisoConverter is
    port (
        sw_keys: in std_logic_vector (7 downto 0);
        key0, key1: in std_logic;
        s_out: out std_logic
    );
end pisoConverter;

architecture gate_level of pisoConverter is

--signals
signal auxKey1: std_logic;
signal muxOut: std_logic_vector (7 downto 0);
signal ffsOut: std_logic_vector (7 downto 0);

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
    auxKey1 <= (not (not key1));

    -- flip-flops.
    flip_flop1: jk_ff port map (j => muxOut(0), k => not muxOut(0), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(0));
    flip_flop2: jk_ff port map (j => muxOut(1), k => not muxOut(1), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(1));
    flip_flop3: jk_ff port map (j => muxOut(2), k => not muxOut(2), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(2));
    flip_flop4: jk_ff port map (j => muxOut(3), k => not muxOut(3), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(3));
    flip_flop5: jk_ff port map (j => muxOut(4), k => not muxOut(4), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(4));
    flip_flop6: jk_ff port map (j => muxOut(5), k => not muxOut(5), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(5));
    flip_flop7: jk_ff port map (j => muxOut(6), k => not muxOut(6), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(6));
    flip_flop8: jk_ff port map (j => muxOut(7), k => not muxOut(7), clk => auxKey1 and key0, reset => '0', preset => '0', q => ffsOut(7));

    -- multiplexors.
    mux01: multiplex port map (control_signal => key0, a => sw_keys(0), b => '0', c => muxOut(0));
    mux02: multiplex port map (control_signal => key0, a => sw_keys(1), b => ffsOut(0), c => muxOut(1));
    mux03: multiplex port map (control_signal => key0, a => sw_keys(2), b => ffsOut(1), c => muxOut(2));
    mux04: multiplex port map (control_signal => key0, a => sw_keys(3), b => ffsOut(2), c => muxOut(3));
    mux05: multiplex port map (control_signal => key0, a => sw_keys(4), b => ffsOut(3), c => muxOut(4));
    mux06: multiplex port map (control_signal => key0, a => sw_keys(5), b => ffsOut(4), c => muxOut(5));
    mux07: multiplex port map (control_signal => key0, a => sw_keys(6), b => ffsOut(5), c => muxOut(6));
    mux08: multiplex port map (control_signal => key0, a => sw_keys(7), b => ffsOut(6), c => muxOut(7));
    
    --output.
    s_out <= ffsOut(7);
    
    end gate_level;

