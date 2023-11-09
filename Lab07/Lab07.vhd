-- Laboratório 07 -> Função principal.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab07 is
    port (
        fpgaClk: in std_logic;
        pisoin: in std_logic_vector(7 downto 0); -- piso input.
        clk1: out std_logic;
        clk2: out std_logic;
        pisOut: out std_logic;
        digit1: out std_logic_vector(3 downto 0); -- first four bits of piso.
        digit2: out std_logic_vector(3 downto 0); -- last four bits of piso.
        digit3: out std_logic_vector(3 downto 0)  -- state of detector.
    );
end Lab07;

architecture struct of Lab07 is

--signals 
signal pisoOutput: std_logic;
signal pisoClk: std_logic;
signal dSeqClk: std_logic;
signal invertedInput: std_logic_vector(7 downto 0);

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
        pisoClk: out std_logic;
        detecSeqClk: out std_logic);
end component;

    begin 
    -----------------------------------------------------------------------------------------------------------------
    digit1 <= pisoin(3 downto 0);
    digit2 <= pisoin(7 downto 4);
    -----------------------------------------------------------------------------------------------------------------
    invertedInput(0) <= pisoin(7);
    invertedInput(1) <= pisoin(6);
    invertedInput(2) <= pisoin(5);
    invertedInput(3) <= pisoin(4);
    invertedInput(4) <= pisoin(3);
    invertedInput(5) <= pisoin(2);
    invertedInput(6) <= pisoin(1);
    invertedInput(7) <= pisoin(0);
    -----------------------------------------------------------------------------------------------------------------
    controller: clkController port map (fpgaClk => fpgaClk, rst => '1', pisoClk => pisoClk, detecSeqClk => dSeqClk);
    -----------------------------------------------------------------------------------------------------------------
    piso: pisoConverter port map (sw_keys => invertedInput, key0 => (not pisoClk), key1 => (not dSeqClk), s_out => pisoOutput);
    pisOut <= pisoOutput;
    clk1 <= pisoClk;
    clk2 <= dSeqClk;
	detector: seqDetector port map (inputDigit => pisoOutput, clk => (not dSeqClk), reset_n => '1', outDigits => digit3);
    -----------------------------------------------------------------------------------------------------------------
    end struct;
