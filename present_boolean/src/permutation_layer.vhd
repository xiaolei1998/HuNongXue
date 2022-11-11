----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2022 11:04:18 PM
-- Design Name: 
-- Module Name: permutation_layer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity permutation_layer is
    Port ( in_permu : in STD_LOGIC_VECTOR (63 downto 0);
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           out_permu : out STD_LOGIC_VECTOR (63 downto 0));
end permutation_layer;

architecture Behavioral of permutation_layer is

    subtype bits_4 is std_logic_vector(3 downto 0); 
    type blocks is array(15 downto 0) of bits_4;
    
begin
    process(clk, in_permu)
    begin
        IF( rst = '1') then   
                out_permu <= (others => 'X');
          
         elsif (clk'event) and (clk = '1') then
            --permutation are requred to finish in 1 clock for all 64 bits
            for i in 63 downto 0 loop
                out_permu((i mod 4) * 16 + (i/4)) <= in_permu(i);
            end loop;

         end if;
    
    end process;


end Behavioral;
