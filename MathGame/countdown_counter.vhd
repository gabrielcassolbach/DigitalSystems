Library IEEE;
use ieee.std_logic_1164.all;

entity countdown_counter is
    port (
        clk: in std_logic;
        rstCounter: in std_logic;
        digit1: out std_logic_vector (3 downto 0);
        digit2: out std_logic_vector (3 downto 0)
    );
end countdown_counter;

architecture struct of countdown_counter is 

--signals
signal machine1to2Clk: std_logic;

-- state machine 1.
component stateMachine1 is
port (  clk: in std_logic;
        rst: in std_logic;
        outClk: out std_logic;
        outDigits: out std_logic_vector (3 downto 0));
end component;

-- state machine 2.
component stateMachine2 is
port (  clk: in std_logic;
        rst: in std_logic;
        outDigits: out std_logic_vector (3 downto 0));
end component;

    begin
    counter1: stateMachine1 port map (clk => clk, rst => rstCounter, outDigits => digit1, outClk => machine1to2Clk);
    counter2: stateMachine2 port map (clk => machine1to2Clk, rst => rstCounter, outDigits => digit2);
    end struct;