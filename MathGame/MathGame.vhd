Library IEEE;
use ieee.std_logic_1164.all;

entity MathGame is
    port (
        fpgaClk: in std_logic;
        --pb0: in std_logic;
        --sw_keys: in std_logic_vector (3 downto 0);
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector (3 downto 0)
    );
end MathGame;

architecture struct of MathGame is

-- first component -> (countdown counter). (timing simulation working).
component countdown_counter is
port (  clk: in std_logic;
        rstCounter: in std_logic;
        digit1: out std_logic_vector (3 downto 0);
        digit2: out std_logic_vector (3 downto 0));
end component;

-- second component -> (0-F state machine) - (values and score).

-- third component -> (0-5 state machine) - (operations).

    begin 
    playersTime: countdown_counter port map (clk => fpgaClk, rstCounter => '1', digit1 => hex4, digit2 => hex5);

    end struct;