Library IEEE;
use ieee.std_logic_1164.all;

entity multiplex is 
    port( 
        a, b: in std_logic;
        control_signal: in std_logic; 
        c: out std_logic
    );
end multiplex;

architecture struct of multiplex is 

begin
    c <= b when control_signal = '1' else a;
end struct;