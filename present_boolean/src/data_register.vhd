----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2022 05:56:16 AM
-- Design Name: 
-- Module Name: data_register - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_register is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           --en_load : in STD_LOGIC;
           ctr_9 : in STD_LOGIC_VECTOR(3 downto 0);
           ctr_31 : in STD_LOGIC_VECTOR(4 downto 0);
           to_player : out STD_LOGIC_VECTOR (63 downto 0);
           from_player : in STD_LOGIC_VECTOR (63 downto 0));
end data_register;

architecture Behavioral of data_register is
begin
    
    process(clk)
            variable data : STD_LOGIC_VECTOR(63 downto 0);
            variable pos : INTEGER;
    begin

        if(clk'event) and (clk = '1')then
            --first 8 clock to latch plain txt
            pos := to_integer(unsigned(ctr_31));
            
            
            
            if pos > 23  then 
            
                 data((pos - 23)*8-1 downto (pos -23)*8 -8) :=  data_in;
                 
            else
            
                if ctr_9 /= "UUUU" then 
        
                --remaining lock
                    if  ctr_9 = "000" then
                        to_player <= data;
                        data := from_player;
                     
                    else
                        --clock 0 - 8 every clock out 8 bits and save incoming bits
                        data_out <= data(to_integer(unsigned(ctr_9))*8-1 downto to_integer(unsigned(ctr_9))*8-8);
                        data(to_integer(unsigned(ctr_9))*8-1 downto to_integer(unsigned(ctr_9))*8-8) := data_in;
                        
                    end if;
                    
               end if; 
            
            end if;
            
        end if;

--        if(clk'event) and (clk = '1')then
        
--            if  ctr_9 = "000" then
--                to_player <= data;
--                data := from_player;
             
--            else
--                --clock 0 - 8 every clock out 8 bits and save incoming bits
--                data(to_integer(unsigned(ctr_9))*8-1 downto to_integer(unsigned(ctr_9))*8-8) := data_in;
--                data_out <= data_in;
                
--            end if;
        
--        end if;

    end process;
    
    
end Behavioral;
