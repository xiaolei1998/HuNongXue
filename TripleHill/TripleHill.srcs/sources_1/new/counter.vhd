----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2022 09:49:38 AM
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
  GENERIC (
            count : integer := 3
            );
  Port (clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        sel_mux : out STD_LOGIC;
        sel_demux : out STD_LOGIC;
        curr_count : out STD_LOGIC_VECTOR(1 downto 0);
        done : out STD_LOGIC
        );
end counter;

architecture Behavioral of counter is

begin


    process(clk,rst)
        VARIABLE OPCODE : integer := count;
    begin
        if rst = '1' then
        
            sel_mux <= 'X';        
            sel_demux <= 'X';
            done <= '0';
    
        else 
            if(clk'event and clk = '1') then 
               
               if(OPCODE = 3) then
                    sel_mux <= '0';
                    sel_demux <= '0';
                    curr_count <= std_logic_vector(to_unsigned(OPCODE, 2));

               
               elsif (OPCODE = 2) then
                    
                    sel_mux <= '1';
                    sel_demux <= '0';
                    curr_count <= std_logic_vector(to_unsigned(OPCODE, 2));
               
               elsif (OPCODE = 1) then
                      sel_mux <= '1';
                      sel_demux <= '0';
                      curr_count <= std_logic_vector(to_unsigned(OPCODE, 2));
                      
               elsif (OPCODE < 0) then
                      sel_demux <= '1';
                      done <= '1';

               end if; 
               
                OPCODE := OPCODE-1;
        
             end if;
            
           end if;
            
        end process;

end Behavioral;
