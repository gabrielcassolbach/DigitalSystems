Library IEEE;
use ieee.std_logic_1164.all;

entity clkController is
    port (
        fpgaClk: in std_logic;
        rst: in std_logic;
        clk0: out std_logic;
        clk1: out std_logic
    );
end clkController;

architecture struct of clkController is

signal v: std_logic_vector (5 downto 0) := "111111";

    begin 
    process(fpgaClk)
    begin 
        if (rst = '0') then
            v <= "010001";
        elsif (fpgaClk'event and fpgaClk = '1') then 
            case v is 
               when "010001" =>   -- 1
                    v <= "000001";
			when "000001" =>   -- 2
                    v <= "011111";
			when "011111" =>   -- 3
                    v <= "110000";
			when "110000" =>   -- 4
                    v <= "110001";
			when "110001" =>   -- 5
                    v <= "110010";
			when "110010" =>   -- 6
                    v <= "110011";
			when "110011" =>   -- 7
                    v <= "110100";
			when "110100" =>   -- 8   
                    v <= "110101";
			when "110101" =>   -- 9
                    v <= "110110";
			when "110110" =>   -- 10
                    v <= "110111";
			when "110111" =>   -- 11
                    v <= "111000";
			when "111000" =>   -- 12
                    v <= "111001";
			when "111001" =>   -- 13
                    v <= "111010";
			when "111010" =>   -- 14
                    v <= "111011";
			when "111011" =>   -- 15
                    v <= "111100";
			when "111100" =>   -- 16
                    v <= "111101";
               when "111101" =>   -- 17
                    v <= "111110";
			when "111110" =>   -- 18
                    v <= "111111";
			when "111111" =>   -- 19
                    v <= "010001";		  
               when others => 
                    v <= "010001"; 
            end case;
        end if;
    end process;

    --output:
	 clk0 <= v(4);
	 clk1 <= v(0);
            
    end struct;