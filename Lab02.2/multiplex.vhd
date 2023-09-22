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

--signal 
signal controlSignalVector: std_logic_vector (3 downto 0);

begin
    controlSignalVector <= control_signal & control_signal & control_signal & control_signal;
    c <= (a and controlSignalVector) or (b and not controlSignalVector); 
end struct;