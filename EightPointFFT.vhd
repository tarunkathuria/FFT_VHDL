library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- This is the actual 8 point FFT entity which takes in the 8 inputs(input0 to input7)
-- and calculates the FFT of these inputs and outputs them on output0 to output7.
-- This is just the declaration of the entity and it's inputs and outputs.
entity EightPointFFT is
    Port ( input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           input3 : in  STD_LOGIC_VECTOR (31 downto 0);
           input4 : in  STD_LOGIC_VECTOR (31 downto 0);
           input5 : in  STD_LOGIC_VECTOR (31 downto 0);
           input6 : in  STD_LOGIC_VECTOR (31 downto 0);
           input7 : in  STD_LOGIC_VECTOR (31 downto 0);
           output0 : out  STD_LOGIC_VECTOR (31 downto 0);
           output1 : out  STD_LOGIC_VECTOR (31 downto 0);
           output2 : out  STD_LOGIC_VECTOR (31 downto 0);
           output3 : out  STD_LOGIC_VECTOR (31 downto 0);
           output4 : out  STD_LOGIC_VECTOR (31 downto 0);
           output5 : out  STD_LOGIC_VECTOR (31 downto 0);
           output6 : out  STD_LOGIC_VECTOR (31 downto 0);
           output7 : out  STD_LOGIC_VECTOR (31 downto 0));
end EightPointFFT;

-- This is the behavioral description of the 8 point FFT entity
-- We store the 4 Twiddle factors in 4 constants w0 to w4.
-- The FFT relies primarily on the Butterfly component and the FFT can be calculated in 12 instantiations of the Butterfly component
architecture Behavioral of EightPointFFT is
-- First the Butterfly component is declared
component Butterfly
	Port ( input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           input1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  wk : in STD_LOGIC_VECTOR(31 downto 0);
           output0 : out  STD_LOGIC_VECTOR (31 downto 0);
           output1 : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
	end component;
-- The Twiddle constants are stored in w0 to w3
constant w0 : STD_LOGIC_VECTOR(31 downto 0) := "00000001000000000000000000000000"; --corresponds to W(8,0)=1+0i
constant w1 : STD_LOGIC_VECTOR(31 downto 0) := "00000000101101011000000010110101"; --corresponds to W(8,1)=(1-i)/root(2)
constant w2 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000001000000100000000"; --corresponds to W(8,2)=-i
constant w3 : STD_LOGIC_VECTOR(31 downto 0) := "10000000101101011000000010110101"; --corresponds to W(8,3)=-(1+i)/root(2)
-- The FFT can be divided into essentially 3 blocks of 4 concurrent butterfl operations.
-- Therefore, after each of the first 2 butterfly operation blocks, the value is stored in temporary signals.
-- These signals are then passed on as input to the next block of butterfly operations.

-- The first stage signals(denoting Stage 0), the outputs of the first block of butterfly operations will be stored in temp00 to temp07
-- Their initial values are set to 0+0i but they will be chnged after the first block of butterfly operations are carried out.
signal temp00 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp01 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp02 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp03 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp04 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp05 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp06 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp07 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";

-- The second stage signals(denoting Stage 1), the outputs of the 2nd butterfly oeprations will be stored in temp10 to temp17
signal temp10 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp11 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp12 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp13 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp14 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp15 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp16 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal temp17 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
-- The signals to store the outputs of the final butterfly operations block.
-- The value of these output pins(output0 to output7) will then be the value in these signals respectively. 
signal out0,out1,out2,out3,out4,out5,out6,out7 : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";


begin
-- These are the 3 butterfly blocks

--First Stage

-- Takes x[0] and x[4] and performs the butterfly operation with Twiddle factor W(8,0) and stores it in temp00 and temp01 respectively.
butterfly11 : Butterfly port map(input0, input4,w0,temp00,temp01); 
-- Takes x[1] and x[4] and performs the butterfly operation with Twiddle factor W(8,1) and stores it in temp04 and temp05 respectively.
butterfly12 : Butterfly port map(input1, input5,w1,temp04,temp05);
-- Takes x[2] and x[6] and performs the butterfly operation with Twiddle factor W(8,2) and stores it in temp02 and temp03 respectively.
butterfly13 : Butterfly port map(input2, input6,w2,temp02,temp03);
-- Takes x[3] and x[7] and performs the butterfly operation with Twiddle factor W(8,3) and stores it in temp06 and temp07 respectively.
butterfly14 : Butterfly port map(input3, input7,w3,temp06,temp07);

-- After the first stage of butterfly operations is completed, the temp0_ signals act as input to the next block of Butterfly operations.
-- Since this correspond to the 4 point FFT, the Twiddle Factors W(8,0) and W(8,2) are used only.
--Second Stage

-- Takes temp00 and temp02 and performs the butterfly operation with Twiddle factor W(8,0) and stores it in temp10 and temp12 respectively.
butterfly21 : butterfly port map(temp00,temp02,w0,temp10,temp12);
-- Takes temp01 and temp03 and performs the butterfly operation with Twiddle factor W(8,0) and stores it in temp11 and temp13 respectively.
butterfly22 : butterfly port map(temp01,temp03,w0,temp11,temp13);
-- Takes temp04 and temp06 and performs the butterfly operation with Twiddle factor W(8,2) and stores it in temp14 and temp16 respectively.
butterfly23 : butterfly port map(temp04,temp06,w2,temp14,temp16);
-- Takes temp05 and temp07 and performs the butterfly operation with Twiddle factor W(8,2) and stores it in temp15 and temp17 respectively.
butterfly24 : butterfly port map(temp05,temp07,w2,temp15,temp17);

-- After the second stage of butterfly operations is completed, the temp1_ signals act as input to the third and final block of butterfly operations.
-- Since this corresponds to the 2 point FFT, the Twiddle Factro W(8,0) is used only.

--Third stage

-- Takes temp10 and temp14 and performs the butterfly operation with Twiddle factor W(8,0) and stores it in out0 aand out4 respectively.
butterfly31 : butterfly port map(temp10,temp14,w0,out0,out4);
-- Takes temp11 and temp15 and performs the butterfly operation with Twiddle factor W(8,0) and stores it in out1 aand out5 respectively.
butterfly32 : butterfly port map(temp11,temp15,w0,out1,out5);
-- Takes temp12 and temp16 and performs the butterfly operation with Twiddle factor W(8,0) and stores it in out2 aand out6 respectively.
butterfly33 : butterfly port map(temp12,temp16,w0,out2,out6);
-- Takes temp13 and temp17 and performs the butterfly operation with Twiddle factor W(8,0) and stores it in out3 aand out7 respectively.
butterfly34 : butterfly port map(temp13,temp17,w0,out3,out7);

-- Finally after all the 4 blocks of butterfly operations are completed, the value of the out_ signals are given to their corresponding output pins.
output0 <=out0;
output1 <=out1;
output2 <=out2;
output3 <=out3;
output4 <=out4;
output5 <=out5;
output6 <=out6;
output7 <=out7;

end Behavioral;

