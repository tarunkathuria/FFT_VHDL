----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:08 04/11/2013 
-- Design Name: 
-- Module Name:    adder32bit - Behavioral 
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
--32 bit adder: Simply uses two 16 bit adder for imaginary and real addition

entity adder32bit is
    Port ( inputa : in  STD_LOGIC_VECTOR (31 downto 0);
           inputb : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end adder32bit;

architecture Behavioral of adder32bit is

--The component of the 16 bit adder which is to be used in the following implementation
component adder16bit
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

--temperory signal to hold the values of result during the port mapping
signal tempResult : STD_LOGIC_VECTOR (31 downto 0) := (others=>'0');

begin

--Adding the imaginary part using 16 bit adder
ImaginaryAddition: adder16bit port map(inputa(15 downto 0) , inputb(15 downto 0) , tempResult(15 downto 0));

--Adding the real part using 16 bit adder
RealAddition: adder16bit port map(inputa (31 downto 16) , inputb(31 downto 16) , tempResult(31 downto 16));

--Finally the temperory variable's value is restored in result
result <= tempResult;

end Behavioral;

