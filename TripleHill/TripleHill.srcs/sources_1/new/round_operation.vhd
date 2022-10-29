----------------------------------------------------------------------------------
-- Company: National University of Singapore
-- Engineer: Xiaolei Zhang
-- 
-- Create Date: 10/25/2022 04:48:32 AM
-- Design Name: 
-- Module Name: round_operation - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.Numeric_Std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity round_operation is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           key : in STD_LOGIC_VECTOR (1023 downto 0);
           text_in : in STD_LOGIC_VECTOR (127 downto 0);
           cipher_ok : out STD_LOGIC_VECTOR (127 downto 0);
           rst : in STD_LOGIC
           );
end round_operation;

architecture Behavioral of round_operation is

subtype byte is std_logic_vector(7 downto 0); 
type vector is array(0 to 3) of byte;
type matrix is array(0 to 3) of vector;
type subkey_collection is array(0 to 7) of matrix;


--[8 bit] [8 bit] [8 bit] [8 bit] 
--[8 bit] [8 bit] [8 bit] [8 bit]           
--[8 bit] [8 bit] [8 bit] [8 bit] 
--[8 bit] [8 bit] [8 bit] [8 bit] 

--[00] [01] [02] [03]
--[10] [11] [12] [13]
--[20] [21] [22] [23]     MATRIX
--[30] [31] [32] [33]

--[00] [01] [02] [03] [10] [11] [12] [13] [20] [21] [22] [23] [30] [31] [32] [33]


begin
  
   PROCESS(clk,en,key,text_in)
   
   VARIABLE counter : integer := 3;  --count the triple hill's triple
   VARIABLE counter_round : integer := 8; --count the round operation for 8 times
   VARIABLE text_matrix : matrix;
   VARIABLE subkey: subkey_collection;
   VARIABLE cipher_text : matrix;
   VARIABLE temp : matrix;
   VARIABLE A : byte;
   VARIABLE cursor : integer := 0;
   VARIABLE format_cipher : STD_LOGIC_VECTOR (127 downto 0);


    
   BEGIN
   
   
      IF( rst = '1') then   
      
           cipher_ok <= (others => '0');
           cursor := 0;
           format_cipher := (others => '0');


      ELSIF (clk'event and clk = '1' and en = '1') THEN
   
          -- FIRST format the text and key to correct matrix format
            cursor := 0;
            outter: for i in 0 to 3 loop
                inner :for j in 0 to 3 loop
                
                    text_matrix(i)(j) := text_in(127-cursor downto 127-cursor-7);
                    cursor := cursor + 8;
    
                end loop inner;
            end loop outter ;
            cursor := 0;
            
            
            o: for i in 0 to 7 loop          
                mid: for j in 0 to 3 loop
                    i :for k in 0 to 3 loop
                        
                        subkey(i)(j)(k) := key(1023-cursor downto 1023-cursor-7);
                        cursor := cursor + 8;
    
                    end loop i;
                end loop mid ;
              end loop o;
              cursor := 0;
          
          
          ------------------------------------------------------------
            
               i_p:for subround in 0 to counter_round-1 loop -- 8 subround
               
                   b_p:for i in 0 to 4-1 loop
                        l_p:for j in 0 to 4-1 loop
                            temp(i)(j) := "00000000";
                            
                            w_p:for k in 0 to 4-1 loop
                                
                                
                                A := subkey(subround)(i)(k) and text_matrix(k)(j);
                                temp(i)(j) := temp(i)(j) XOR A;
                                
                                
                             end loop w_p;
    
                        end loop l_p;
                   end loop b_p;
                   
               end loop i_p;
            cursor := 0;
 
            
            --serialize the ciphered text
            s_o: for i in 0 to 3 loop
                s_i :for j in 0 to 3 loop
                    format_cipher(127-cursor downto 127-cursor-7) := temp(i)(j);
                    cursor := cursor + 8;
    
                end loop s_i;
            end loop s_o ;
            
            
            cipher_ok <= format_cipher;

        end if;
  
   
   end process;






end Behavioral;
