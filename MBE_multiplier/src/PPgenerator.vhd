LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY PPgenerator IS
GENERIC (N : integer := 32);
	PORT(	Multiplicand : IN std_logic_vector (N-1 DOWNTO 0);
      		Triplet : IN std_logic_vector (2 DOWNTO 0);
      		PP : OUT std_logic_vector (N DOWNTO 0);
			S : OUT	std_logic);
END PPgenerator;

ARCHITECTURE beh of PPgenerator IS

BEGIN

cases : process(Multiplicand, Triplet)
variable pp_temp : std_logic_vector(N downto 0) := (others => '0');
variable sign : std_logic := '0';

begin
	case Triplet is
		when "000" => 	pp_temp := (others => '0');
						sign := '0';
		when "001" => 	pp_temp(N-1 downto 0) := Multiplicand;		-- + Multiplicand
						pp_temp(N) := '0';
						sign := '0';
		when "010" => 	pp_temp(N-1 downto 0) := Multiplicand;		-- + Multiplicand
						pp_temp(N) := '0';
						sign := '0';
		when "011" => 	pp_temp(N downto 1) := Multiplicand;		-- + 2 * Multiplicand
						pp_temp(0) := '0';
						sign := '0';
		when "100" => 	pp_temp(N downto 1) := Multiplicand;		-- - 2 * Multiplicand
						pp_temp(0) := '0';
						pp_temp := not(pp_temp);
						sign := '1';
		when "101" => 	pp_temp(N-1 downto 0) := Multiplicand;		-- - Multiplicand
						pp_temp(N) := '0';
						pp_temp := not(pp_temp);
						sign := '1';
		when "110" => 	pp_temp(N-1 downto 0) := Multiplicand;		-- - Multiplicand
						pp_temp(N) := '0';
						pp_temp := not(pp_temp);
						sign := '1';
		when "111" => 	pp_temp := (others => '1');
						sign := '1';
		when others => 	pp_temp := (others => '0');
	end case;
	
	PP <= pp_temp;
	S <= sign;
	
end process cases;

END beh;