----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:59 05/18/2020 
-- Design Name: 
-- Module Name:    Pipeline_EX_MEM - Behavioral 
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

entity Pipeline_EX_MEM is
Port (	  RF_WrEn_In 	 : in  STD_LOGIC;
			  RF_WrEn_Out 	 : out  STD_LOGIC;
			  RF_WrEn 		 : in  STD_LOGIC;
           RF_WrData_sel1_En: in  STD_LOGIC;
			  RF_WrData_sel1_In: in  STD_LOGIC;
			  RF_WrData_sel1_Out: out  STD_LOGIC;
			  RF_WrData_sel2_En: in  STD_LOGIC;
			  RF_WrData_sel2_In: in  STD_LOGIC;
			  RF_WrData_sel2_Out: out  STD_LOGIC;
			  CLK 			 : in  STD_LOGIC;
			  RST 			 : in  STD_LOGIC;
			  MeM_WrEn_In		  : in  STD_LOGIC;
			  MeM_WrEn_Out		  : out  STD_LOGIC;
			  MeM_WrEn_En		  : in  STD_LOGIC;
			  Immed_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_En 			 : in  STD_LOGIC;
			  RF_B_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  RF_B_En 			 : in  STD_LOGIC;
			  Write_Reg_In				 : in  STD_LOGIC_VECTOR (4 downto 0);
			  Write_Reg_En				 : in  STD_LOGIC;
			  Write_Reg_Out				 : out  STD_LOGIC_VECTOR (4 downto 0);
			  ALU_Result_In				 : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_Result_En				 : in  STD_LOGIC;
			  ALU_Result_Out				 : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0));
end Pipeline_EX_MEM;

architecture Behavioral of Pipeline_EX_MEM is

component RF is
    Port ( CLK 	 : in  STD_LOGIC;
           RST 	 : in  STD_LOGIC;
           Datain  : in  STD_LOGIC_VECTOR (31 downto 0);
           WE		 : in  STD_LOGIC;
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;		  

 component REG_5B is
    Port ( CLK 	 : in  STD_LOGIC;
           RST 	 : in  STD_LOGIC;
           Datain  : in  STD_LOGIC_VECTOR (4 downto 0);
           WE		 : in  STD_LOGIC;
           Dataout : out  STD_LOGIC_VECTOR (4 downto 0));
 end component;		

 component RegEN is
 Port 	( CLK 	 : in  STD_LOGIC;
           RST 	 : in  STD_LOGIC;
           Datain  : in  STD_LOGIC ;
           WE		 : in  STD_LOGIC;
           Dataout : out  STD_LOGIC );
 end component;			  

begin
RF_WrEn_Reg:RegEN
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RF_WrEn_In,
				WE=>RF_WrEn,
				Dataout=>RF_WrEn_Out);
				
 RF_WrData_sel1_Reg:RegEN
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RF_WrData_sel1_In,
				WE=>RF_WrData_sel1_En,
				Dataout=>RF_WrData_sel1_Out);
				
 RF_WrData_sel2_Reg:RegEN
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RF_WrData_sel2_In,
				WE=>RF_WrData_sel2_En,
				Dataout=>RF_WrData_sel2_Out);			

 MeM_WrEn_Reg:RegEN
 port map (CLK=>CLK,
				RST=>RST,
				Datain=> MeM_WrEn_In,
				WE=> MeM_WrEn_En,
				Dataout=> MeM_WrEn_Out);	


 ALU_Result_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>ALU_Result_In,
				WE=>ALU_Result_En,
				Dataout=>ALU_Result_Out);
				

  Imm_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>Immed_In,
				WE=>Immed_En,
				Dataout=>Immed_Out);

 RF_B_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RF_B_In,
				WE=>RF_B_En,
				Dataout=>RF_B_Out);	

 Write_Reg_Reg:REG_5B
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>Write_Reg_In,
				WE=>Write_Reg_En,
				Dataout=>Write_Reg_Out);						

end Behavioral;

