----------------------------------------------------------------------------------
-- Company: National University of Singapore
-- Engineer: Zhang Xiaolei
-- 
-- Create Date: 10/12/2022 10:14:44 PM
-- Design Name: 
-- Module Name: S_Box - Behavioral
-- Project Name: Present Boolean S-box
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

entity S_Box is
    Port ( s_in : in STD_LOGIC_VECTOR (0 to 3); 
           s_out : out STD_LOGIC_VECTOR (0 to 3);
           clk : in std_logic
           --enable_s_box : in STD_LOGIC
           );
end S_Box;

architecture Behavioral of S_Box is  


begin

    -- a 0    /    b 1
    -- c 2   /     d 3

    PROCESS(clk,s_in)  
    
    variable f_1 : STD_LOGIC;
    variable f_2 : STD_LOGIC;
    variable f_3 : STD_LOGIC;
    variable f_4 : STD_LOGIC;
    variable f_5 : STD_LOGIC;
    variable f_6 : STD_LOGIC;
    variable f_7 : STD_LOGIC;
    variable f_8 : STD_LOGIC;
    variable f_9 : STD_LOGIC;
    
    
    variable w : STD_LOGIC;
    variable x : STD_LOGIC;
    variable y : STD_LOGIC;
    variable z : STD_LOGIC;
    
    begin
    
        if rising_edge(clk) then
    
            f_1 := (not(s_in(0)) and not(s_in(2)) and not(s_in(3))); --f1 = a'c'd'
            f_6 := (not(s_in(0)) and s_in(2));                      --f6 = a'c
            f_2 := f_6 and s_in(3);                                 --f2 = df6
            f_5 := s_in(0) and not(s_in(1));                        --f5 = ab'
            f_9 := s_in(0) and s_in(1);                             --f9 = ab
            f_3 := not(s_in(2)) and f_9;                            --f3 = c'f9
            f_4 := not(s_in(3)) and f_5;                            --f4 = d'f5
            f_7 := s_in(2) and not(s_in(3));                        --f7 = cd'
            f_8 := not(s_in(1)) and not(s_in(2));                   --f8 = b'c'
            
            
            -- s_out = [w,x,y,z]
            
            --w = f1 + f2 + df5 + cf5 + bf6
            w := f_1 or f_2 or (s_in(3) and f_5) or (s_in(2) and f_5) or (s_in(1) and f_6);
            --x = b'f7 + f3 + df8+ a'f8 + bf2
            x := (not(s_in(1)) and f_7) or f_3 or (s_in(3) and f_8) or (not(s_in(0)) and f_8) or (s_in(1) and f_2);
            --y = df9 + c'f5 + d'f6 + b'f6 + f4
            y := (s_in(3) and f_9) or (not(s_in(2)) and f_5) or (not(s_in(3)) and f_6) or (not(s_in(1)) and f_6) or f_4;
            --z = f2 + af7 + f4 + a'b'd + bf1 + df3
            z := f_2 or (s_in(0) and f_7) or f_4 or (not(s_in(0)) and not(s_in(1)) and s_in(3)) or (s_in(1) and f_1) or (s_in(3) and f_3);
            s_out <= w & x & y & z;
            
--        ELSE
--            --s_out <= "ZZZZ";
--            s_out <= w & x & y & z;
            
            
        end if;
    

    
    end PROCESS;


end Behavioral;
