-- Laboratório 07 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab07 is
    port (
        fpgaClk: in std_logic;
        pisoin: in std_logic_vector(7 downto 0); -- piso input.
        dcounterClk: out std_logic;
        dclk0: out std_logic;
        dclk1: out std_logic;
        digit3: out std_logic_vector(3 downto 0)  -- state of detector.
    );
end Lab07;

architecture struct of Lab07 is

--signals 
signal pisoOutput: std_logic;
signal clk0: std_logic;
signal clk1: std_logic;
signal counterClk: std_logic;
signal invertedInput: std_logic_vector(7 downto 0);
--signal counterDig1: std_logic_vector(3 downto 0);
--signal counterDig2: std_logic_vector(3 downto 0);
--signal memoryOutput: std_logic_vector(7 downto 0);

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
--component memox is 
--port ( address: in std_logic_vector (7 downto 0);
--       clock: in std_logic := '1';
--       q: out std_logic_vector (7 downto 0));
--end component;

    begin 
    -----------------------------------------------------------------------------------------------------------------
    controller: clkController port map (fpgaClk => fpgaClk, rst => '1', counterClk => counterClk, clk0 => clk0, clk1 => clk1);

    bitsinversor: invertsInput port map (q0 => pisoin, q1 => invertedInput);
       
    --counter: counter256 port map (clk => , firstDigit => counterDig1, secondDigit => counterDig2); -- ok. 
    
    --memory: memox port map (clock => ,address => counterDig1 & counterDig2, q => memoryOutput); 
    
    piso: pisoConverter port map (sw_keys => invertedInput, key0 => clk0, key1 => clk1, s_out => pisoOutput); --key0 = 0 
	
    detector: seqDetector port map (inputDigit => pisoOutput, clk => clk1, reset_n => clk0, outDigits => digit3);

    --simulation:
    dcounterClk <= counterClk;
    dclk0 <= clk0;
    dclk1 <= clk1;
    -----------------------------------------------------------------------------------------------------------------
    end struct;
