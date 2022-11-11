----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2022 12:21:42 AM
-- Design Name: 
-- Module Name: PRESENT_Top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
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

entity PRESENT_Top is
    Port ( en : in STD_LOGIC;
           done : out STD_LOGIC;
           rst  : in STD_LOGIC;
           clk  : in STD_LOGIC;
           in_key : in  STD_LOGIC_VECTOR (7 downto 0);
           in_txt : in  STD_LOGIC_VECTOR (7 downto 0);
           ciphertext : out STD_LOGIC_VECTOR (7 downto 0));
end PRESENT_Top;

architecture Behavioral of PRESENT_Top is

    --key will be updated every 9 clock 

    component key_register is
        Port ( --in_keyreg : buffer STD_LOGIC_VECTOR (127 downto 0); 
           in_keyload : in STD_LOGIC_VECTOR (7 downto 0);
           in_sbox : out STD_LOGIC_VECTOR (7 downto 0);
           clk     : in STD_LOGIC;
           --en_load : in STD_LOGIC;
           out_sbox : in STD_LOGIC_VECTOR (7 downto 0);
           count31 : in std_logic_vector(4 DOWNTO 0);  -- counter range from 0 to 31
           count9  : in std_logic_vector(3 DOWNTO 0);
           load_counter : in std_logic_vector(4 DOWNTO 0);
           out_key : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component;
    
    
    component mux is 
        PORT(
            sel_mux          : IN std_logic;
            in1_mux,in0_mux  :IN std_logic_vector(7 DOWNTO 0);
            out_mux          : OUT std_logic_vector(7 DOWNTO 0));
    end component;
    
    
    component S_layer is
        Port ( s_layer_in : in STD_LOGIC_VECTOR (7 downto 0);
           s_layer_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC
           --enable_s_box : in STD_LOGIC
          );
    end component;
    
    
    component controller is
        Port (clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en  : in STD_LOGIC;
        sel_mux31 : out STD_LOGIC_VECTOR(4 downto 0);
        sel_mux9 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    
    component data_register is
        Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           --en_load : in STD_LOGIC;
           ctr_9 : in STD_LOGIC_VECTOR(3 downto 0);
           ctr_31 : in STD_LOGIC_VECTOR(4 downto 0);
           to_player : out STD_LOGIC_VECTOR (63 downto 0);
           from_player : in STD_LOGIC_VECTOR (63 downto 0));
    end component;
    
    
    component permutation_layer is
        Port ( in_permu : in STD_LOGIC_VECTOR (63 downto 0);
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           out_permu : out STD_LOGIC_VECTOR (63 downto 0));
    end component;
    
    component load_counter is
         Port ( clk : in STD_LOGIC;
           load_31 : out STD_LOGIC_VECTOR (4 downto 0);
           --load_31 : INTEGER;
           en_load : in STD_LOGIC;
           done : out STD_LOGIC
           );
    end component;

    
    
    SIGNAL in_datareg :STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL out_datareg :STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL ctr_31 : STD_LOGIC_VECTOR(4 downto 0);
    SIGNAL ctr_9 : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL in_player : STD_LOGIC_VECTOR(63 downto 0);
    SIGNAL out_player : STD_LOGIC_VECTOR(63 downto 0);
    SIGNAL in_slayer : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL out_slayer : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL key_updated : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL key_add_data : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL in_key_sbox  : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL state1  : STD_LOGIC; 
    SIGNAL state2  : STD_LOGIC;
    SIGNAL load_done  : STD_LOGIC := '0'; --=1 when load finish
    SIGNAL loader_31  : STD_LOGIC_VECTOR(4 downto 0);
    --SIGNAL loader_31  : INTEGER;

begin

    loader : load_counter 
                    PORT MAP(
                        clk => clk,
                        load_31 => loader_31,
                        done => load_done,
                        en_load => en); --when the "en" signal from present top = 1; start loading data!
                        

    datareg : data_register 
                    PORT MAP(
                            data_in => in_datareg,
                            data_out => out_datareg,
                            clk =>clk,
                            --en_load => en,
                            ctr_9 => ctr_9,
                            ctr_31 => loader_31,
                            to_player => in_player,
                            from_player=> out_player);
                            
                            
    keyreg : key_register
                    PORT MAP(
                        in_keyload => in_key,
                        in_sbox => in_key_sbox,
                        clk => clk,
                        --en_load => en,                  
                        out_sbox => out_slayer,
                        load_counter => loader_31,
                        count31 => ctr_31,
                        count9 => ctr_9,
                        out_key => key_updated
                        );
                        
                        
    ctrl : controller
                PORT MAP(
                    clk => clk,
                    rst => rst,
                    en => load_done,
                    sel_mux31 => ctr_31,
                    sel_mux9 => ctr_9
                );
    
    
                
    state1 <= en NAND load_done;  --- when en = 1 from top, then load data, use channel 1

    mux1 : mux PORT MAP(
                        sel_mux => state1,
                        in0_mux => out_slayer,
                        in1_mux => in_txt,
                        out_mux => in_datareg
                        );


    player : permutation_layer
                    PORT MAP(
                            in_permu => in_player,
                            clk => clk,
                            rst => rst,                            
                            out_permu => out_player);
    
    
    slayer : S_layer
                    PORT MAP(
                        s_layer_in => in_slayer,
                        s_layer_out => out_slayer,
                        clk => clk);
                        
                        
    state2 <=  ((ctr_9(0) NOR ctr_9(1)) NOR ctr_9(2)) NOR ctr_9(3);  
    --When ctr9 = 0,  state2 = '1' ,use sbox to sub_key,
    --otherwise state = 0, use sbox to sub_txt
               
    mux2 : mux PORT MAP(
                        sel_mux => state2, 
                        in0_mux => key_add_data,
                        in1_mux => in_key_sbox,
                        out_mux => in_slayer
                        );
    
    
    
    --TODO: specify state
    
    key_add_data <= key_updated XOR out_datareg;
    
    ciphertext <= key_add_data;

end Behavioral;
