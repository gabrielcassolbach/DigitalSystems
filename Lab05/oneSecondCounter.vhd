Library IEEE;
use ieee.std_logic_1164.all;

entity oneSecondCounter is
    port (
       initialClk: in std_logic;
       outputClk: out std_logic;
       firstDigit: out std_logic_vector (3 downto 0);
       secondDigit: out std_logic_vector (3 downto 0);
       thirdDigit: out std_logic_vector (3 downto 0)
    );
end oneSecondCounter;

architecture struct of oneSecondCounter is

--signals
------------------------------------------------
signal q_out: std_logic_vector (3 downto 0);
signal q_out1: std_logic_vector (3 downto 0);
signal q_out2: std_logic_vector (3 downto 0);
------------------------------------------------
signal rstCtrl: std_logic_vector (3 downto 0);
signal rstCtrl2: std_logic_vector (3 downto 0);
signal rstCtrl3: std_logic_vector (3 downto 0);
------------------------------------------------
signal rstSignal: std_logic;
signal rstSignal2: std_logic;
signal rstSignal3: std_logic;
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

    -- second digit.
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    control_ffjk2: jk_ff port map (j => '1', k => '1', clk => ((not q_out1(3)) and (not q_out1(1))) xor rstSignal2, reset => '0', preset => '0', q => rstSignal2);
	rstCtrl2 <=  (rstSignal2 & rstSignal2 & rstSignal2 & rstSignal2);
    
    flip_flop5: jk_ff port map (j => '1', k => '1', clk => rstSignal, reset => rstCtrl2(0), preset => '0', q => q_out1(0)); 
	flip_flop6: jk_ff port map (j => '1', k => '1', clk => q_out1(0), reset => rstCtrl2(1), preset => '0', q => q_out1(1)); 
	flip_flop7: jk_ff port map (j => '1', k => '1', clk => q_out1(1), reset => rstCtrl2(2), preset => '0', q => q_out1(2)); 
	flip_flop8: jk_ff port map (j => '1', k => '1', clk => q_out1(2), reset => rstCtrl2(3), preset => '0', q => q_out1(3)); 

    secondDigit <= not q_out1;
    ------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- third digit.
    ------------------------------------------------------------------------------------------------------------------------------------------------------------
    control_ffjk3: jk_ff port map (j => '1', k => '1', clk => ((not q_out2(3)) and (not q_out2(1))) xor rstSignal3, reset => '0', preset => '0', q => rstSignal3);
	rstCtrl3 <=  (rstSignal3 & rstSignal3 & rstSignal3 & rstSignal3);

    flip_flop9: jk_ff port map (j => '1', k => '1', clk => rstSignal2, reset => rstCtrl3(0), preset => '0', q => q_out2(0)); 
	flip_flop10: jk_ff port map (j => '1', k => '1', clk => q_out2(0), reset => rstCtrl3(1), preset => '0', q => q_out2(1)); 
	flip_flop11: jk_ff port map (j => '1', k => '1', clk => q_out2(1), reset => rstCtrl3(2), preset => '0', q => q_out2(2)); 
	flip_flop12: jk_ff port map (j => '1', k => '1', clk => q_out2(2), reset => rstCtrl3(3), preset => '0', q => q_out2(3)); 

    thirdDigit <= not q_out2;
    ------------------------------------------------------------------------------------------------------------------------------------------------------------

    --> clock that controls next counter:
    outputClk <= rstSignal3;

    end struct;