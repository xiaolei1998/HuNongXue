----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2022 04:06:57 AM
-- Design Name: 
-- Module Name: text_holder - Behavioral
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

entity text_holder is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           text_out : out STD_LOGIC_VECTOR (127 downto 0);
           text_fetch_ok : out STD_LOGIC);
end text_holder;

architecture Behavioral of text_holder is
begin

    process(clk,en)
    begin
        IF( rst = '1') then   
            text_out <= (others => 'X');
            text_fetch_ok <= '0';
            
        elsif (clk'event) and (clk = '1') then
            if(en = '1') then
                text_out <= "11111111110101010101010101010101010101010101010101000000000011111111110101010101101010101000110011001101010101010101010101010101";
                text_fetch_ok <= '1';
            else
                text_fetch_ok <= '0';
            end if;
        end if;
        
    end process;

end Behavioral;
