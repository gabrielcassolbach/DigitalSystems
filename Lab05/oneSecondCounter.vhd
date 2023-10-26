Library IEEE;
use ieee.std_logic_1164.all;

entity oneSecondCounter is
    port (
       initialClk: in std_logic;
       outputClk: out std_logic;
       firstDigit: out std_logic_vector (3 downto 0);
       secondDigit: out std_logic_vector (3 downto 0);
       thirdDigit: out std_logic_vector (3 downto 0)
    );
end oneSecondCounter;

architecture struct of oneSecondCounter is

--signals
signal digit1to2Clk: std_logic;
signal digit2to3Clk: std_logic;

--component
component firstStateMachine is
port ( clk: in std_logic;
       outClk: out std_logic;
       outputDigits: out std_logic_vector (3 downto 0));
end component;
    
    begin 
    digit1: firstStateMachine port map (clk => initialClk, outputDigits => firstDigit, outClk => digit1to2Clk);
    digit2: firstStateMachine port map (clk => digit1to2Clk, outputDigits => secondDigit, outClk => digit2to3Clk);
    digit3: firstStateMachine port map (clk => digit2to3Clk, outputDigits => thirdDigit, outClk => outputClk);
    end struct;