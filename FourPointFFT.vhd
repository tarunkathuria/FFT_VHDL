----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:53:53 04/11/2013 
-- Design Name: 
-- Module Name:    FourPointFFT - Behavioral 
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

entity FourPointFFT is
    Port ( input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           input3 : in  STD_LOGIC_VECTOR (31 downto 0);
           output0 : out  STD_LOGIC_VECTOR (31 downto 0);
           output1 : out  STD_LOGIC_VECTOR (31 downto 0);
           output2 : out  STD_LOGIC_VECTOR (31 downto 0);
           output3 : out  STD_LOGIC_VECTOR (31 downto 0));
end FourPointFFT;

architecture Behavioral of FourPointFFT is
component Butterfly
	Port ( input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           output0 : out  STD_LOGIC_VECTOR (31 downto 0);
           output1 : out  STD_LOGIC_VECTOR (31 downto 0);
			  wk : in STD_LOGIC_VECTOR(31 downto 0));
	end component;
component adder32bit
	Port ( inputa : in STD_LOGIC_VECTOR (31 downto 0);
			 inputb : in STD_LOGIC_VECTOR (31 downto 0);
			 result : out STD_LOGIC_VECTOR (31 downto 0)
			 );
end component;

component subtractor32bit
	Port ( inputa : in STD_LOGIC_VECTOR (31 downto 0);
			 inputb : in STD_LOGIC_VECTOR (31 downto 0);
			 result : out STD_LOGIC_VECTOR (31 downto 0)
			 );
end component;

component multiplier32bit
	Port ( inputa : in STD_LOGIC_VECTOR (31 downto 0);
			 inputb : in STD_LOGIC_VECTOR (31 downto 0);
			 result : out STD_LOGIC_VECTOR (31 downto 0)
			 );
end component;
	signal e0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal e1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal o0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal o1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
	signal w0 : STD_LOGIC_VECTOR(31 downto 0) := "00000001000000000000000000000000";
	signal w2 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000001000000100000000";
begin
Butterfly1 : Butterfly port map(input0,input2,e0,e1);
Butterfly2 : Butterfly port map(input1,input3,o0,o1);


end Behavioral;

