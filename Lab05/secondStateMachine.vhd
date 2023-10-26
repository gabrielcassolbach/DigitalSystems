Library IEEE;
use ieee.std_logic_1164.all;

entity secondStateMachine is
    port (
       clk: in std_logic;
       outClk: out std_logic;
       outputDigits: out std_logic_vector (3 downto 0)
    );
end secondStateMachine;

architecture struct of secondStateMachine is

--types
type state_type is (s0, s1, s2, s3, s4, s5);

--signals
signal state: state_type;
signal clkCtrler: state_type;
signal rstSignal: std_logic;
signal v: std_logic_vector (3 downto 0);

    begin 
    process (clk)
    begin
        if (clk'event and clk = '1') then 
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
                    state <= s0;
            end case;
        end if;
    end process;
    
    process (state)
        begin 
        case state is 
            when s0 =>
                v <= "0000";
            when s1 =>
                v <= "0001";
            when s2 =>
                v <= "0010"; 
            when s3 =>
                v <= "0011";
            when s4 =>
                v <= "0100";        
            when s5 =>
                v <= "0101";        
        end case;
    end process;

    process (clk)
    begin
        if (clk'event and clk = '1') then 
            case clkCtrler is 
                when s0 => 
                    clkCtrler <= s1;
                when s1 => 
                    clkCtrler <= s2;
                when s2 => 
                    clkCtrler <= s3;
                when s3 => 
                    clkCtrler <= s4;
                when s4 => 
                    clkCtrler <= s5;
                when s5 => 
                    clkCtrler <= s0;
            end case;
        end if;
    end process;
    
    process (clkCtrler)
        begin 
        case clkCtrler is 
            when s0 =>
                rstSignal <= '1';
            when s1 =>
                rstSignal <= '0';
            when s2 =>
                rstSignal <= '0'; 
            when s3 =>
                rstSignal <= '0';
            when s4 =>
                rstSignal <= '0';       
            when s5 =>
                rstSignal <= '0';           
        end case;
    end process;

    --> output:
    outputDigits <= v;
    outClk <= rstSignal;

    end struct;