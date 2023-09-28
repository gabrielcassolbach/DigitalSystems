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

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
    
    end gate_level;