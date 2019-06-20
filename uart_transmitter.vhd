library ieee;
use ieee.std_logic_1164.all;

entity uart_transmitter is

port(
     tx: out std_logic := '1';
     clk: in std_logic;
     in_0: in std_logic;
     in_1: in std_logic;
     in_2: in std_logic;
     in_3: in std_logic;
     in_4: in std_logic;
     in_5: in std_logic;
     in_6: in std_logic;
     in_7: in std_logic;
     send: in std_logic
     );
    
end uart_transmitter;

architecture behavioral of uart_transmitter is

signal baud_rate: integer := 1000000;
constant clock_number: integer := (10000000/baud_rate) - 1;
signal clock_counter: integer := 0;
signal data_out: std_logic := '1';
type state_type is (ready, start_bit, transmit_data, stop_bit);
signal state: state_type := ready;
signal index_number: integer := 0;
signal data_in: std_logic_vector (0 to 7);

begin
process(clk)
begin

data_in(7) <= in_7;
data_in(6) <= in_6;
data_in(5) <= in_5;
data_in(4) <= in_4;
data_in(3) <= in_3;
data_in(2) <= in_2;
data_in(1) <= in_1;
data_in(0) <= in_0;

if rising_edge(clk) then
    
    case state is
    
    when ready =>
    
        if send = '0' then
        
        data_out <= '1';
        clock_counter <= 0;
        state <= ready;
        
        elsif send = '1' then
        
        state <= start_bit;
        
        end if;
        
    when start_bit =>
    
        if clock_counter < clock_number then
        
        data_out <= '0';
        clock_counter <= clock_counter + 1;
        state <= start_bit;
        
        else
        
        state <= transmit_data;
        clock_counter <= 0;
        
        end if;
        
    when transmit_data =>
    
        if index_number < 8 then
        
            if clock_counter < clock_number then
            
            clock_counter <= clock_counter + 1;
            data_out <= data_in(index_number);
            state <= transmit_data;
            
            else
            
            index_number <= index_number + 1;
            clock_counter <= 0;
            state <= transmit_data;
            
            end if;
            
        else
        
        index_number <= 0;
        state <= stop_bit;
        clock_counter <= 0;
        
        end if;
        
    when stop_bit =>
    
        if clock_counter < clock_number then
        
        clock_counter <= clock_counter + 1;
        data_out <= '1';
        
        else
        
        state <= ready;
        clock_counter <= 0;
        
        end if;
        
    end case;
    
tx <= data_out;

end if;
end process;
end behavioral;
        
        
      