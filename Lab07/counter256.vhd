Library IEEE;
use ieee.std_logic_1164.all;

-- contador de 00 a FF. (contador de 0 a 255 síncrono).

entity counter256 is
    port (
        clk: in std_logic;
        firstDigit: out std_logic_vector(3 downto 0); --bits menos significativos.
        secondDigit: out std_logic_vector(3 downto 0)  --bits mais significativos.
    );
end counter256;

architecture struct of counter256 is

--signal
signal machine1to2ctrl: std_logic;
signal machine2to1ctrl: std_logic := '0';

--component
component stateMachine is
port ( clk: in std_logic;
       rst: in std_logic;
       outClk: out std_logic;
       outputDigits: out std_logic_vector (3 downto 0));
end component;

    begin    
    digit1: stateMachine port map (clk => clk, rst => '1', outputDigits => firstDigit, outClk => machine1to2ctrl);
    digit2: stateMachine port map (clk => machine1to2ctrl, rst => '1', outputDigits => secondDigit, outClk => machine2to1ctrl);
    end struct;
