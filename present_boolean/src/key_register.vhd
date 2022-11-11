----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2022 12:24:58 AM
-- Design Name: 
-- Module Name: key_register - Behavioral
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

entity key_register is
    Port ( --in_keyreg : buffer STD_LOGIC_VECTOR (127 downto 0); 
           in_keyload : in STD_LOGIC_VECTOR (7 downto 0);
           in_sbox : out STD_LOGIC_VECTOR (7 downto 0);
           clk     : in STD_LOGIC;
           --en_load : in STD_LOGIC;
           out_sbox : in STD_LOGIC_VECTOR (7 downto 0);
           count31 : in std_logic_vector(4 DOWNTO 0);  -- counter range from 0 to 31
           load_counter : in std_logic_vector(4 DOWNTO 0);
           count9  : in std_logic_vector(3 DOWNTO 0);
           out_key : out STD_LOGIC_VECTOR (7 downto 0)
           );
end key_register;

architecture Behavioral of key_register is

begin
    process(clk)
       variable key_rotated: std_logic_vector(127 downto 0);
       variable master_key: std_logic_vector(127 downto 0);
       variable out_buff: std_logic_vector(127 downto 0);
    begin
    
        
    
        if (clk'event and clk = '1') THEN
        
            -- wait first 16 clock to fetch key
            if to_integer(unsigned(load_counter)) >= 16 then 
                 master_key( (to_integer(unsigned(load_counter)) - 15)*8-1 downto (to_integer(unsigned(load_counter)) - 16)*8 ) := in_keyload;
                 
                 if to_integer(unsigned(load_counter)) = 16 then 
                    
                        --out_key   <= master_key;
                        out_buff := master_key;
                        
                 end if;
            
            else 
            
                --for the later 31 * 9 cycles
                --update the round key every 9 clock cycles
                if to_integer(unsigned(count9)) = 0 then 
                
                    --key_rotated := in_keyreg(66 downto 0) & in_keyreg(127 downto 67);
                    --to_sbox <= key_rotated(127 downto 124) & key_rotated(123 downto 120);
--                    out_key(127 downto 124) <= in_sbox(7 downto 4);
                    
--                    --I don't know whether this need delay
--                    --Ans: It doesn't need
--                    --------------------------------------------------------------
                    
--                    out_key(123 downto 120) <= in_sbox(3 downto 0);
--                    out_key(119 downto 67) <= key_rotated(119 downto 67);
--                    out_key(66 downto 62) <= key_rotated(66 downto 62) xor count31;
--                    out_key(61 downto 0) <= key_rotated(61 downto 0);


                    key_rotated := out_buff(66 downto 0) & out_buff(127 downto 67);
                    in_sbox <= key_rotated(127 downto 124) & key_rotated(123 downto 120);

                    out_buff(127 downto 124) := out_sbox(7 downto 4);
                    out_buff(123 downto 120) := out_sbox(3 downto 0);
                    out_buff(119 downto 67) := key_rotated(119 downto 67);
                    out_buff(66 downto 62) := key_rotated(66 downto 62) xor count31;
                    out_buff(61 downto 0) := key_rotated(61 downto 0);
                
                else 
                    
                    out_key <= out_buff(to_integer(unsigned(count9))*8-1 downto to_integer(unsigned(count9))*8-8);
                    
                    
                end if;     
            
            end if;
        end if;

        end process;

end Behavioral;
