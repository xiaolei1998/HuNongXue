----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 11:38:45 PM
-- Design Name: 
-- Module Name: test_s_layer - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_s_layer is
end test_s_layer;

architecture Behavioral of test_s_layer is
    component S_layer PORT  ( s_layer_in : in STD_LOGIC_VECTOR (7 downto 0);
                              s_layer_out : out STD_LOGIC_VECTOR (7 downto 0);
                              clk : in STD_LOGIC;
                              enable_s_box : in STD_LOGIC
                              );
    end component;
    
    signal clk_tb : std_logic := '1';
    constant clk_period : time := 8 ns;
    
    
    signal input_tb_slayer : STD_LOGIC_VECTOR(7 downto 0);
    signal output_tb_slayer : STD_LOGIC_VECTOR(7 downto 0);
    signal enable_s_box : STD_LOGIC := '0';
    
begin

   -- Clock process definitions
   clk_process :process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;

    tb1 : S_layer PORT MAP (s_layer_in => input_tb_slayer, s_layer_out =>output_tb_slayer, clk => clk_tb,enable_s_box => enable_s_box);
    
    test_n: process
    begin
    
--        wait for clk_period/2;


--        --test 1: in 0F -> out C2
--        enable_s_box <= '1';
--        input_tb_slayer <= "00001111";
--        wait for clk_period;
--        enable_s_box <= '0';
--        wait for clk_period;

        
        
--        wait for clk_period;
       
--        --test 2: in 1E -> out 51 
--        enable_s_box <= '1';
--        input_tb_slayer <= "00011110";
--        wait for clk_period;
--        enable_s_box <= '0';
--        wait for clk_period;


----------------------------------------------
        wait for clk_period/2;
    
        --test 1: in 0F -> out C2
        enable_s_box <= '1';
        input_tb_slayer <= "00001111";
--        wait for clk_period;
        
--        --test 2: in 1E -> out 51
--        input_tb_slayer <= "00011110";
--        wait for clk_period;
        
        
        
--        --input 2D -> out 67
--        input_tb_slayer <= "00101101";
--        wait for clk_period;
        
        
--       --input 3C -> out B4
--        input_tb_slayer <= "00111100";
--        wait for clk_period;

--       --input 4B -> out 98
--        input_tb_slayer <= "01001011";
--        wait for clk_period;
        
--        --input 5A -> out 0F
--        input_tb_slayer <= "01011010";
--        wait for clk_period;
        
        
--        --input 69 -> out AE
--        input_tb_slayer <= "01101001";
--        wait for clk_period;
        
        
        
--        --input 78 -> out D3
--        input_tb_slayer <= "01111000";
--        wait for clk_period;
        
        
--        input_tb_slayer <= "UUUUUUUU";
--        enable_s_box <= '0';
        
        
        

        
        
        
        
        report "finish";
        
        wait;
    end process;
    
end Behavioral;
