LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY tb_mbe IS
END ENTITY;

ARCHITECTURE beh of tb_mbe IS

COMPONENT MBE_multiplier
	PORT(	A : IN std_logic_vector(31 downto 0);
			B : IN std_logic_vector(31 downto 0);
			PROD : OUT std_logic_vector(63 downto 0));
END COMPONENT;

signal a, b : std_logic_vector(31 downto 0);
signal p : std_logic_vector(63 downto 0);

BEGIN

data: process
begin
a <= "00000000000000000000000000000001";
b <= "00000000000000000000000001000000";
wait for 100 ns;
a <= "00000000000000000000000000000011";
b <= "00000000000000000000000110010000";
wait for 100 ns;
a <= "00000000000000000000000100000101";
b <= "00000000000000000000000101111010";
wait for 100 ns;
a <= "00000111011010111101110101011101";
b <= "00010001001000000011111010101110";
wait for 100 ns;
a <= "00110010100010101111010101110001";
b <= "00000011010111111000000100000000";
wait for 100 ns;
end process;

comp: MBE_multiplier PORT MAP(a,b,p);

END beh;
