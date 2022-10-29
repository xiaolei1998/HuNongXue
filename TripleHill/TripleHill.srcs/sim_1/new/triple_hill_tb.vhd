----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2022 09:16:00 PM
-- Design Name: 
-- Module Name: triple_hill_tb - Behavioral
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

entity triple_hill_tb is
end triple_hill_tb;

architecture Behavioral of triple_hill_tb is
    component Triple_Hill_Top PORT  ( clk : in STD_LOGIC;
                                      en : in STD_LOGIC;
                                      cipher_txt : out STD_LOGIC_VECTOR (127 downto 0);
                                      rst : in STD_LOGIC;
                                      done : out STD_LOGIC);
    end component;
    
    
    signal clk_tb : std_logic := '1';
    constant clk_period : time := 8 ns;
    
    
    signal en_tb : std_logic;
    signal rst_tb : std_logic;

    signal cipher_txt_tb : STD_LOGIC_VECTOR (127 downto 0);



    signal done_tb : STD_LOGIC;
        
    
begin

   -- Clock process definitions
   clk_process :process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;

    tb: Triple_Hill_Top port map(clk => clk_tb, 
                                 en=> en_tb,
                                 rst => rst_tb,
                                 --init_key => key_tb,
                                 cipher_txt => cipher_txt_tb,
                                 -- plain_txt => plain_txt_tb,
                                  done => done_tb);
    
    test_n: process
    begin
    
          wait for clk_period;
          wait for clk_period/2;

               

          en_tb <= '1';

          
          
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;          
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          wait for clk_period;
          en_tb <= '0';
          rst_tb <= '1';


   

        
        report "finish";
        
        wait;
    end process;
    
end Behavioral;