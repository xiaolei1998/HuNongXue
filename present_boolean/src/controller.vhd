----------------------------------------------------------------------------------
-- Company: National university of Singapore
-- Engineer: ZHANG Xiaolei
-- 
-- Create Date: 10/19/2022 12:37:48 AM
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
  Port (clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en  : in STD_LOGIC;
        sel_mux31 : out STD_LOGIC_VECTOR(4 downto 0);
        sel_mux9 : out STD_LOGIC_VECTOR(3 downto 0)
        );
end controller;

architecture Behavioral of controller is

begin
    process(clk,rst)
        VARIABLE OPCODE31 : INTEGER := 31;
        VARIABLE OPCODE9 : INTEGER := 9;
        VARIABLE tick : INTEGER := 31*9;

    begin
        if rst = '1' then
        
            sel_mux31 <= (others => 'X');        
            sel_mux9 <=  (others => 'X');
            OPCODE31 := 31;
            OPCODE9  := 9;
    
        else 
            if en = '1' then  -- start counting down 31 * 9
                if(clk'event and clk = '1') then 
                    
                    OPCODE9 := 9- (tick mod 9)-1;
                    sel_mux9 <= std_logic_vector(to_unsigned(OPCODE9, 4));
                    sel_mux31 <= std_logic_vector(to_unsigned(OPCODE31, 5));
                    
                    if (OPCODE9 = 0) then 
                        OPCODE31 := OPCODE31-1;
                    end if;       
                    tick := tick - 1;
                    
                 end if; 
             end if;
            
        end if;
        end process;
        
        
        

end Behavioral;