Library IEEE;
use ieee.std_logic_1164.all;

entity invertsInput is
    port (
       q0: in std_logic_vector (7 downto 0);
       q1: out std_logic_vector (7 downto 0)
    );
end invertsInput;


architecture struct of invertsInput is

    begin 
        q1(0) <= q0(7);
        q1(1) <= q0(6);
        q1(2) <= q0(5);
        q1(3) <= q0(4);
        q1(4) <= q0(3);
        q1(5) <= q0(2);
        q1(6) <= q0(1);
        q1(7) <= q0(0);
    end struct;