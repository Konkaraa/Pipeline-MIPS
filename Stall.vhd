----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:23 05/18/2020 
-- Design Name: 
-- Module Name:    Stall - Behavioral 
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

entity Stall is
 PoRt ( CLK : in STD_LOGIC;
			  RST	: in  STD_LOGIC;
			  Rs : in  STD_LOGIC_VECTOR (4 downto 0);
           Rt : in  STD_LOGIC_VECTOR (4 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           IDEX_Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           PC_LdEn : out  STD_LOGIC;
			  Inst_En : out  STD_LOGIC);
end Stall;

architecture Behavioral of Stall is


type state is (A,B);
signal current_state,next_state: state;

begin
	
	process (CLK)
	begin
		if (RST ='1') then
			current_state <= B;
		elsif (rising_edge(CLK)) then
		  current_state <= next_state;
		end if;
	end process;
	
	process(current_state,Opcode,Rs,Rt)
	begin
		case current_state is

		when A =>
			PC_LdEn <= '0';
			Inst_En <= '0';
			next_state <= B;
		when B =>
			if ( Opcode = "001111" AND (Rs =IDEX_Rd OR Rt =IDEX_Rd)) then
				PC_LdEn <= '0';
				Inst_En <= '0';
				next_state <= A;
			else
				PC_LdEn <= '1';
				Inst_En <= '1';
				next_state <= B;
			end if;
			
		end case;
	end process;

end Behavioral;

