Library IEEE;
use ieee.std_logic_1164.all;

entity pisoConverter is
    port ();
end pisoConverter;

architecture gate_level of pisoConverter is

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
    

    end gate_level;

