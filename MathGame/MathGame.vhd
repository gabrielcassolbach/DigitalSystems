Library IEEE;
use ieee.std_logic_1164.all;

entity MathGame is
    port (
        fpgaClk: in std_logic;
        pb0: in std_logic;
        sw_keys: in std_logic_vector (4 downto 0);
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector (6 downto 0)
    );
end MathGame;

architecture struct of MathGame is

--signals
signal auxv1, auxv2, auxop, auxscr: std_logic_vector (3 downto 0); 
signal dig1Time, dig2Time: std_logic_vector (3 downto 0);
signal clk1hz, fastClk1, fastClk2, fastClk3: std_logic;
signal rstScore: std_logic;
signal ulaOutput: std_logic;

--component -> (countdown counter).
component countdownCounter is
port (  clk: in std_logic;
        rstCounter: in std_logic;
        digit1: out std_logic_vector (3 downto 0);
        digit2: out std_logic_vector (3 downto 0));
end component;

--component -> (0-9 state machine) - (values and score).
component counter09 is
port (  clk: in std_logic;
        rstCounter: in std_logic;
        outDigits: out std_logic_vector (3 downto 0));
end component;

--component -> (0-4 state machine) - (operations).
component counter04 is
port (  clk: in std_logic;
        rstCounter: in std_logic;
        outDigits: out std_logic_vector (3 downto 0));
end component;

--component -> arithmetic and logic unit - (ula).
component gameController is
port (  sw_keys: in std_logic_vector (4 downto 0);
        v1, v2, operation: in std_logic_vector (3 downto 0);
        playResult: out std_logic);
end component;

--component 
component playerScore is
port (  clk: in std_logic;
        enableClk: in std_logic;
        rstCounter: in std_logic;
        outDigits: out std_logic_vector (3 downto 0));
end component;

--component 
component clockConverter1 is
port ( clk: in std_logic;
       clk1Hz: out std_logic);
end component;

--component
component clockConverter2 is
port ( clk: in std_logic; 
       fastClk1: out std_logic);
end component;

--component
component clockConverter3 is
port ( clk: in std_logic; 
       fastClk2: out std_logic);
end component;

--component
component clockConverter4 is
port ( clk: in std_logic; 
       fastClk3: out std_logic);
end component;

--component
component display_converter is
port (  x: in std_logic_vector (3 downto 0);
	seg: out std_logic_vector (6 downto 0));
end component;

    begin 
    -------------------------------------------------------------------------------------------------------------------------------------------
    -- Project Engine
    -----------------
    decisionUnit: gameController port map (sw_keys => sw_keys, v1 => auxv1, v2 => auxv2, operation => auxop, playResult => ulaOutput); 

    timeClk: clockConverter1 port map (clk => fpgaClk, clk1Hz => clk1hz); -- clock de 1Hz.

    value1Clk: clockConverter2 port map (clk => fpgaClk, fastClk1 => fastClk1); -- clock de 90Hz.

    opClk: clockConverter3 port map (clk => fpgaClk, fastClk2 => fastClk2); -- clock de 45Hz.

    value2Clk: clockConverter4 port map (clk => fpgaClk, fastClk3 => fastClk3); -- clock de 135 Hz.

    rstScore <= '0' when ((dig1Time = "0000" and dig2Time = "0000") and clk1hz = '1') else '1'; 
    -------------------------------------------------------------------------------------------------------------------------------------------
    -- Project Units
    ----------------
    playerTime: countdownCounter port map (clk => clk1hz, rstCounter => rstScore, digit1 => dig1Time, digit2 => dig2Time);
    
    value1: counter09 port map (clk => fastClk1 and (not pb0), rstCounter => '1', outDigits => auxv1);
    
    operation: counter04 port map (clk => fastClk2 and (not pb0), rstCounter => '1', outDigits => auxop);
    
    value2: counter09 port map (clk => fastClk3 and (not pb0), rstCounter => '1', outDigits => auxv2);
        
    score: playerScore port map (clk => pb0, enableClk => ulaOutput, rstCounter => rstScore, outDigits => auxscr);
    -------------------------------------------------------------------------------------------------------------------------------------------
    -- Project Output
    -----------------
    hex00: display_converter port map (x => auxscr, seg => hex0);
    hex01: display_converter port map (x => auxv2, seg => hex1);
    hex02: display_converter port map (x => auxop, seg => hex2);
    hex03: display_converter port map (x => auxv1, seg => hex3);
    hex04: display_converter port map (x => dig1Time, seg => hex4);
    hex05: display_converter port map (x => dig2Time, seg => hex5);
    -------------------------------------------------------------------------------------------------------------------------------------------
    end struct;