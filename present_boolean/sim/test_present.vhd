library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_present is
end test_present;



architecture Behavioral of test_present is

    signal clk_tb : std_logic := '1';
    constant clk_period : time := 8 ns;
    
    
    component PRESENT_Top is
        Port ( en : in STD_LOGIC;
           done : out STD_LOGIC;
           rst  : in STD_LOGIC;
           clk  : in STD_LOGIC;
           in_key : in  STD_LOGIC_VECTOR (7 downto 0);
           in_txt : in  STD_LOGIC_VECTOR (7 downto 0);
           ciphertext : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    SIGNAL en :  STD_LOGIC;
    SIGNAL       done :  STD_LOGIC;
    SIGNAL       rst  :  STD_LOGIC;
    SIGNAL       in_key :   STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL       in_txt :   STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL       ciphertext :  STD_LOGIC_VECTOR (7 downto 0);

begin


    clk_process :process
    begin
		clk_tb <= '0';
		wait for clk_period/2;
		clk_tb <= '1';
		wait for clk_period/2;
   end process;
   
   tb_top : PRESENT_Top PORT MAP(en=>en, done => done, rst=>rst, clk => clk_tb, in_key => in_key, in_txt=> in_txt, ciphertext=>ciphertext);
   
   x : process 
   begin 
   
       wait for clk_period/2;
       en <= '1';
       in_key <= (others => '0');
       in_txt <= (others => '0');
       
       
       
       wait for clk_period;

  
   
   
   end process;



end Behavioral;