-- Laboratório 05 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab05 is
    port (
        fpga_clk: in std_logic;
        pb0: in std_logic;
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
signal startStop: std_logic;
signal startStopClk: std_logic;
signal rightClk: std_logic;
signal segToMinClk: std_logic;
signal minToMinClk: std_logic;
signal rclk: std_logic;
signal d1, d2, d3, d4, d5, d6: std_logic_vector (3 downto 0) := "0000"; 

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

--component
component seq is
    port (
        d1, d2, d3, d4, d5, d6: in std_logic_vector (3 downto 0); -- 5 -> 0101
        outSignal: out std_logic
    );
end component;

--component
component clock_converter
port (	clk: in std_logic; 
        clk1Hz: out std_logic);
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
    --------------------------------------------------------------------------------------------------------------------------------------------------------------
    seqIdentifier: seq port map (d1 => d1, d2 => d2, d3 => d3, d4 => d4, d5 => d5, d6 => d6, outSignal => startStopClk);
    startStopControl: jk_ff port map (j => '1', k => '1', clk => pb0 and startStopClk, reset => '0', preset => '0', q => startStop);
    mux: multiplex port map (control_signal => startStop, a => fpga_clk, b => '0', c => rclk); --> control_signal = 1 pass b else pass a. 

    --firstCounter: oneSecondCounter port map (initialClk => rclk, outputClk => segToMinClk, firstDigit => d1, secondDigit => d2, thirdDigit => d3);
    secondCounter: oneMinuteCounter port map (initialClk => rclk, outputClk => minToMinClk, firstDigit => d4, secondDigit => d5);
    thirdCounter: nineMinutesCounter port map (initialClk => minToMinClk, firstDigit => d6);

    --- output.
    digit1 <= d1;
    digit2 <= d2;
    digit3 <= d3;
    digit4 <= d4;
    digit5 <= d5;
    digit6 <= d6;
    --------------------------------------------------------------------------------------------------------------------------------------------------------------
    end struct;