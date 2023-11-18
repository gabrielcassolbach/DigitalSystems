-- Laboratório 07 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab07 is
    port (
        fpgaClk: in std_logic;
        pisoin: in std_logic_vector(7 downto 0); -- piso input.
        dcounterClk, dclk0, dclk1, drclk: out std_logic;
        digit3: out std_logic_vector(3 downto 0)  -- state of detector.
        --hex0, hex1, hex2, hex3, hex5: out std_logic_vector(6 downto 0); 
    );
end Lab07;

architecture struct of Lab07 is

--signals 
signal pisoOutput: std_logic;
signal detectorOutput: std_logic_vector(3 downto 0);
signal slwClk: std_logic;
signal clk0: std_logic;
signal clk1: std_logic;
signal counterClk: std_logic;
signal startStopClk: std_logic;
signal rclk: std_logic;
signal startStopOutput: std_logic;
signal invertedInput: std_logic_vector(7 downto 0);
--signal counterDig1: std_logic_vector(3 downto 0);
--signal counterDig2: std_logic_vector(3 downto 0);
--signal memoryOutput: std_logic_vector(7 downto 0);

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
       q, qb: out std_logic);
end component;

--component 
component clock_converter is
port ( clk: in std_logic; 
	slowClk: out std_logic);
end component;

--component
component multiplex is 
port (  a, b: in std_logic;
        control_signal: in std_logic; 
        c: out std_logic);
end component;

--component
component pisoConverter is
port ( sw_keys: in std_logic_vector (7 downto 0);
       key0: in std_logic;
       key1: in std_logic;
       s_out: out std_logic);
end component;

--component
component seqDetector is
port ( clk: in std_logic;
       inputDigit: in std_logic;
       reset_n: in std_logic;
       outDigits: out std_logic_vector (3 downto 0));
end component;

--component
component clkController is
port (  fpgaClk: in std_logic;
        rst: in std_logic;
        counterClk: out std_logic;
        clk0: out std_logic;
        clk1: out std_logic);
end component;

--component
component counter256 is
port (  clk: in std_logic;
        firstDigit: out std_logic_vector(3 downto 0);
        secondDigit: out std_logic_vector(3 downto 0));
end component;

--component 
component invertsInput is
port ( q0: in std_logic_vector (7 downto 0);
       q1: out std_logic_vector (7 downto 0));
end component;

--component 
component display_converter is
port (  x: in std_logic_vector (3 downto 0);
		seg: out std_logic_vector (6 downto 0));
end component;

--component
component seq is
port ( d: in std_logic_vector (3 downto 0); 
       outSignal: out std_logic);
end component;

--component 
--component memox is 
--port ( address: in std_logic_vector (7 downto 0);
--       clock: in std_logic := '1';
--       q: out std_logic_vector (7 downto 0));
--end component;

    begin 
    -------------------------------------------------------------------------------------------------------------------
    -- Project Engine --
    --------------------
    --clkConversor: clock_converter port map (clk => fpgaClk, slowClk => slwClk);
    
    seqIdentifier: seq port map (d => detectorOutput, outSignal => startStopClk);

    startStopControl: jk_ff port map (j => '1', k => '1', clk => pb0 and startStopClk, reset => '0', preset => '0', q => startStopOutput);
    
    mux: multiplex port map (control_signal => startStopOutput, a => fpgaClk, b => '0', c => rclk); -- insert slwClk.

    controller: clkController port map (fpgaClk => rclk, rst => '1', counterClk => counterClk, clk0 => clk0, clk1 => clk1);
    -------------------------------------------------------------------------------------------------------------------
    -- Project Units --
    -------------------
    --counter: counter256 port map (clk => counterClk, firstDigit => counterDig1, secondDigit => counterDig2); 
    
    --memory: memox port map (clock => (not counterClk), address => counterDig1 & counterDig2, q => memoryOutput); 
    
    bitsinversor: invertsInput port map (q0 => pisoin, q1 => invertedInput); -- change pisoin to memoryOutput.
    
    piso: pisoConverter port map (sw_keys => invertedInput, key0 => clk0, key1 => clk1, s_out => pisoOutput); 
	
    detector: seqDetector port map (inputDigit => pisoOutput, clk => clk1, reset_n => clk0, outDigits => detectorOutput);

    -------------------------------------------------------------------------------------------------------------------
    -- Output -- 
    ------------
    --display00: display_converter port map (x => memoryOutput (3 downto 0), seg => hex0);
    --display01: display_converter port map (x => memoryOutput (7 downto 4), seg => hex1);
    --display02: display_converter port map (x => pisoin (3 downto 0), seg => hex2);
    --display03: display_converter port map (x => pisoin (7 downto 4), seg => hex3);
    --display05: display_converter port map (x => detectorOutput, seg => hex5);
    -------------------------------------------------------------------------------------------------------------------
    -- simulation:
    dcounterClk <= counterClk;
    dclk0 <= clk0;
    dclk1 <= clk1;
    digit3 <= detectorOutput;
    drclk <= rclk;
    ------------------------------------------------------------------------------------------------------------------
    end struct;
