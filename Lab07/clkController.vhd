Library IEEE;
use ieee.std_logic_1164.all;

entity clkController is
    port (
        fpgaClk: in std_logic;
        rst: in std_logic;
        pisoClk: out std_logic;
        detecSeqClk: out std_logic
    );
end clkController;

architecture struct of clkController is

signal v: std_logic_vector (4 downto 0) := "01111";

    begin 
    process(fpgaClk)
    begin 
        if (rst <= '0') then
            v <= "00000";
        elsif (fpgaClk'event and fpgaClk = '1') then 
            case v is 
                when "00000" => -- 1 
                    v <= "00001";
                when "00001" => -- 2 - clk (detseq)
                    v <= "00010";
                when "00010" => -- 3
                    v <= "00011";
                when "00011" => -- 4 - clk (detseq)
                    v <= "00100";
                when "00100" => -- 5
                    v <= "00101";
                when "00101" => -- 6 - clk (detseq)
                    v <= "00110";
                when "00110" => -- 7 
                    v <= "00111";
                when "00111" => -- 8 - clk (detseq)
                    v <= "01000";
                when "01000" => -- 9 
                    v <= "01001";
                when "01001" => -- 10 - clk (detseq)
                    v <= "01010";
                when "01010" => -- 11
                    v <= "01011";
                when "01011" => -- 12 - clk (detseq)
                    v <= "01100";
                when "01100" => -- 13 
                    v <= "01101";
                when "01101" => -- 14 - clk (detseq)
                    v <= "01110";
                when "01110" => -- 15 
                    v <= "01111";
                when "01111" => -- 16 - clk (detseq)
                    v <= "10000";
                when "10000" => -- 17 - clk (piso)
                    v <= "00000";
                when others =>
                    v <= "00000";
            end case;
        end if;
    end process;

    detecSeqClk <= v(0);
    pisoClk <= v(4);
    
    end struct;