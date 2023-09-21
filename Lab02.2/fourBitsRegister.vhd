library ieee;
use ieee.std_logic_1164.all;

entity fourBitsRegister is
    port ( 
         rclk: in std_logic;
         d in std_logic_vector (3 downto 0);
         q: out std_logic_vector (3 downto 0));
end fourBitsRegister;

architecture struct of fourBitsRegister is

--component 
component jk_ff
port (	j, k, clk, reset, preset: in std_logic;		
	  	q, qb: out std_logic);
end component;

    begin 
        flip_flop1: jk_ff port map (j => d(0), k => not d(0), clk => rclk, reset => '0', preset => '0', q => q(0));
        flip_flop2: jk_ff port map (j => d(1), k => not d(1), clk => rclk, reset => '0', preset => '0', q => q(1));
        flip_flop3: jk_ff port map (j => d(2), k => not d(2), clk => rclk, reset => '0', preset => '0', q => q(2));
        flip_flop4: jk_ff port map (j => d(3), k => not d(3), clk => rclk, reset => '0', preset => '0', q => q(3));
    end struct;