Library IEEE;
use ieee.std_logic_1164.all;

entity MathGame is
    port (
        fpgaClk: in std_logic;
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector (3 downto 0)
    );
end MathGame;

architecture struct of MathGame is

-- first component -> (countdown counter).

-- second component -> (0-F state machine) - (values and score).

-- third component -> (0-5 state machine) - (operations).

    begin 


    end struct;