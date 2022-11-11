----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2022 10:52:45 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is 
        PORT(
            sel_mux          : IN std_logic;
            in1_mux,in0_mux  :IN std_logic_vector(7 DOWNTO 0);
            out_mux          : OUT std_logic_vector(7 DOWNTO 0));
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
