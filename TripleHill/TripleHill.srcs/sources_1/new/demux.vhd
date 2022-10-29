----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2022 08:49:58 AM
-- Design Name: 
-- Module Name: demux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux is
       generic (
            data_length : integer := 128
            );
      
       PORT(
            sel_demux                         : IN std_logic;
            in_demux                          : IN std_logic_vector(data_length-1 DOWNTO 0);
            out_demux1                         : OUT std_logic_vector(data_length-1 DOWNTO 0);
            out_demux2                         : OUT std_logic_vector(data_length-1 DOWNTO 0)

            );
end demux;

architecture Behavioral of demux is
BEGIN
    PROCESS(sel_demux,in_demux)
    BEGIN
        IF(sel_demux = '0')THEN
            out_demux1 <= in_demux;
        ELSIF(sel_demux = '1')THEN
            out_demux2 <= in_demux;
            
        END IF;
    
    END PROCESS;
end Behavioral;            

