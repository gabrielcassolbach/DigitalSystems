Library IEEE;
use ieee.std_logic_1164.all;

entity clkController is
    port (
        fpgaClk: in std_logic;
        rst: in std_logic;
        counterClk: out std_logic;
        clk0: out std_logic;
        clk1: out std_logic
    );
end clkController;

architecture struct of clkController is

signal v: std_logic_vector (6 downto 0) := "1111111";

    begin 
    process(fpgaClk)
    begin 
        if (rst = '0') then
            v <= "1111111";
        elsif (fpgaClk'event and fpgaClk = '1') then 
            case v is 
            when "0010001" =>   -- 19
                    v <= "1010001";
            when "1010001" =>   -- 1
                    v <= "1000001";
			when "1000001" =>   -- 2
                    v <= "1011111";
			when "1011111" =>   -- 3
                    v <= "1010101";
            when "1010101" =>   -- 3.1
                    v <= "1110000";
			when "1110000" =>   -- 4
                    v <= "1110001";
			when "1110001" =>   -- 5
                    v <= "1110010"; 
			when "1110010" =>   -- 6
                    v <= "1110011";
			when "1110011" =>   -- 7
                    v <= "1110100";
			when "1110100" =>   -- 8   
                    v <= "1110101";
			when "1110101" =>   -- 9
                    v <= "1110110";
			when "1110110" =>   -- 10
                    v <= "1110111";
			when "1110111" =>   -- 11
                    v <= "1111000";
			when "1111000" =>   -- 12
                    v <= "1111001";
			when "1111001" =>   -- 13
                    v <= "1111010";
			when "1111010" =>   -- 14
                    v <= "1111011";
			when "1111011" =>   -- 15
                    v <= "1111100";
			when "1111100" =>   -- 16
                    v <= "1111101";
            when "1111101" =>   -- 17
                    v <= "1111110";
			when "1111110" =>   -- 18
                    v <= "1111111";
			when "1111111" =>   -- 19
                    v <= "0010001";		  
            when others => 
                    v <= "1111111"; 
            end case;
        end if;
    end process;

    --output:
    counterClk <= v(6);
	clk0 <= v(4);
	clk1 <= v(0);
            
    end struct;