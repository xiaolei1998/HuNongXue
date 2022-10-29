----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2022 09:00:51 PM
-- Design Name: 
-- Module Name: Triple_Hill_Top - Behavioral
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

entity Triple_Hill_Top is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           cipher_txt : out STD_LOGIC_VECTOR (127 downto 0);
           done : out STD_LOGIC;
           rst : in STD_LOGIC
           );
end Triple_Hill_Top;

architecture Behavioral of Triple_Hill_Top is


    component round_operation is
           Port ( clk : in STD_LOGIC;
                   en : in STD_LOGIC;
                   key : in STD_LOGIC_VECTOR (1023 downto 0);
                   text_in : in STD_LOGIC_VECTOR (127 downto 0);
                   cipher_ok : out STD_LOGIC_VECTOR (127 downto 0);
                   rst : in STD_LOGIC

                   );
    end component;
    
    component key_schedule is
        Port ( clk : in STD_LOGIC;
               en: in STD_LOGIC;
               key_in: in STD_LOGIC_VECTOR (255 downto 0);
               key_out : out STD_LOGIC_VECTOR (1023 downto 0);
               rst : in STD_LOGIC;
               key_done : out STD_LOGIC );
    end component;
    
    
    component key_holder is
        Port ( clk : in STD_LOGIC;
               en: in STD_LOGIC;
               key : out STD_LOGIC_VECTOR (255 downto 0);
               rst : in STD_LOGIC;
               key_count : in STD_LOGIC_VECTOR (1 downto 0);
               key_fetch_ok : out STD_LOGIC);
               
    end component;
    
    
    component text_holder is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           text_out : out STD_LOGIC_VECTOR (127 downto 0);
           rst : in STD_LOGIC;
           text_fetch_ok : out STD_LOGIC);
    end component;
    
    component mux is 
       generic (
            data_length : integer := 128
            );
            
        PORT(

            sel_mux                         : IN std_logic;
            in1_mux,in0_mux                 :IN std_logic_vector(data_length-1 DOWNTO 0);
            out_mux                         : OUT std_logic_vector(data_length-1 DOWNTO 0));
    end component;
    
    
    
    component demux is
       generic (
            data_length : integer := 128
            );
      
       PORT(
            sel_demux                         : IN std_logic;
            in_demux                          : IN std_logic_vector(data_length-1 DOWNTO 0);
            out_demux1                         : OUT std_logic_vector(data_length-1 DOWNTO 0);
            out_demux2                         : OUT std_logic_vector(data_length-1 DOWNTO 0)

            );
    end component;
    
    component counter is
      GENERIC (
                count : integer := 3
                );
      Port (clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            sel_mux : out STD_LOGIC;
            sel_demux : out STD_LOGIC;
            done : out STD_LOGIC;
            curr_count : out STD_LOGIC_VECTOR(1 downto 0)
            );
            
    end component;
    
    SIGNAL key:STD_LOGIC_VECTOR (1023 downto 0);
    SIGNAL key_256 : STD_LOGIC_VECTOR (255 downto 0);
    SIGNAL txt_128 : STD_LOGIC_VECTOR (127 downto 0);
    SIGNAL key_fetch_b : STD_LOGIC;
    SIGNAL txt_fetch_b : STD_LOGIC;
    SIGNAL subkey_b : STD_LOGIC;
    SIGNAL en_roundcalc: STD_LOGIC;
    
    SIGNAL sel_demux : STD_LOGIC;
    SIGNAL sel_mux : STD_LOGIC;
    SIGNAL out_demux1                         :  std_logic_vector(127 DOWNTO 0);
    SIGNAL in_demux                             :  std_logic_vector(127 DOWNTO 0);
    SIGNAL out_mux                         :  std_logic_vector(127 DOWNTO 0);
    SIGNAL curr_count : STD_LOGIC_VECTOR(1 downto 0);
 
    
    SIGNAL count_round : INTEGER;

begin

    key_BRAM_cpnt : key_holder PORT MAP(
            clk => clk,
            rst => rst,
            en => en,
            key => key_256,
            key_count => curr_count,
            key_fetch_ok => key_fetch_b
            );
            
    plain_txt_BRAM_cpnt : text_holder PORT MAP(
            clk => clk,
            rst => rst,
            en => en,
            text_out => txt_128,
            text_fetch_ok => txt_fetch_b
            );
    

    key_schedule_cpnt : key_schedule PORT MAP(
            clk => clk,
            key_in => key_256,
            rst => rst,
            key_out => key,
            en => key_fetch_b,
            key_done => subkey_b
            );
    
    en_roundcalc <= subkey_b and txt_fetch_b;
    
            
    round_calculation_cpnt : round_operation PORT MAP(
            clk => clk,
            key => key,
            text_in =>out_mux,
            rst => rst,
            cipher_ok => in_demux,
            en => en_roundcalc
            );
            
            
     demux2 : demux generic map(data_length => open)  
                    port map(sel_demux =>sel_demux ,
                    in_demux => in_demux,
                    out_demux1 => out_demux1 ,
                    out_demux2=> cipher_txt);
                    
                    
                    
     mux2 : mux generic map(data_length => open)  
                   port map(sel_mux =>sel_mux ,
                             in1_mux => out_demux1, 
                             in0_mux =>txt_128, 
                             out_mux =>out_mux);
                             
                             
      count_ctr : counter generic map(count => 3)
                          port map(clk => clk,
                                   rst => rst,
                                   sel_mux => sel_mux,
                                   sel_demux => sel_demux,
                                   done => done,
                                   curr_count => curr_count);                   
    

end Behavioral;
