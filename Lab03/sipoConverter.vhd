Library IEEE;
use ieee.std_logic_1164.all;

entity sipoConverter is
    port (
       serial_in: in std_logic;
       key1: in std_logic;
       q: out std_logic_vector (7 downto 0)
    );
end sipoConverter;

architecture gate_level of sipoConverter is

--signal
signal auxq: std_logic_vector (7 downto 0);
signal key1V: std_logic_vector (7 downto 0);

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
    --flip-flops:
    flip_flop1: jk_ff port map (j => serial_in, k => not serial_in, clk => key1, reset => '0', preset => '0', q => auxq(0));
    flip_flop2: jk_ff port map (j => auxq(0) and (not key1), k => not (auxq(0) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(1));
    flip_flop3: jk_ff port map (j => auxq(1) and (not key1), k => not (auxq(1) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(2));
    flip_flop4: jk_ff port map (j => auxq(2) and (not key1), k => not (auxq(2) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(3));
    flip_flop5: jk_ff port map (j => auxq(3) and (not key1), k => not (auxq(3) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(4));
    flip_flop6: jk_ff port map (j => auxq(4) and (not key1), k => not (auxq(4) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(5));
    flip_flop7: jk_ff port map (j => auxq(5) and (not key1), k => not (auxq(5) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(6));
    flip_flop8: jk_ff port map (j => auxq(6) and (not key1), k => not (auxq(6) and (not key1)), clk => key1, reset => '0', preset => '0', q => auxq(7));
    --output:
    q <= auxq;
    end gate_level;