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
signal aux_q: std_logic_vector (7 downto 0) := (others => '0');

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
    flip_flop1: jk_ff port map (j => serial_in, k => not serial_in, clk => key1, reset => '0', preset => '0', q => aux_q(0));
    flip_flop2: jk_ff port map (j => aux_q(0) and key1, k => not (aux_q(0) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(1));
    flip_flop3: jk_ff port map (j => aux_q(1) and key1, k => not (aux_q(1) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(2));
    flip_flop4: jk_ff port map (j => aux_q(2) and key1, k => not (aux_q(2) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(3));
    flip_flop5: jk_ff port map (j => aux_q(3) and key1, k => not (aux_q(3) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(4));
    flip_flop6: jk_ff port map (j => aux_q(4) and key1, k => not (aux_q(4) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(5));
    flip_flop7: jk_ff port map (j => aux_q(5) and key1, k => not (aux_q(5) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(6));
    flip_flop8: jk_ff port map (j => aux_q(6) and key1, k => not (aux_q(6) and key1), clk => key1, reset => '0', preset => '0', q => aux_q(7));
    q <= aux_q;
    end gate_level;