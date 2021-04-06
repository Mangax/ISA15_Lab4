LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY FA IS
	PORT(	A : IN std_logic;
			B : IN std_logic;
			Ci : IN std_logic;
			S : OUT std_logic;
			Co : OUT std_logic);
END FA;

ARCHITECTURE beh OF FA IS
BEGIN

S <= A XOR B XOR Ci;
Co <= (A AND B) OR (Ci AND A) OR (Ci AND B);

END beh;