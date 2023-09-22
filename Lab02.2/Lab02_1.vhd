Library IEEE;
use ieee.std_logic_1164.all;

entity Lab02_1 is 
	port (  key0: in std_logic;
                fpga_clk: in std_logic;
                sw_choice: in std_logic;
                sw_keys: in std_logic_vector (3 downto 0);
                hex0: out std_logic_vector (6 downto 0);
                hex1: out std_logic_vector (6 downto 0);
                hex2: out std_logic_vector (6 downto 0);
                hex3: out std_logic_vector (6 downto 0);
                hex4: out std_logic_vector (6 downto 0);
                hex5: out std_logic_vector (6 downto 0)
        );
end Lab02_1;

architecture struct of Lab02_1 is

--signal
signal rightClk: std_logic;
signal registerOutput01: std_logic_vector (3 downto 0);
signal registerOutput02: std_logic_vector (3 downto 0);
signal registerOutput03: std_logic_vector (3 downto 0);
signal registerOutput04: std_logic_vector (3 downto 0);
signal registerOutput05: std_logic_vector (3 downto 0);
signal registerOutput06: std_logic_vector (3 downto 0);
signal mux01_output: std_logic_vector (3 downto 0);
signal mux02_output: std_logic_vector (3 downto 0);
signal adderSubtractorOutput: std_logic_vector (4 downto 0);

--component
component clock_converter
port (	clk: in std_logic; 
        clk_2Hz: out std_logic);
end component;

--component 
component fourBitsAdder is
port (  a: in std_logic_vector (3 downto 0);
        b: in std_logic_vector (3 downto 0);
        c_in: in std_logic;
        s: out std_logic_vector (4 downto 0));
end component;

--component
component multiplex is 
port (  control_signal: in std_logic; 
        a, b: in std_logic_vector (3 downto 0);
        c: out std_logic_vector (3 downto 0));
end component;

--component
component fourBitsRegister is
port (  rclk: in std_logic;
        d: in std_logic_vector (3 downto 0);
        q: out std_logic_vector (3 downto 0));
end component;
   
--component 
component display_converter
port (	x: in std_logic_vector (3 downto 0);
	seg: out std_logic_vector (6 downto 0));
end component;
  
    begin
        clk_converter: clock_converter port map (clk => fpga_clk, clk_2Hz => rightClk);

        register01: fourBitsRegister port map (rclk => rightClk, d => sw_keys, q => registerOutput01 );
        register02: fourBitsRegister port map (rclk => rightClk, d => registerOutput01, q => registerOutput02 );
        register03: fourBitsRegister port map (rclk => rightClk, d => registerOutput02, q => registerOutput03 );
        register04: fourBitsRegister port map (rclk => rightClk, d => registerOutput03, q => registerOutput04 );
        register05: fourBitsRegister port map (rclk => rightClk and key0, d => mux01_output, q => registerOutput05 );
        register06: fourBitsRegister port map (rclk => rightClk and key0, d => mux02_output, q => registerOutput06 );

        adder_subtractor: fourBitsAdder port map (a => registerOutput01, b => registerOutput02, c_in => sw_choice, s => adderSubtractorOutput);
        
        multiplexer: multiplex port map (control_signal => not key0, a => registerOutput04, b => adderSubtractorOutput (3 downto 0), c => mux01_output);
        multiplexer02: multiplex port map (control_signal => not key0, a => registerOutput05, b => '0' & '0' & '0' & (adderSubtractorOutput(4) and not sw_choice), c => mux02_output);

        display01: display_converter port map (x => registerOutput01, seg => hex0);
        display02: display_converter port map (x => registerOutput02, seg => hex1);
        display03: display_converter port map (x => registerOutput03, seg => hex2);
        display04: display_converter port map (x => registerOutput04, seg => hex3);
        display05: display_converter port map (x => registerOutput05, seg => hex4);
        display06: display_converter port map (x => registerOutput06, seg => hex5);
    end struct;