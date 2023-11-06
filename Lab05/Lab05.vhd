-- Laboratório 05 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab05 is
    port (
        fpga_clk: in std_logic;
        sw0: in std_logic;
        pb0: in std_logic;
        pb1: in std_logic;
        startStop: out std_logic;
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector (6 downto 0)
    );
end Lab05;

architecture struct of Lab05 is

--signal.
signal startStopAux: std_logic;
signal clkChoice: std_logic;
signal startStopClk: std_logic;
signal rightClk: std_logic;
signal fastClk: std_logic;
signal segToMinClk: std_logic;
signal minToMinClk: std_logic;
signal rclk: std_logic;
signal d1, d2, d3, d4, d5, d6: std_logic_vector (3 downto 0) := "0000"; 

--component
component oneSecondCounter
port ( initialClk: in std_logic;
       rstCtrl: in std_logic;
       outputClk: out std_logic;
       firstDigit: out std_logic_vector (3 downto 0);
       secondDigit: out std_logic_vector (3 downto 0);
       thirdDigit: out std_logic_vector (3 downto 0));
end component;

--component
component oneMinuteCounter is
port ( initialClk: in std_logic;
       rstCtrl: in std_logic;
       outputClk: out std_logic;
       firstDigit: out std_logic_vector (3 downto 0);
       secondDigit: out std_logic_vector (3 downto 0));
end component;

--component
component nineMinutesCounter is
port ( initialClk: in std_logic;
       rstCtrl: in std_logic;
       firstDigit: out std_logic_vector (3 downto 0));
end component;

--component
component seq is
port (  d1, d2, d3, d4, d5, d6: in std_logic_vector (3 downto 0); -- 5 -> 0101
        outSignal: out std_logic);
end component;

--component
component clock_converter
port (	clk: in std_logic; 
        clk1Hz: out std_logic);
end component;

--component
component fastClk_converter
port (	clk: in std_logic; 
        fastClk: out std_logic);
end component;

--component
component display_converter is
    port (  x: in std_logic_vector (3 downto 0);
            seg: out std_logic_vector (6 downto 0));
end component;

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

--component
component multiplex is 
port (  a, b: in std_logic;
        control_signal: in std_logic; 
        c: out std_logic);
end component;

    begin 
    --------------------------------------------------------------------------------------------------------------------------------------------------------------
    --> set clock to 1ms.
    clk_converter: clock_converter port map (clk => fpga_clk, clk1Hz => rightClk);
    converter_fastClk: fastClk_converter port map (clk => fpga_clk, fastClk => fastClk);
    clkChoice <= (rightClk and sw0) or (fastClk and (not sw0));
    --------------------------------------------------------------------------------------------------------------------------------------------------------------
    seqIdentifier: seq port map (d1 => d1, d2 => d2, d3 => d3, d4 => d4, d5 => d5, d6 => d6, outSignal => startStopClk);
    startStopControl: jk_ff port map (j => '1', k => '1', clk => pb0 and startStopClk, reset => '0', preset => '0', q => startStopAux);
    mux: multiplex port map (control_signal => startStopAux, a => clkChoice, b => '0', c => rclk); --> control_signal = 1 pass b else pass a. 

    startStop <= startStopAux;

    firstCounter: oneSecondCounter port map (initialClk => rclk, rstCtrl => pb1, outputClk => segToMinClk, firstDigit => d1, secondDigit => d2, thirdDigit => d3);
    secondCounter: oneMinuteCounter port map (initialClk => segToMinClk, rstCtrl => pb1, outputClk => minToMinClk, firstDigit => d4, secondDigit => d5);
    thirdCounter: nineMinutesCounter port map (initialClk => minToMinClk, rstCtrl => pb1, firstDigit => d6);

    --- output.
    display00: display_converter port map (x => d1, seg => hex0);
    display01: display_converter port map (x => d2, seg => hex1);
    display02: display_converter port map (x => d3, seg => hex2);
    display03: display_converter port map (x => d4, seg => hex3);
    display04: display_converter port map (x => d5, seg => hex4);
    display05: display_converter port map (x => d6, seg => hex5);
    --------------------------------------------------------------------------------------------------------------------------------------------------------------
    end struct;