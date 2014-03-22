----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:44 04/11/1413 
-- Design Name: 
-- Module Name:    multiplier16bit - Behavioral 
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
--16 bit multiplier : the two numbers are simply multiplied keeping in mind the sign of the variables
--Then 32 bit result obtained is then chopped off so that the result can be expressed in the standard 16 bit format
--Since one of the two numbers will always have a modulus of 1 therefore expressing the 32 bit number in 16 bit
--will surely lead to loss of precision but the value will still be acurate

entity multiplier16bit is
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end multiplier16bit;

architecture Behavioral of multiplier16bit is

--temperory 32 bit variable to hold the value of the 32 bit product
signal temp : STD_LOGIC_VECTOR (31 downto 0) :=(others=>'0');

begin

--beginning of the main process of multiplication
multiplication : process(inputa , inputb) is
begin
	--case 1 when both the inputs have the same sign. the sign bit is set to '0' ( positive ) and the rest of the bits are
	--obtained from the multiplicaiton using inbuilt operator *
	if(inputa(15) = inputb(15)) then
		temp(29 downto 0) <= inputa(14 downto 0) * inputb(14 downto 0);
		temp(29) <= '0';
	else
	--case 1 when both the inputs have the different signs. the sign bit is set to '1' ( positive ) and the rest of the bits are
	--obtained from the multiplicaiton using inbuilt operator *
		temp(29 downto 0) <= inputa(14 downto 0) * inputb(14 downto 0);
		temp(29) <= '1';
	end if;
end process multiplication;

--Finally result is given the appropriate value from the temperory variable temp
result(7 downto 0) <= temp(15 downto 8);
result(14 downto 8) <= temp(22 downto 16);
result(15) <= temp(29);
end Behavioral;

