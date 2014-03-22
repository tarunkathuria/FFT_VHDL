----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:55:12 04/11/2013 
-- Design Name: 
-- Module Name:    subtractor32bit - Behavioral 
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


--Number representation (32 total bits) : 16 bits for real part and 16 bits for imaginary part.
--Now in the 16 bit: 1 sign bit, 7 bits to represent the integral part,  and 8 to represent the fractional part
--32bit subtractor : the implementation simply uses two 16 bit subtractor to perform the real and imaginary computations
--seperately the assigns the respective results to appropriate bits of 'result'

entity subtractor32bit is
    Port ( inputa : in  STD_LOGIC_VECTOR (31 downto 0);
           inputb : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end subtractor32bit;

architecture Behavioral of subtractor32bit is

--16 bit subtractor component
component subtractor16bit
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

begin

--component initialising responsible for subtraction of the real part of the two numbers
realSubtraction: subtractor16bit port map(inputa(15 downto 0) , inputb(15 downto 0) , result(15 downto 0));

--component initialising responsible for subtraction of the imaginary part of the two numbers
imaginarySubtraction : subtractor16bit port map(inputa(31 downto 16) , inputb(31 downto 16) , result(31 downto 16));

end Behavioral;

