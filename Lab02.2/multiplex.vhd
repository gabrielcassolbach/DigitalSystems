Library IEEE;
use ieee.std_logic_1164.all;

entity multiplex is 
    port( 
        control_signal: in std_logic; 
        a, b: in std_logic_vector (3 downto 0);
        c: out std_logic_vector (3 downto 0)
    );
end multiplex;

architecture struct of multiplex is 

begin
    c <= a when control_signal = '0' else b; 
end struct;