----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2022 04:12:34 AM
-- Design Name: 
-- Module Name: sim_test_key - Behavioral
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

entity sim_test_key is
--  Port ( );
end sim_test_key;

architecture Behavioral of sim_test_key is
    signal clk_tb : std_logic := '1';
    constant clk_period : time := 8 ns;
    
    
    component key_register is
         Port ( in_keyreg : buffer STD_LOGIC_VECTOR (127 downto 0); -- DON"T KNOW Whther ok
           in_keyload : in STD_LOGIC_VECTOR (7 downto 0);
           to_sbox : out STD_LOGIC_VECTOR (7 downto 0);
           clk     : in STD_LOGIC;
           en      : in STD_LOGIC;
           in_sbox : in STD_LOGIC_VECTOR (127 downto 0);
           count : in std_logic_vector(4 DOWNTO 0);  -- counter range from 0 to 31
           out_schedule : out STD_LOGIC_VECTOR (127 downto 0));
    end component;
    
    
          SIGNAL in_keyreg : STD_LOGIC_VECTOR (127 downto 0); -- DON"T KNOW Whther ok
          SIGNAL in_keyload : STD_LOGIC_VECTOR (7 downto 0);
          SIGNAL to_sbox : STD_LOGIC_VECTOR (7 downto 0);

          SIGNAL en      : STD_LOGIC;
          SIGNAL in_sbox : STD_LOGIC_VECTOR (127 downto 0);
          SIGNAL count :  std_logic_vector(4 DOWNTO 0);  -- counter range from 0 to 31
          SIGNAL out_schedule : STD_LOGIC_VECTOR (127 downto 0);
   
begin

 -- Clock process definitions
   clk_process :process
   begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
   
   ktest : key_register PORT MAP(in_keyreg=>in_keyreg, in_keyload=>in_keyload,to_sbox=>to_sbox,en => en,in_sbox=>in_sbox,count=>count,out_schedule=>out_schedule,clk => clk_tb);

   
   process
        variable coutner : integer := 31;
   begin
   
     wait for clk_period/2;
     en <= '1';
     count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;
          count <= std_logic_vector(to_unsigned(coutner, 5));
     coutner := coutner - 1;
     in_keyload <= "11111111";
     wait for clk_period;

     
   
   
   end process;
   


end Behavioral;
