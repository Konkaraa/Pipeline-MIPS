----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:22 05/18/2020 
-- Design Name: 
-- Module Name:    Forward - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool veRsions: 
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

entity Forward is
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
end Forward;

architecture Behavioral of Forward is

begin
process(Rs,Rt,RF_WR_En_EX_MEM,RF_WR_En_MEM_WB)
begin
	if((Rs = Rd_EX_MEM OR Rt = Rd_EX_MEM) AND RF_WR_En_EX_MEM = '1' AND PC_LdEn = '1') then
		if(Rs = Rd_EX_MEM) then
			Forward_A <= "01";
		else
			Forward_A <= "00";
		end if;
		if(Rt = Rd_EX_MEM) then
			Forward_B <= "01";
		else
			Forward_B <= "00";
		end if;

	elsif((Rs = Rd_MEM_WB OR Rt = Rd_MEM_WB) AND RF_WR_En_MEM_WB = '1' AND PC_LdEn = '1') then
		if(Rs = Rd_MEM_WB) then
			Forward_A <= "10";
		else
			Forward_A <= "00";
		end if;
		if(Rt = Rd_MEM_WB) then
			Forward_B <= "10";
		else
			Forward_B <= "00";
		end if;
	else
		Forward_A <= "00";
		Forward_B <= "00";
	end if;
end process;

end Behavioral;

