library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- This is the butterfly entity
-- Takes in 3 inputs(input0 and input1 and the Twiddle factor wk that will be used)
-- Returns the two outputs(output0 and output1) corresponding to a single butterfly operation.
entity Butterfly is
    Port ( input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           input1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  wk : in STD_LOGIC_VECTOR(31 downto 0);
           output0 : out  STD_LOGIC_VECTOR (31 downto 0);
           output1 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
end Butterfly;
-- The butterfly needs an adder, a subtractor and a multiplier
-- Therefore, entities of each for our specific representation of complex numbers have been created and their components are used here.
architecture Behavioral of Butterfly is
-- This is the adder circuit which takes in 2 complex numbers represented in our representation using 32 bits each
-- Returns the result of the addition using our representation
component adder32bit
	Port ( inputa : in STD_LOGIC_VECTOR (31 downto 0);
			 inputb : in STD_LOGIC_VECTOR (31 downto 0);
			 result : out STD_LOGIC_VECTOR(31 downto 0)
			 );
end component;
-- This is the subtractor circuit which takes in 2 complex numbers represented in our representation using 32 bits each
-- Returns the result of the subtraction using our representation
component subtractor32bit
	Port ( inputa : in STD_LOGIC_VECTOR (31 downto 0);
			 inputb : in STD_LOGIC_VECTOR (31 downto 0);
			 result : out STD_LOGIC_VECTOR(31 downto 0)
			 );
end component;
-- This is the multiplier circuit which takes in 2 complex numbers represented in our representation using 32 bits each
-- Returns the result of the multiplication using our representation
component multiplier32bit
	Port ( inputa : in STD_LOGIC_VECTOR (31 downto 0);
			 inputb : in STD_LOGIC_VECTOR (31 downto 0);
			 result : out STD_LOGIC_VECTOR(31 downto 0)
			 );
end component;
-- This is a temporary signal which is used for output1
-- subtemp stores the value obtained by the subtraction of the 2 inputs
-- It is then taken ass input along with the Twiddle factor wk as input to the multiplier32 bit component
signal subtemp : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin
--There are only 3 operations corresponding to a butterfly- addition, subtraction and multiplication

-- The addition of the two inputs directly corresponds to the first output(output0)
adder : adder32bit port map(input0, input1, output0);
-- The result of the subtraction of the 2 inputs is stored in signal subtemp
subtractor : subtractor32bit port map(input0,input1,subtemp);
-- This signal(subtemp) is then passed as input along with wk to the multiplier to get the 2nd output(output1)
multiplier : multiplier32bit port map(subtemp,wk,output1);

end Behavioral;

