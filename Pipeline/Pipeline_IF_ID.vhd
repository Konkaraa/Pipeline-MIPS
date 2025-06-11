----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:43 05/18/2020 
-- Design Name: 
-- Module Name:    Pipeline_IF_ID - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipeline_IF_ID is
Port		(CLK 			 : in  STD_LOGIC;
			  RST 			 : in  STD_LOGIC;
           Inst_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Inst_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Inst_En 			 : in  STD_LOGIC);
end Pipeline_IF_ID;

architecture Behavioral of Pipeline_IF_ID is

component RF is
    Port ( CLK 	 : in  STD_LOGIC;
           RST 	 : in  STD_LOGIC;
           Datain  : in  STD_LOGIC_VECTOR (31 downto 0);
           WE		 : in  STD_LOGIC;
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;		  

begin
Instr_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>Inst_In,
				WE=>Inst_En,
				Dataout=>Inst_Out);

end Behavioral;

