----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:44:10 05/18/2020 
-- Design Name: 
-- Module Name:    Pipeline_Reg - Behavioral 
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

entity Pipeline_ID_EX is
Port (	  RF_WrEn_In 	 : in  STD_LOGIC;
			  RF_WrEn_Out 	 : out  STD_LOGIC;
			  RF_WrEn 		 : in  STD_LOGIC;
           RF_A_In 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_A_En		 : in  STD_LOGIC;
			  RF_B_En		 : in  STD_LOGIC;
			  RF_B_In 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel1_En: in  STD_LOGIC;
			  RF_WrData_sel1_In: in  STD_LOGIC;
			  RF_WrData_sel1_Out: out  STD_LOGIC;
			  RF_WrData_sel2_En: in  STD_LOGIC;
			  RF_WrData_sel2_In: in  STD_LOGIC;
			  RF_WrData_sel2_Out: out  STD_LOGIC;
           ALU_Bin_sel_In 	  : in  STD_LOGIC;
			  ALU_Bin_sel_Out 	  : out  STD_LOGIC;
			  ALU_Bin_sel_En 	  : in  STD_LOGIC; 
			  CLK 			 : in  STD_LOGIC;
			  RST 			 : in  STD_LOGIC;
			  MeM_WrEn_In		  : in  STD_LOGIC;
			  MeM_WrEn_Out		  : out  STD_LOGIC;
			  MeM_WrEn_En		  : in  STD_LOGIC;
           Immed_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_En 			 : in  STD_LOGIC;
			  IDEXinstr_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  IDEXinstr_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IDEXinstr_En  			 : in  STD_LOGIC;
			  RD_In				 : in  STD_LOGIC_VECTOR (4 downto 0);
			  RD_En				 : in  STD_LOGIC;
			  RD_Out				 : out  STD_LOGIC_VECTOR (4 downto 0);
			  RS_In				 : in  STD_LOGIC_VECTOR (4 downto 0);
			  RS_En				 : in  STD_LOGIC;
			  RS_Out				 : out  STD_LOGIC_VECTOR (4 downto 0);
			  RT_In				 : in  STD_LOGIC_VECTOR (4 downto 0);
			  RT_En				 : in  STD_LOGIC;
			  RT_Out				 : out  STD_LOGIC_VECTOR (4 downto 0);
           RF_A_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0));
end Pipeline_ID_EX;

architecture Behavioral of Pipeline_ID_EX is

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
 
 ALU_Bin_sel_Reg:RegEN
 port map (CLK=>CLK,
				RST=>RST,
				Datain=> ALU_Bin_sel_In,
				WE=> ALU_Bin_sel_En,
				Dataout=> ALU_Bin_sel_Out);
 
 MeM_WrEn_Reg:RegEN
 port map (CLK=>CLK,
				RST=>RST,
				Datain=> MeM_WrEn_In,
				WE=> MeM_WrEn_En,
				Dataout=> MeM_WrEn_Out);
 
 
 
 RF_A_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RF_A_In,
				WE=>RF_A_En,
				Dataout=>RF_A_Out);

 RF_B_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RF_B_In,
				WE=>RF_B_En,
				Dataout=>RF_B_Out);
				
				
 Imm_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>Immed_In,
				WE=>Immed_En,
				Dataout=>Immed_Out);
	

idex_instr_Reg:RF
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>IDEXinstr_In,
				WE=>Immed_En,
				Dataout=>IDEXinstr_Out);
 RD_Reg:REG_5B
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RD_In,
				WE=>RD_En,
				Dataout=>RD_Out);		
				
 RS_Reg:REG_5B
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RS_In,
				WE=>RS_En,
				Dataout=>RS_Out);					

 RT_Reg:REG_5B
 port map (CLK=>CLK,
				RST=>RST,
				Datain=>RT_In,
				WE=>RT_En,
				Dataout=>RT_Out);	

 				
 
end Behavioral;

