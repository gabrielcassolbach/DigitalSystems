Library IEEE;
use ieee.std_logic_1164.all;

entity seqDetector is
    port (
       clk: in std_logic;
       inputDigit: in std_logic;
       reset_n: in std_logic;
       outDigits: out std_logic_vector (3 downto 0)
    );
end seqDetector;

architecture operation of seqDetector is

--signal.
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);
signal state: state_type;
signal outputDigits: std_logic_vector (2 downto 0);

    begin 
        process(clk, reset_n)
        begin 
            if(reset_n = '0') then 
                state <= s0;
            elsif (clk'event and clk = '1') then -- clock na descida.
                case state is
                    when s0=>
                        if inputDigit = '1' then
                            state <= s1;
                        else 
                            state <= s0;
                        end if;
                    when s1=>
                        if inputDigit = '1' then
                            state <= s1;
                        else 
                            state <= s2;
                        end if;
                    when s2=>
                        if inputDigit = '1' then
                            state <= s3;
                        else 
                            state <= s0;
                        end if;
                    when s3=>
                        if inputDigit = '1' then
                            state <= s1;
                        else 
                            state <= s4;
                        end if;
                    when s4=>
                        if inputDigit = '1' then
                            state <= s5;
                        else 
                            state <= s0;
                        end if;
                    when s5=>
                        if inputDigit = '1' then
                            state <= s6;
                        else 
                            state <= s4;
                        end if;
                    when s6=>
                        if inputDigit = '1' then
                            state <= s0;
                        else 
                            state <= s7;
                        end if;
                    when s7=>
                        if inputDigit = '1' then
                            state <= s1;
                        else 
                            state <= s0;
                        end if;
                end case;
            end if;
        end process;

        process (state)
        begin 
        case state is 
            when s0 =>
                outputDigits <= "000";
            when s1 =>
                outputDigits <= "001";
            when s2 =>
                outputDigits <= "010"; 
            when s3 =>
                outputDigits <= "011";
            when s4 =>
                outputDigits <= "100";        
            when s5 =>
                outputDigits <= "101"; 
            when s6 =>
                outputDigits <= "110";  
            when s7 =>
                outputDigits <= "111";   
        end case;
    end process;

    --output:
    outDigits <= '0' & outputDigits (2 downto 0);
                            
    end operation;
