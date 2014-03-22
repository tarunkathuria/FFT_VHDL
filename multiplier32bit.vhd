----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:20 04/11/2013 
-- Design Name: 
-- Module Name:    multiplier32bit - Behavioral 
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
--32 bit multiplier : It simply uses four 16 bit multiplier, and one each of 16 bit adder and subtractor to obtain
-- the real and imaginary parts of the complex product
-- Let a + bi and A + Bi be the two numbers. Then real part is obtained by aA - bB and the imaginary part is aB + bA

entity multiplier32bit is
    Port ( inputa : in  STD_LOGIC_VECTOR (31 downto 0);
           inputb : in  STD_LOGIC_VECTOR (31 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end multiplier32bit;

architecture Behavioral of multiplier32bit is

--variable to hold the value of aA
signal tempaA: STD_LOGIC_VECTOR (15 downto 0) :=(others=>'0');

--variable to hold the value of bB
signal tempbB: STD_LOGIC_VECTOR (15 downto 0) :=(others=>'0');

--variable to hold the value of bA
signal tempbA: STD_LOGIC_VECTOR (15 downto 0) :=(others=>'0');

--variable to hold the value of aB
signal tempaB: STD_LOGIC_VECTOR (15 downto 0) :=(others=>'0');

--multiplier component
component multiplier16bit
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

--adder component
component adder16bit
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

--subtractor component
component subtractor16bit
    Port ( inputa : in  STD_LOGIC_VECTOR (15 downto 0);
           inputb : in  STD_LOGIC_VECTOR (15 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

begin

--component initialising under the name aA to calculate the product a*A
aA : multiplier16bit port map(inputa(31 downto 16) , inputb(31 downto 16) , tempaA);

--component initialising under the name aA to calculate the product b*B
bB : multiplier16bit port map(inputa(15 downto 0) , inputb(15 downto 0) , tempbB);

--component initialising under the name aA to calculate the product a*B
aB:  multiplier16bit port map(inputa(31 downto 16) , inputb(15 downto 0) , tempaB);

--component initialising under the name aA to calculate the product b*A
bA : multiplier16bit port map(inputa(15 downto 0) , inputb(31 downto 16) , tempbA);

--component initialising under the name aA to calculate the product a*A - b*B
aAbB : subtractor16bit port map(tempaA , tempbB , result(31 downto 16));

--component initialising under the name aA to calculate the product a*B - b*A
aBbA : adder16bit port map(tempaB , tempbA , result(15 downto 0));

end Behavioral;

