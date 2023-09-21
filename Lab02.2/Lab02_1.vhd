--Função principal do laboratório 02.
Library IEEE;
use ieee.std_logic_1164.all;

entity Lab02_1 is 
	port (  key1: in std_logic;
            sw_keys: in std_logic_vector (3 downto 0);
            display1: out std_logic_vector (3 downto 0);
            display2: out std_logic_vector (3 downto 0);
            display3: out std_logic_vector (3 downto 0);
            display4: out std_logic_vector (3 downto 0);
            display5: out std_logic_vector (3 downto 0);
            display6: out std_logic_vector (3 downto 0)
        );
end Lab02_1;

architecture struct of Lab02_1 is

--signal
signal clk: std_logic;
signal registerOutput01: std_logic_vector (3 downto 0);
signal registerOutput02: std_logic_vector (3 downto 0);
signal registerOutput03: std_logic_vector (3 downto 0);
signal registerOutput04: std_logic_vector (3 downto 0);
signal registerOutput05: std_logic_vector (3 downto 0);
signal registerOutput06: std_logic_vector (3 downto 0);


component fourBitsRegister is
port (  rclk: in std_logic;
        d: in std_logic_vector (3 downto 0);
        q: out std_logic_vector (3 downto 0));
end component;
   
    begin
        clk <= not key1;
        register01: fourBitsRegister port map (rclk => clk, d => sw_keys, q => registerOutput01);
        register02: fourBitsRegister port map (rclk => clk, d => registerOutput01, q => registerOutput02);
        register03: fourBitsRegister port map (rclk => clk, d => registerOutput02, q => registerOutput03);
        register04: fourBitsRegister port map (rclk => clk, d => registerOutput03, q => registerOutput04);
        register05: fourBitsRegister port map (rclk => clk, d => registerOutput04, q => registerOutput05);
        register06: fourBitsRegister port map (rclk => clk, d => registerOutput05, q => registerOutput06);

        display1 <= registerOutput01;
        display2 <= registerOutput02;
        display3 <= registerOutput03;
        display4 <= registerOutput04;
        display5 <= registerOutput05;
        display6 <= registerOutput06;
        
    end struct;