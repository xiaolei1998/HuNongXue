----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2022 09:21:52 AM
-- Design Name: 
-- Module Name: load_counter - Behavioral
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
-- arithmetic functions with Signed or Unsigned valuesu
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity load_counter is
    Port ( clk : in STD_LOGIC;
           load_31 : out STD_LOGIC_VECTOR (4 downto 0);
           --load_31 : OUT INTEGER;
           done : out STD_LOGIC;
           en_load : in STD_LOGIC
           );
           
    
end load_counter;

architecture Behavioral of load_counter is
begin

    process(clk,en_load)
           variable OPCODE31 : INTEGER := 31;
           variable load_c :STD_LOGIC_VECTOR (4 downto 0);

    begin

            if(clk'event and clk = '1') then     
                
                if en_load = '1' then 

                   load_c := STD_LOGIC_VECTOR(to_unsigned(OPCODE31, 5));
                   --load_31 <= OPCODE31;
                   load_31 <= load_c;
                   
                   
                   if OPCODE31 <= 15 then
                        done <= '1';
                   else
                        done <= '0';
                   end if;
                   
                   OPCODE31 := OPCODE31-1;
                   
                   

                 end if; 
             end if;
    end process;

end Behavioral;
