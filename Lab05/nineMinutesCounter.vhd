Library IEEE;
use ieee.std_logic_1164.all;

entity nineMinutesCounter is
    port (
       initialClk: in std_logic;
       rstCtrl: in std_logic;
       firstDigit: out std_logic_vector (3 downto 0)
    );
end nineMinutesCounter;

architecture struct of nineMinutesCounter is

 --signals
signal digit1to2Clk: std_logic;

--component
component firstStateMachine is
port ( clk: in std_logic;
       rst: in std_logic;
       outClk: out std_logic;
       outputDigits: out std_logic_vector (3 downto 0));
end component;
    
    begin 
    digit1: firstStateMachine port map (clk => initialClk, rst => rstCtrl, outputDigits => firstDigit, outClk => digit1to2Clk);
    end struct;