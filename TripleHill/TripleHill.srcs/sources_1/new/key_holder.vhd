----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2022 03:54:43 AM
-- Design Name: 
-- Module Name: key_holder - Behavioral
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

entity key_holder is
    Port ( clk : in STD_LOGIC;
           en: in STD_LOGIC;
           rst : in STD_LOGIC;
           key : out STD_LOGIC_VECTOR (255 downto 0);
           key_fetch_ok : out STD_LOGIC;
           key_count : in STD_LOGIC_VECTOR(1 downto 0)
           );
end key_holder;

architecture Behavioral of key_holder is
begin

    process(clk,en)
    
    variable key1 :  STD_LOGIC_VECTOR (63 downto 0) := "1111101011101011111010111110101010101010101010101010011000001111";
    variable key2 :  STD_LOGIC_VECTOR (63 downto 0) := "1111101010101010101010101010111010101010101010101010101011101010";
    variable key3 :  STD_LOGIC_VECTOR (63 downto 0) := "1011111111110000011000101010101010101010101010101010101010101010";
    variable key4 :  STD_LOGIC_VECTOR (63 downto 0) := "1010101011111111110000001100101011101010101110101010101010110010";

    begin
    
        IF( rst = '1') then   
            key <= (others => 'X');
            key_fetch_ok <= '0';
      
        elsif (clk'event) and (clk = '1') then
            if( en = '1') then
                if key_count = "11" then  
                    key <= key1 & key2 & key3 & key4;
                    key_fetch_ok <= '1';
                elsif key_count = "10" then 
                    key <= key4 & key3 & key2 & key1;
                else 
                    key <= key2 & key3 & key2 & key1;
                
                end if;
            
            else
                key_fetch_ok <= '0';
            
            
            
            end if;
            
        
            
        
        end if;
    end process;


end Behavioral;
