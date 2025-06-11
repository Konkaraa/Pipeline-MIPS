----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:18:39 04/09/2020 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
Port ( 	  ZERO			  : in STD_LOGIC;
			  INSTRUCTION    : in  STD_LOGIC_VECTOR (31 downto 0);
			  Reset 			  : in STD_LOGIC;
			  MeM_WrEn		  : out  STD_LOGIC;
			  RF_WrEn 		  : out  STD_LOGIC;
			  RF_WrData_sel  : out  STD_LOGIC;
			  RF_WrData_sel2 : out  STD_LOGIC;
			  RF_B_SEL			: out  STD_LOGIC;
			  ALU_Bin_sel 	  : out  STD_LOGIC;
           Clk 			  : in  STD_LOGIC);
end CONTROL;

architecture Behavioral of CONTROL is



begin
	process(Reset,INSTRUCTION,ZERO)
	begin
	If (Reset='1') then			--Reset for some cycle clock to start the processor 
			
				
			RF_B_SEL			<= '0';
			RF_WrEn			<= '0';
			RF_WrData_sel	<= '0';
			RF_WrData_sel2 <= '0'; 
			ALU_Bin_sel		<= '0';
			MEM_WrEn			<= '0';
	Else		

			if(INSTRUCTION="00000000000000000000000000000000") then --Deafult ,in the case we have his instruction
				RF_WrEn	<='0';
				MEM_WrEn <= '0';
			elsif(INSTRUCTION(31 downto 26)="100000") then --add
				RF_WrData_sel  <= '0';
				RF_WrData_sel2 <= '1';
				RF_WrEn	<= '1';
				ALU_Bin_Sel <= '0';
				MeM_WrEn	<= '0';
				RF_B_SEL			<= '0';
			elsif(INSTRUCTION(31 downto 26)="111000") then --Li			
				RF_WrData_sel2 <= '0';
				RF_WrEn	<= '1';
				RF_WrData_sel	<= '0';
				ALU_Bin_Sel <= '1';
				MeM_WrEn	<= '0';
				RF_B_SEL			<= '0';
			elsif(INSTRUCTION(31 downto 26)="011111") then --Sw
				RF_WrEn <='0';
				RF_WrData_sel	<= '0';
				RF_WrData_sel2 <= '0'; 
				ALU_Bin_Sel <= '1';
				MeM_WrEn	<= '1';
				RF_B_SEL			<= '1';
			elsif(INSTRUCTION(31 downto 26)="001111") then --Lw
				ALU_Bin_Sel <= '1';
				Mem_WrEn	<= '0'; 
				RF_WrEn	<='1';
				RF_WrData_sel <= '1';
				RF_WrData_sel2 <= '1';
				RF_B_SEL			<= '0';
			end if;
		end If;	
	end process;

end Behavioral;

