Library IEEE;
use ieee.std_logic_1164.all;

entity playerScore is
    port (
        clk: in std_logic;
        enableClk: in std_logic;
        rstCounter: in std_logic;
        outDigits: out std_logic_vector (3 downto 0)
    );
end playerScore;

architecture struct of playerScore is
     
--types
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);

--signals
signal state: state_type := s0;
signal v: std_logic_vector (3 downto 0);
    
    begin
        process (clk, rstCounter)
        begin
            if (rstCounter = '0') then
                state <= s0;
            elsif ((clk'event and clk = '0') and enableClk = '1') then 
                case state is 
                    when s0 => 
                        state <= s1;
                    when s1 => 
                        state <= s2;
                    when s2 => 
                        state <= s3;
                    when s3 => 
                        state <= s4;
                    when s4 => 
                        state <= s5;
                    when s5 => 
                        state <= s6;
                    when s6 => 
                        state <= s7;
                    when s7 => 
                        state <= s8;
                    when s8 => 
                        state <= s9;
                    when s9 => 
                        state <= s0;
                end case;
            end if;
        end process;
        
        process (state)
        begin 
            case state is 
                when s9 =>
                    v <= "1001";
                when s8 =>
                    v <= "1000";
                when s7 =>
                    v <= "0111"; 
                when s6 =>
                    v <= "0110";
                when s5 =>
                    v <= "0101";        
                when s4 =>
                    v <= "0100"; 
                when s3 =>
                    v <= "0011";
                when s2 =>
                    v <= "0010";    
                when s1 =>
                    v <= "0001";  
                when s0 =>
                    v <= "0000";                              
            end case;
        end process;
        
        outDigits <= v;

    end struct;



    