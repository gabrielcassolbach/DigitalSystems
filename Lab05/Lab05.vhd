-- Laboratório 05 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab05 is
    port (
        fpga_clk: in std_logic;
		digit1: out std_logic_vector (3 downto 0); -- 000ms a 999ms
        digit2: out std_logic_vector (3 downto 0); -- 000ms a 999ms 
		digit3: out std_logic_vector (3 downto 0); -- 000ms a 999ms
        digit4: out std_logic_vector (3 downto 0); -- 00 a 59 seg.
        digit5: out std_logic_vector (3 downto 0); -- 00 a 59 seg.
        digit6: out std_logic_vector (3 downto 0) -- 0 a 9 minutos.
    );
end Lab05;

architecture struct of Lab05 is

--signal.
signal segToMinClk: std_logic;
signal minToMinClk: std_logic;

--component
component oneSecondCounter
port ( initialClk: in std_logic;
       outputClk: out std_logic;
       firstDigit: out std_logic_vector (3 downto 0);
       secondDigit: out std_logic_vector (3 downto 0);
       thirdDigit: out std_logic_vector (3 downto 0));
end component;

--component
component oneMinuteCounter is
port ( initialClk: in std_logic;
       outputClk: out std_logic;
       firstDigit: out std_logic_vector (3 downto 0);
       secondDigit: out std_logic_vector (3 downto 0));
end component;

--component
component nineMinutesCounter is
port ( initialClk: in std_logic;
       firstDigit: out std_logic_vector (3 downto 0));
end component;

    begin 
    
    firstCounter: oneSecondCounter port map (initialClk => fpga_clk, outputClk => segToMinClk, firstDigit => digit1, secondDigit => digit2, thirdDigit => digit3);
    secondCounter: oneMinuteCounter port map (initialClk => fpga_clk, outputClk => minToMinClk, firstDigit => digit4, secondDigit => digit5);
    thirdCounter: nineMinutesCounter port map (initialClk => minToMinClk, firstDigit => digit6);
    
    end struct;