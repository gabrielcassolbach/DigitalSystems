Library IEEE;
use ieee.std_logic_1164.all;

entity stateMachine2 is
    port (
        clk: in std_logic;
        rst: in std_logic;
        outDigits: out std_logic_vector (3 downto 0)
    );
end stateMachine2;

architecture struct of stateMachine2 is 

--types
type state_type is (s0, s1, s2, s3, s4, s5, s6);

signal state: state_type := s6;
signal v: std_logic_vector (3 downto 0);

    begin
        process (clk, rst)
        begin
            if (rst = '0') then
                state <= s6;
            elsif (clk'event and clk = '1') then 
                case state is 
                    when s6 => 
                        state <= s5;
                    when s5 => 
                        state <= s4;
                    when s4 => 
                        state <= s3;
                    when s3 => 
                        state <= s2;
                    when s2 => 
                        state <= s1;
                    when s1 => 
                        state <= s0;
                    when s0 => 
                        state <= s6;
                end case;
            end if;
        end process;

        process (state)
        begin 
            case state is 
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