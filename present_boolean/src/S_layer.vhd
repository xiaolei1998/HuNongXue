----------------------------------------------------------------------------------
-- Company: Nationl university of singapore
-- Engineer: zhang xiaolei
-- 
-- Create Date: 10/12/2022 11:25:45 PM
-- Design Name: 
-- Module Name: S_layer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 

        -- A wrapper for S-box layer
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

entity S_layer is
    Port ( s_layer_in : in STD_LOGIC_VECTOR (7 downto 0);
           s_layer_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC
           --enable_s_box : in STD_LOGIC
          );
end S_layer;

architecture Behavioral of S_layer is

COMPONENT S_Box PORT (
           s_in : in STD_LOGIC_VECTOR (3 downto 0);
           s_out : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC
           --enable_s_box : in STD_LOGIC
           );
END COMPONENT;



begin
     S_Box_0 : S_Box PORT MAP(s_in  => s_layer_in(7 downto 4),
                              s_out => s_layer_out(7 downto 4),
                              clk => clk
                              --enable_s_box => enable_s_box
                              );
                              
                              
     S_Box_1 : S_Box PORT MAP(s_in  => s_layer_in(3 downto 0),
                              s_out => s_layer_out(3 downto 0),
                              clk => clk
                              --enable_s_box => enable_s_box
                              );
                              
end Behavioral;

