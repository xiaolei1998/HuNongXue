----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2022 08:26:22 AM
-- Design Name: 
-- Module Name: mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is 
       generic (
            data_length : integer := 128
            );
            
        PORT(

            sel_mux                         : IN std_logic;
            in1_mux,in0_mux                 :IN std_logic_vector(data_length-1 DOWNTO 0);
            out_mux                         : OUT std_logic_vector(data_length-1 DOWNTO 0));
end mux;

architecture Behavioral of mux is
BEGIN
    PROCESS(sel_mux,in1_mux,in0_mux)
    BEGIN
        IF(sel_mux = '1')THEN
            out_mux <= in0_mux;
        ELSIF(sel_mux = '0')THEN
            out_mux <= in1_mux;

        ELSE
            out_mux <= (others => 'X');
        END IF;
    
    END PROCESS;
end Behavioral;      