----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2022 10:03:28 PM
-- Design Name: 
-- Module Name: BRAM - Behavioral
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
entity BRAM is
    Port ( clk : in STD_LOGIC;
           en: in STD_LOGIC;
           rst : in STD_LOGIC;
           key : out STD_LOGIC_VECTOR (127 downto 0);
           txt : out STD_LOGIC_VECTOR (63 downto 0);
           txt_fetch_ok : out STD_LOGIC;
           key_fetch_ok : out STD_LOGIC;
           count : in STD_LOGIC_VECTOR(4 downto 0)
           );
end BRAM;

architecture Behavioral of BRAM is
begin

   process(clk,en)

        variable key_holder : STD_LOGIC_VECTOR(127 downto 0) := (others => '0');
        variable text_holder : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');

    
   begin


         IF( rst = '1') then   
              key <= (others => 'X');
              txt <= (others => 'X');
              key_fetch_ok <= '0';
              txt_fetch_ok <= '0';
  
         elsif (clk'event) and (clk = '1') then
         
            if( en = '1') then
                if  to_integer(unsigned(count)) >= 16 then  
                    key <= key_holder((to_integer(unsigned(count)) - 15)*8-1 downto (to_integer(unsigned(count)) - 16)*8);
                    key_fetch_ok <= '1';
                    
                    if to_integer(unsigned(count)) >= 24 then 
                        txt <= text_holder((to_integer(unsigned(count)) - 23)*8-1 downto (to_integer(unsigned(count)) - 24)*8);
                        txt_fetch_ok <= '1';
                    
                    end if;
                    
                else 
               
                      key_fetch_ok <= '0';
                      txt_fetch_ok <= '0';
        
                end if;
             
             else
                txt_fetch_ok <= '0';
                key_fetch_ok <= '0';
                
             end if;
          end if;
   
    end process;

end Behavioral;

