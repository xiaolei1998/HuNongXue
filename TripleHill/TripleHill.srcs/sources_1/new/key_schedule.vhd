----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2022 04:16:48 AM
-- Design Name: 
-- Module Name: key_schedule - Behavioral

-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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

use std.textio.all;

entity key_schedule is
    Port ( clk : in STD_LOGIC;
           en: in STD_LOGIC;
           key_in: in STD_LOGIC_VECTOR (255 downto 0);
           key_out : out STD_LOGIC_VECTOR (1023 downto 0);
           rst : in STD_LOGIC;
           key_done : out STD_LOGIC);

end key_schedule;

architecture Behavioral of key_schedule is

type subkey_mem is array (0 to 7) of std_logic_vector(127 downto 0); 


begin
    process(clk,en,key_in)
    file test_vector      : text open write_mode is "output_file.txt";
    variable row          : line;
    variable subkey : subkey_mem;
    
    begin
        
        if( rst = '1') then   
                for i in 0 to 7 loop
                
                    subkey(i) := (others => '0'); 
                
                end loop;
                
                
                key_out <= (others => 'X');
                key_done <= '0';
    
    
        elsif (clk'event) and (clk = '1') then
        
            if  (en = '1') then 
                subkey(0) :=  key_in(255 downto 224)&key_in(191 downto 160) & key_in(127 downto 96)&key_in(63 downto 32);
                subkey(1) :=  key_in(223 downto 192)&key_in(159 downto 128) & key_in(95 downto 64) &key_in(31 downto 0);
                subkey(2) :=  key_in(255 downto 160)&key_in(31 downto 0);
                subkey(3) :=  key_in(127 downto 32)&key_in(159 downto 128);
                subkey(4) :=  key_in(223 downto 96);
                subkey(5) :=  key_in(95 downto 0) & key_in(255 downto 224);
                subkey(6) :=  key_in(31 downto 0) & key_in(255 downto 160);
                subkey(7) :=  key_in(159 downto 32);
                
                key_out <= subkey(0)&subkey(1)&subkey(2)&subkey(3)&subkey(4)&subkey(5)&subkey(6)&subkey(7);
                key_done <= '1';
        
           else
                key_out <= (others => 'X');
                key_done <= '0';

           -- hwrite(row, subkey(0));
--            hwrite(row, key_out);
--            WRITELINE (test_vector, row);

            
           end if;
       end if;
        
    end process;


end Behavioral;
