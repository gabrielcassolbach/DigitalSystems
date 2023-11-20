Library IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity MathGame is
    port (
        fpgaClk: in std_logic;
        fastClk: in std_logic;
        pb0: in std_logic;
        sw_keys: in std_logic_vector (4 downto 0);
        ula: out std_logic;
        muxOut: out std_logic_vector (3 downto 0);
        hex0, hex1, hex2, hex3, hex4, hex5: out std_logic_vector (3 downto 0)
    );
end MathGame;

architecture struct of MathGame is

--signals
signal auxv1, auxv2, auxop, auxscr: std_logic_vector (3 downto 0);
signal dig1Time, dig2Time: std_logic_vector (3 downto 0);
signal rstScore: std_logic;
signal ulaOutput: std_logic;
signal scoreSum: unsigned (3 downto 0);
signal auxScoreSum: unsigned (3 downto 0);
signal muxOutput: unsigned (3 downto 0);

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

    begin 
    -------------------------------------------------------------------------------------------------------------------------------------------
    -- Project Engine
    -----------------
    decisionUnit: gameController port map (sw_keys => sw_keys, v1 => auxv1, v2 => auxv2, operation => auxop, playResult => ulaOutput);
    
    -------------------------------------------------------------------------------------------------------------------------------------------
    -- Project Units
    ----------------
    playerTime: countdownCounter port map (clk => fpgaClk, rstCounter => '1', digit1 => dig1Time, digit2 => dig2Time);

    value1: counter09 port map (clk => fastClk and (not pb0), rstCounter => '1', outDigits => auxv1);
    
    operation: counter04 port map (clk => fastClk and (not pb0), rstCounter => '1', outDigits => auxop);
    
    value2: counter09 port map (clk => fastClk and (not pb0), rstCounter => '1', outDigits => auxv2);
        
    score: playerScore port map (clk => pb0, enableClk => ulaOutput, rstCounter => rstScore, outDigits => auxscr);

    rstScore <= '0' when dig1Time = "0000" and dig2Time = "0000" else '1'; 
    -------------------------------------------------------------------------------------------------------------------------------------------
    -- Project Output
    -----------------
    hex0 <= auxscr;
    hex1 <= auxv2;
    hex2 <= auxop;
    hex3 <= auxv1;
    hex4 <= dig1Time;
    hex5 <= dig2Time;
    ula <= ulaOutput;
    --muxOut <= 
    -------------------------------------------------------------------------------------------------------------------------------------------
    end struct;