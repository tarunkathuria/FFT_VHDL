----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:39:15 04/11/1413 
-- Design Name: 
-- Module Name:    adder16bit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--Number representation (32 total bits) : 16 bits for real part and 16 bits for imaginary part.
--Now in the 16 bit: 1 sign bit, 7 bits to represent the integral part,  and 8 to represent the fractional part-- 16 bit adder
-- two inputs : inputa and inputb
-- output : result
-- addition is done using the arith and unsigned ieee library 

entity adder16bit is
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end adder16bit;

architecture Behavioral of adder16bit is

--temperory signal to hold the value of result inside process
signal tempResult : STD_LOGIC_VECTOR (15 downto 0):=(others=>'0');

begin

--the main process begins. the sensitivity list being both the inputs as a change in them 
--demands re-evaluation
addition : process(inputa , inputb) is
begin
	--case 1: when the sign is the same for both the number
	--This case needs us to just add the two numbers and assign the sign bit same as either numbers
	if(inputa(15) = inputb(15)) then
		tempResult(14 downto 0) <= inputa(14 downto 0) + inputb(14 downto 0);
		tempResult(15) <= inputa(15);
	--case 2: inputb is negative
	--Depending on which is greater among the two inputs appropriate sign is to the modulus of inputa - inputb
	elsif(inputb(15) = '1') then
		if(inputa(14 downto 0) > inputb(14 downto 0)) then
			tempResult(15) <= '0';
			tempResult(14 downto 0) <= inputa(14 downto 0) - inputb(14 downto 0);
		else
			tempResult(15) <= '1';
			tempResult(14 downto 0) <= inputb(14 downto 0) - inputa(14 downto 0);
		end if;
	--case 2: inputa is negative
	--Depending on which is greater among the two inputs appropriate sign is to the modulus of inputa - inputb
	elsif(inputa(15) = '1') then
		if(inputa(14 downto 0) > inputb(14 downto 0)) then
			tempResult(15) <= '1';
			tempResult(14 downto 0) <= inputa(14 downto 0) - inputb(14 downto 0);
		else
			tempResult(15) <= '0';
			tempResult(14 downto 0) <= inputb(14 downto 0) - inputa(14 downto 0);
		end if;
	else
	end if;
end process addition;
			
result <= tempResult;
end Behavioral;

