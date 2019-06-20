library ieee;
use ieee.std_logic_1164.all;

entity uart_receiver is

port(
     data_in: in std_logic;
     data_out_0: out std_logic;
     data_out_1: out std_logic;
     data_out_2: out std_logic;
     data_out_3: out std_logic;
     data_out_4: out std_logic;
     data_out_5: out std_logic;
     data_out_6: out std_logic;
     data_out_7: out std_logic;
     clk: in std_logic
     );
     
end uart_receiver;

architecture behavioral of uart_receiver is

signal baud_rate: integer := 1000000;
constant clock_number: integer := (10000000/baud_rate) - 1;
signal clock_counter: integer := 0;
signal data_out: std_logic_vector (0 to 7) := "00000000";
type state_type is (ready, receive_data, receive_stop);
signal state: state_type := ready;
signal index_number: integer := 0;

begin
process(clk)
begin

if rising_edge(clk) then

    case state is
    
    when ready =>
    
        if data_in = '1' then
    
        state <= ready;
        clock_counter <= 0;
    
        else
        
            if clock_counter < clock_number/2 then
            
            clock_counter <= clock_counter + 1;
            
            else
            
            state <= receive_data;
            clock_counter <= 0;
            
            end if;
            
        end if;
        
    when receive_data =>
    
        if index_number < 8 then
        
            if clock_counter < clock_number then
            
            clock_counter <= clock_counter + 1;
            state <= receive_data;
            
            else
            
            data_out(index_number) <= data_in;
            clock_counter <= 0;
            index_number <= index_number + 1;
            state <= receive_data;
            
            end if;
            
        else
        
        clock_counter <= 0;
        index_number <= 0;
        state <= receive_stop;
        
        end if;
        
    when receive_stop =>
    
        if clock_counter < clock_number then
        
        clock_counter <= clock_counter + 1;
        
        else
        
            if data_in = '0' then
            
            state <= ready;
            data_out_0 <= data_out(0);
            data_out_1 <= data_out(1);
            data_out_2 <= data_out(2);
            data_out_3 <= data_out(3);
            data_out_4 <= data_out(4);
            data_out_5 <= data_out(5);
            data_out_6 <= data_out(6);
            data_out_7 <= data_out(7);
            clock_counter <= 0;
            
            else        
                
            state <= ready;
            data_out_0 <= data_out(0);
            data_out_1 <= data_out(1);
            data_out_2 <= data_out(2);
            data_out_3 <= data_out(3);
            data_out_4 <= data_out(4);
            data_out_5 <= data_out(5);
            data_out_6 <= data_out(6);
            data_out_7 <= data_out(7);
            clock_counter <= 0;
            
            end if;           
            
        end if;
        
    end case;
    
end if;
end process;
end behavioral;
            
            
            