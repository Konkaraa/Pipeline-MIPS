----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:43 04/05/2020 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
    Port ( ZERO			  	 : out STD_LOGIC;
			  Datapath_Data  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out  	 		 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_Addr  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_WrEn  	 : out  STD_LOGIC;
			  INSTRUCTION  	 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Control_Instr  	 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Datapath_RdData  : in  STD_LOGIC_VECTOR (31 downto 0);
			  Reset 			  	 : in  STD_LOGIC;
			  MeM_WrEn		 	 : in  STD_LOGIC;
			  RF_WrEn 			 : in  STD_LOGIC;
			  RF_WrData_sel  	 : in  STD_LOGIC;
			  RF_B_SEL			 : in  STD_LOGIC;
			  RF_WrData_sel2 	 : in  STD_LOGIC;
			  ALU_Bin_sel 	 	 : in  STD_LOGIC;
           Clk 			 	 : in  STD_LOGIC);
end DATAPATH;

	architecture Behavioral of DATAPATH is

 component IFSTAGE is
 Port		 (PC_Immed 	: in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel 	: in  STD_LOGIC;
           PC_LdEn 	: in  STD_LOGIC;
           Reset 		: in  STD_LOGIC;
           Clk 		: in  STD_LOGIC;
           PC 			: out  STD_LOGIC_VECTOR (31 downto 0));
 end component;

 component Mux2_Alu_A is
	Port 	   ( EX_MEM_ALU_Out		  : in  STD_LOGIC_VECTOR (31 downto 0);
           ID_EX_RF_A 		  : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_WB_MUX_Out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           ForwardA  : in  STD_LOGIC_VECTOR (1 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;
 
 component MuxForward_B is
Port 	   ( EX_MEM_ALU_Out		  : in  STD_LOGIC_VECTOR (31 downto 0);
           ID_EX_RF_B 		  : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_WB_MUX_Out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           ForwardB  : in  STD_LOGIC_VECTOR (1 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;
 
 component Pipeline_EX_MEM is
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
 end component;
 
 component Pipeline_ID_EX is
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
			  IDEXinstr_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  IDEXinstr_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  IDEXinstr_En  			 : in  STD_LOGIC;
           Immed_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_En 			 : in  STD_LOGIC;
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
 end component;
 
 component Pipeline_IF_ID is
 Port		(CLK 			 : in  STD_LOGIC;
			  RST 			 : in  STD_LOGIC;
           Inst_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Inst_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Inst_En 			 : in  STD_LOGIC);
 end component;			  
 
 
 component Pipeline_MEM_WB is
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
			  Immed_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Immed_En 			 : in  STD_LOGIC;
			  Mem_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Mem_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Mem_En 			 : in  STD_LOGIC;
			  Write_Reg_Back_In				 : in  STD_LOGIC_VECTOR (4 downto 0);
			  Write_Reg_Back_En				 : in  STD_LOGIC;
			  Write_Reg_Back_Out				 : out  STD_LOGIC_VECTOR (4 downto 0);
			  ALU_Out 			 : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_In 			 : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_En 			 : in  STD_LOGIC);
 end component;
 

 component Forward is
 poRt( PC_LdEn	: in STD_LOGIC;
			Rs 		: in STD_LOGIC_VECTOR (4 downto 0);
			Rt			: in STD_LOGIC_VECTOR (4 downto 0);
			
			Rd			: in STD_LOGIC_VECTOR (4 downto 0);
			Rd_EX_MEM	: in STD_LOGIC_VECTOR (4 downto 0);
			RF_WR_En_EX_MEM	: in STD_LOGIC;
			Rd_MEM_WB	: in STD_LOGIC_VECTOR (4 downto 0);
			RF_WR_En_MEM_WB	: in STD_LOGIC;
			Forward_A		: out STD_LOGIC_VECTOR (1 downto 0);
			Forward_B	: out STD_LOGIC_VECTOR (1 downto 0)
			); 
 end component;
 
 component DECSTAGES is
    Port ( Instr 			 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn 		 : in  STD_LOGIC;
           MUX_Out		 : in  STD_LOGIC_VECTOR (31 downto 0);
           WriteRegister: in  STD_LOGIC_VECTOR (4 downto 0);
           ImmExt 		 : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk 			 : in  STD_LOGIC;
			  Rst 			 : in  STD_LOGIC;
			  RF_B_SEL		 : in  STD_LOGIC;
           Immed 			 : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A 			 : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 			 : out  STD_LOGIC_VECTOR (31 downto 0));
 end component;

component Stall is
 PoRt ( 	  CLK : in STD_LOGIC;
			  RST	: in  STD_LOGIC;
			  Rs : in  STD_LOGIC_VECTOR (4 downto 0);
           Rt : in  STD_LOGIC_VECTOR (4 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           IDEX_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           PC_LdEn : out  STD_LOGIC;
			  Inst_En : out  STD_LOGIC);
end component;

 component EXSTAGES is
    Port ( RF_A 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed 		 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel: in  STD_LOGIC;
           ALU_func 	 : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out 	 : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero	 : out  STD_LOGIC);
 end component;			  

 component MEMSTAGES is
    Port ( clk				: in  STD_LOGIC;
			  ByteOp 		: in  STD_LOGIC;
           Mem_WrEn  	: in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn 	: in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut  : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr 		: out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEN 		: out  STD_LOGIC;
			  MM_RdData    : in  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData 	: out  STD_LOGIC_VECTOR (31 downto 0)
           );
  end component; 
 
 component Mux2_DEC1 is
    Port ( ALU_out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out 		  : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel1  : in  STD_LOGIC;
           Out_Write_Data : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;

 component Mux2_DEC3 is
 Port 	 (Imm 		  			: in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out 		   	: in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel2     : in  STD_LOGIC;
           Out_Write_Data_Imm : out  STD_LOGIC_VECTOR (31 downto 0));
	 end component;
 
 
 signal temp_RF_B ,temp_RF_A,temp_INSTRUCTION,temp1_INSTRUCTION : STD_LOGIC_VECTOR (31 downto 0);
 signal temp_ALU_out,temp_MEM_out,temp_Immed: STD_LOGIC_VECTOR (31 downto 0);
 signal temp_RF_WrData_sel,temp_RF_WrData_sel2,temp_RF_WrEn: STD_LOGIC;
 signal temp1_ALU_Bin_sel,temp_MeM_WrEn,temp1_RF_WrEn : STD_LOGIC;
 signal temp1_Immed : STD_LOGIC_VECTOR (31 downto 0);
 signal temp1_INSTRUCTION_RD,temp1_INSTRUCTION_RT ,temp1_INSTRUCTION_RS,temp3_INSTRUCTION_RD,temp2_INSTRUCTION_RD	 : STD_LOGIC_VECTOR (4 downto 0);
 signal temp1_RF_A,temp1_RF_B: STD_LOGIC_VECTOR (31 downto 0);
 signal temp2_RF_A,temp2_RF_B: STD_LOGIC_VECTOR (31 downto 0);
 signal temp1_RF_WrData_sel,temp1_RF_WrData_sel2,temp2_RF_WrEn,temp_PC_LdEn,temp_Inst_En :STD_LOGIC;
 signal temp1_MeM_WrEn :STD_LOGIC;
 signal temp3_RF_B,temp1_ALU_out: STD_LOGIC_VECTOR (31 downto 0);
 signal temp2_RF_WrData_sel2,temp2_RF_WrData_sel,temp3_RF_WrEn :STD_LOGIC;
 signal temp2_ALU_out,temp1_MEM_out : STD_LOGIC_VECTOR (31 downto 0);
 signal temp_Forward_A,temp_Forward_B : STD_LOGIC_VECTOR (1 downto 0);
 signal dec1_out1,dec1_out2  : STD_LOGIC_VECTOR (31 downto 0);
 signal temp3_Immed,temp2_Immed : STD_LOGIC_VECTOR (31 downto 0);
 
 
 begin
 IFWHOLE_label:IFSTAGE
 port map(PC_Immed=>temp_Immed,
			 Reset=>	Reset,
			 Clk=>Clk,
			 PC_LdEn=>temp_PC_LdEn,
			 PC_sel=>'0',
			 PC=>PC_out);
 
 Pipeline_IF_ID_Label:Pipeline_IF_ID 
 Port	map	(CLK=>Clk, 			 
			  RST=>Reset, 			 
           Inst_Out=>temp_INSTRUCTION,			 
			  Inst_In=>INSTRUCTION,  			 
			  Inst_En=>temp_Inst_En );
 
 DECSTAGES_label:DECSTAGES
 port map(Instr=>temp_INSTRUCTION  ,
			 RF_WrEn=>temp2_RF_WrEn,
			 ImmExt=>"00",
			 WriteRegister=>temp3_INSTRUCTION_RD,
			 Clk=>Clk,
			 Rst=>Reset,
			 RF_B_SEL=>RF_B_SEL,
			 MUX_Out=>dec1_out2,
			 Immed=>temp_Immed,
			 RF_A=>temp_RF_A, 
			 RF_B=>temp_RF_B); 

 Pipeline_ID_EX_Label:Pipeline_ID_EX 
Port map ( RF_WrEn_In=>RF_WrEn, 	 
			  RF_WrEn_Out=>temp_RF_WrEn, 	 
			  RF_WrEn=>'1', 		 
           RF_A_In=>temp_RF_A, 		 
           RF_A_En=>'1',		
			  RF_B_En=>'1',		 
			  RF_B_In=>temp_RF_B, 		 
           RF_WrData_sel1_En=>'1',
			  RF_WrData_sel1_In=>RF_WrData_sel,
			  RF_WrData_sel1_Out=>temp_RF_WrData_sel,
			  RF_WrData_sel2_En=>'1',
			  RF_WrData_sel2_In=>RF_WrData_sel2,
			  RF_WrData_sel2_Out=>temp_RF_WrData_sel2,
           ALU_Bin_sel_In=>ALU_Bin_sel, 	  
			  ALU_Bin_sel_Out=>temp1_ALU_Bin_sel, 	  
			  ALU_Bin_sel_En=>'1', 	  
			  CLK=>Clk, 			 
			  RST=>Reset, 			 
			  MeM_WrEn_In=>MeM_WrEn,		  
			  MeM_WrEn_Out=>temp_MeM_WrEn,		  
			  MeM_WrEn_En=>'1',
			  IDEXinstr_Out =>temp1_INSTRUCTION,			
			  IDEXinstr_In=>temp_INSTRUCTION,		 
			  IDEXinstr_En =>'1', 			 		  
           Immed_Out=>temp1_Immed, 			
			  Immed_In=>temp_Immed, 			 
			  Immed_En=>'1', 			
			  RD_In=>temp_INSTRUCTION(20 downto 16),				 
			  RD_En=>'1',				
			  RD_Out=>temp1_INSTRUCTION_RD,				 
			  RT_In=>temp_INSTRUCTION(15 downto 11),				 
			  RT_En=>'1',				 
			  RT_Out=>temp1_INSTRUCTION_RT,
			  RS_In=>temp_INSTRUCTION(25 downto 21),				
			  RS_En=>'1',				
			  RS_Out=>temp1_INSTRUCTION_RS,				 
           RF_A_Out=>temp1_RF_A, 			
           RF_B_Out=>temp1_RF_B 	);
	
 ForwardA_Label:Mux2_Alu_A 
	Port map	   ( EX_MEM_ALU_Out=>temp1_ALU_out,		  
           ID_EX_RF_A=>temp1_RF_A, 		 
			  MEM_WB_MUX_Out=>dec1_out2 ,		 
           ForwardA=>temp_Forward_A,  
           RF_A=>temp2_RF_A );
 
 
 ForwardB_Label: MuxForward_B 
 Port map   ( EX_MEM_ALU_Out=>temp1_ALU_out,		  
           ID_EX_RF_B=>temp1_RF_B ,		 
			  MEM_WB_MUX_Out=>dec1_out2 		, 
           ForwardB=>temp_Forward_B,  
           RF_B=>temp2_RF_B );
	
 EXSTAGES_label:EXSTAGES
 port map( RF_A=>temp2_RF_A,
			  RF_B=>temp2_RF_B,
			  Immed=>temp1_Immed,
			  ALU_out=>temp_ALU_out, 
			  ALU_Bin_sel=>temp1_ALU_Bin_sel,
			  ALU_func=>"0000",
			  ALU_zero=>ZERO );
 
 Pipeline_EX_MEM_Label:Pipeline_EX_MEM 
Port map  (RF_WrEn_In=>temp_RF_WrEn, 	 
			  RF_WrEn_Out=>temp1_RF_WrEn, 	 
			  RF_WrEn=>'1', 		 
           RF_WrData_sel1_En=>'1',
			  RF_WrData_sel1_In=>temp_RF_WrData_sel,
			  RF_WrData_sel1_Out=>temp1_RF_WrData_sel,
			  RF_WrData_sel2_En=>'1',
			  RF_WrData_sel2_In=>temp_RF_WrData_sel2,
			  RF_WrData_sel2_Out=>temp1_RF_WrData_sel2,
			  CLK=>Clk ,			 
			  RST=>Reset, 			 
			  MeM_WrEn_In=>temp_MeM_WrEn,		  
			  MeM_WrEn_Out=>temp1_MeM_WrEn,		  
			  MeM_WrEn_En=>'1',		  
			  RF_B_In=>temp2_RF_B, 			 
			  RF_B_En=>'1', 
			  Immed_Out=>temp2_Immed, 			
			  Immed_In=>temp1_Immed, 			 
			  Immed_En=>'1', 				  
			  Write_Reg_In=>temp1_INSTRUCTION_RD,				 
			  Write_Reg_En=>'1',				
			  Write_Reg_Out=>temp2_INSTRUCTION_RD,				 
			  ALU_Result_In=>temp_ALU_out,				 
			  ALU_Result_En=>'1',				
			  ALU_Result_Out=>temp1_ALU_out,				 
           RF_B_Out =>temp3_RF_B	 ); 
 
 MEMSTAGE_label:MEMSTAGES
 port map (ByteOp => '0',
			  Clk => Clk,
           Mem_WrEn => temp1_Mem_WrEn,
           ALU_MEM_Addr => temp1_ALU_out,
           MEM_DataIn => temp3_RF_B,
           MEM_DataOut => temp_MEM_out,
			  MM_Addr =>Datapath_Addr,
           MM_WrEn => Datapath_WrEn,
			  MM_RdData=>Datapath_RdData,
           MM_WrData => Datapath_Data );
 
 Pipeline_MEM_WB_Label:Pipeline_MEM_WB 
Port  map( RF_WrEn_In=>temp1_RF_WrEn, 	
			  RF_WrEn_Out=>temp2_RF_WrEn, 	
			  RF_WrEn=>'1', 		 
			  RF_WrData_sel1_En=>'1',
			  RF_WrData_sel1_In=>temp1_RF_WrData_sel,
			  RF_WrData_sel1_Out=>temp2_RF_WrData_sel,
			  RF_WrData_sel2_En=>'1',
			  RF_WrData_sel2_In=>temp1_RF_WrData_sel2,
			  RF_WrData_sel2_Out=>temp2_RF_WrData_sel2,
			  CLK=>Clk, 			 
			  RST=>Reset, 
			  Immed_Out=>temp3_Immed, 			
			  Immed_In=>temp2_Immed, 			 
			  Immed_En=>'1', 	
			  Mem_Out=>temp1_MEM_out, 			
			  Mem_In=>temp_MEM_out,			 
			  Mem_En=>'1', 			
			  Write_Reg_Back_In=>temp2_INSTRUCTION_RD,				
			  Write_Reg_Back_En=>'1',				 
			  Write_Reg_Back_Out=>temp3_INSTRUCTION_RD,				 
			  ALU_Out=>temp2_ALU_out, 			 
			  ALU_In=>temp1_ALU_out, 			
			  ALU_En=>'1' 			);
			  
 Forward_Label:Forward 
 poRt map( PC_LdEn=>temp_PC_LdEn,	
			Rs=>temp1_INSTRUCTION_RS, 		
			Rt=>temp1_INSTRUCTION_RT,
			
			Rd=>temp1_INSTRUCTION_RD,
			Rd_EX_MEM=>temp2_INSTRUCTION_RD,	
			RF_WR_En_EX_MEM=>temp1_RF_WrEn,	
			Rd_MEM_WB=>temp3_INSTRUCTION_RD,	
			RF_WR_En_MEM_WB=>	temp2_RF_WrEn, 
			Forward_A=>temp_Forward_A,		
			Forward_B=>temp_Forward_B	);  
 
 
 Mux2_DEC1_label:Mux2_DEC1
 port map(ALU_out=>temp2_ALU_out,
			 MEM_out=>temp1_MEM_out,
			 RF_WrData_sel1=>temp2_RF_WrData_sel,
			 Out_Write_Data=>dec1_out1);

 
			 
 Mux2_DEC3_label:Mux2_DEC3 --This Mux is when we want to do Li and Lui to take the Imm address
 port map(Imm=>temp3_Immed,
			 Mux_out=>dec1_out1,
			 RF_WrData_sel2=>temp2_RF_WrData_sel2,
			 Out_Write_Data_Imm=>dec1_out2); 
			 
STALL_label:Stall			 
 Port map ( 	  CLK =>Clk,
			  RST	=>Reset,
			  Rs =>temp_INSTRUCTION(25 downto 21),
           Rt =>temp_INSTRUCTION(15 downto 11),
           Opcode=>temp1_INSTRUCTION(31 downto 26),
           IDEX_Rd =>temp1_INSTRUCTION_RD,
           PC_LdEn =>temp_PC_LdEn,
			  Inst_En =>temp_Inst_En);			 
			 
			 
Control_Instr<=temp_INSTRUCTION;			 
 
end Behavioral;

