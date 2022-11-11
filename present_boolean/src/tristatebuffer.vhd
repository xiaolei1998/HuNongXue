----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2022 11:07:46 PM
-- Design Name: 
-- Module Name: tristatebuffer - Behavioral
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

entity tristatebuffer is
    generic (
            data_length : integer := 8
            );

     PORT(
            E   : IN std_logic;
            D   : IN std_logic_vector(data_length-1 DOWNTO 0);
            Y   : OUT std_logic_vector(data_length-1 DOWNTO 0));
end tristatebuffer;

ARCHITECTURE Behavioral OF tristatebuffer IS
BEGIN
    PROCESS (E)
        BEGIN
        IF (E = '1') THEN
	       Y <= D;
        ELSE
            Y <= (OTHERS => 'Z'); 
        END IF;
    END PROCESS;
END Behavioral;    