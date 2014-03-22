----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:56:16 04/11/1413 
-- Design Name: 
-- Module Name:    subtractor16bit - Behavioral 
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
--Now in the 16 bit: 1 sign bit, 7 bits to represent the integral part,  and 8 to represent the fractional part
--16 bit subtractor
-- two inputs : inputa and inputb
-- output : result
-- subtraction is done using the arith and unsigned ieee library 


entity subtractor16bit is
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end subtractor16bit;

architecture Behavioral of subtractor16bit is

--temperory signal to hold the value of the difference during the process
signal tempResult : STD_LOGIC_VECTOR (15 downto 0):=(others=>'0');

begin

--the main process begins
subtracting: process(inputa , inputb) is
begin
	--Case 1 : When both the signs are equal. Then depending on the magnitude of the two inputs the sign of the result is decided
	--this sign is assigned to the modulus of difference of inputa and inputb
	if(inputa(15) = inputb(15)) then
		if(inputa(14 downto 0) > inputb(14 downto 0)) then
			tempResult(15) <= inputa(15);
			tempResult(14 downto 0) <= inputa(14 downto 0) - inputb(14 downto 0);
		else
			tempResult(15) <= NOT(inputa(15));
			tempResult(14 downto 0) <= inputb(14 downto 0) - inputa(14 downto 0);
		end if;
	--Case 2: When the signs of the two numbers are different. In this case the result is simple addition of the two numbers with
	--the result having the sign of the first number.
	else
		tempResult(15) <= inputa(15);
		tempResult(14 downto 0) <= inputa(14 downto 0) + inputb(14 downto 0);
	end if;
end process subtracting;

--the value of tempResult is assigned to result outside the process
result <= tempResult;

end Behavioral;

