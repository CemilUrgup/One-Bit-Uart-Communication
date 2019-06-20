library ieee;
use ieee.std_logic_1164.all;

entity top_module is

port(
     sw_0: in std_logic;
     sw_1: in std_logic;
     sw_2: in std_logic;
     sw_3: in std_logic;
     sw_4: in std_logic;
     sw_5: in std_logic;
     sw_6: in std_logic;
     sw_7: in std_logic;
     led_0 : out std_logic;
     led_1 : out std_logic;
     led_2 : out std_logic;
     led_3 : out std_logic;
     led_4 : out std_logic;
     led_5 : out std_logic;
     led_6 : out std_logic;
     led_7 : out std_logic;
     send  : in std_logic;
     clk   : in std_logic
     );
     
end top_module;

architecture behavioral of top_module is

signal data: std_logic;

component uart_transmitter

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
     
end component;

component uart_receiver

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
    
end component;

begin

instantiation_transmitter: uart_transmitter

                    port map(
                                tx => data,
                                clk => clk,
                                in_0 => sw_0,
                                in_1 => sw_1,
                                in_2 => sw_2,
                                in_3 => sw_3,
                                in_4 => sw_4,
                                in_5 => sw_5,
                                in_6 => sw_6,
                                in_7 => sw_7,
                                send => send
                                );
                    
                    

instantiation_receiver: uart_receiver

                    port map(
                        data_in => data,
                        data_out_0 => led_0,
                        data_out_1 => led_1,
                        data_out_2 => led_2,
                        data_out_3 => led_3,
                        data_out_4 => led_4,
                        data_out_5 => led_5,
                        data_out_6 => led_6,
                        data_out_7 => led_7,
                        clk => clk
                        );
                    
end behavioral;


