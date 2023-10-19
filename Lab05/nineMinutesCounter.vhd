Library IEEE;
use ieee.std_logic_1164.all;

entity nineMinutesCounter is
    port (
       initialClk: in std_logic;
       firstDigit: out std_logic_vector (3 downto 0)
    );
end nineMinutesCounter;

architecture struct of nineMinutesCounter is

--signal
------------------------------------------------
signal q_out: std_logic_vector (3 downto 0);
------------------------------------------------
signal rstCtrl: std_logic_vector (3 downto 0);
------------------------------------------------
signal rstSignal: std_logic;
------------------------------------------------

--component
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
    -- first digit.
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    control_ffjk1: jk_ff port map (j => '1', k => '1', clk => ((not q_out(3)) and (not q_out(1))) xor rstSignal, reset => '0', preset => '0', q => rstSignal);
	rstCtrl <=  (rstSignal & rstSignal & rstSignal & rstSignal);
    
    flip_flop1: jk_ff port map (j => '1', k => '1', clk => initialClk, reset => rstCtrl(0), preset => '0', q => q_out(0)); 
	flip_flop2: jk_ff port map (j => '1', k => '1', clk => q_out(0), reset => rstCtrl(1), preset => '0', q => q_out(1)); 
	flip_flop3: jk_ff port map (j => '1', k => '1', clk => q_out(1), reset => rstCtrl(2), preset => '0', q => q_out(2)); 
	flip_flop4: jk_ff port map (j => '1', k => '1', clk => q_out(2), reset => rstCtrl(3), preset => '0', q => q_out(3)); 

    firstDigit <= not q_out;
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    end struct;