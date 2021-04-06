LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY MBE_multiplier IS
	PORT(	A : IN std_logic_vector(31 downto 0);
			B : IN std_logic_vector(31 downto 0);
			PROD : OUT std_logic_vector(63 downto 0));
END MBE_multiplier;

ARCHITECTURE beh of MBE_multiplier IS

COMPONENT PPgenerator
GENERIC (N : integer := 32);
	PORT(	Multiplicand : IN std_logic_vector (N-1 DOWNTO 0);
      		Triplet : IN std_logic_vector (2 downto 0);
      		PP : OUT std_logic_vector (N DOWNTO 0);
			S : OUT	std_logic);
END COMPONENT;

COMPONENT DADDA_TREE
	PORT(	pp0 : IN std_logic_vector(63 downto 0);
			pp1 : IN std_logic_vector(63 downto 0);
			pp2 : IN std_logic_vector(63 downto 0);
			pp3 : IN std_logic_vector(63 downto 0);
			pp4 : IN std_logic_vector(63 downto 0);
			pp5 : IN std_logic_vector(63 downto 0);
			pp6 : IN std_logic_vector(63 downto 0);
			pp7 : IN std_logic_vector(63 downto 0);
			pp8 : IN std_logic_vector(63 downto 0);
			pp9 : IN std_logic_vector(63 downto 0);
			pp10 : IN std_logic_vector(63 downto 0);
			pp11 : IN std_logic_vector(63 downto 0);
			pp12 : IN std_logic_vector(63 downto 0);
			pp13 : IN std_logic_vector(63 downto 0);
			pp14 : IN std_logic_vector(63 downto 0);
			pp15 : IN std_logic_vector(63 downto 0);
			pp16 : IN std_logic_vector(63 downto 0);
			PROD : OUT std_logic_vector(63 downto 0));
END COMPONENT;	
	
signal multiplier : std_logic_vector(34 downto 0);
type partial_products_vec is array (0 to 16) of std_logic_vector(32 downto 0);
signal partial_products: partial_products_vec;
signal signs : std_logic_vector(0 to 16);
signal pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8 : std_logic_vector(63 downto 0) := (others => '0');
signal pp9,pp10,pp11,pp12,pp13,pp14,pp15,pp16 : std_logic_vector(63 downto 0) := (others => '0');

BEGIN

-- Extension of the multiplier to complete the triplets
multiplier <= "00" & B & '0';

-- Port map of the PP_generator module to generate all 17 partial products (17 blocks but no latency)
pp_generate: for i in 0 to 16 generate
	signal triplet : std_logic_vector(2 downto 0);
	begin
	triplet <= multiplier(i*2+2 downto i*2);
	pp: PPgenerator PORT MAP(A, triplet, partial_products(i), signs(i));
end generate pp_generate;

----------------------------------------------------------------------------------------------------------
-- Adapt the partial products to a pyramid configuration
----------------------------------------------------------------------------------------------------------

-- Partial product 0
pp0(63 downto 56) <= not(signs(15)) & '1' & not(signs(14)) & '1' & not(signs(13)) & '1' & not(signs(12)) & '1';
pp0(55 downto 48) <= not(signs(11)) & '1' & not(signs(10)) & '1' & not(signs(9)) & '1' & not(signs(8)) & '1';
pp0(47 downto 40) <= not(signs(7)) & '1' & not(signs(6)) & '1' & not(signs(5)) & '1' & not(signs(4)) & '1';
pp0(39 downto 33) <= not(signs(3)) & '1' & not(signs(2)) & '1' & not(signs(0)) & signs(0) & signs(0);
pp0(32 downto 0) <= partial_products(0);

-- Partial product 1
pp1(63) <= partial_products(16)(31);
pp1(62 downto 59) <= partial_products(15)(32) & partial_products(15)(31) & partial_products(14)(32) & partial_products(14)(31);
pp1(58 downto 55) <= partial_products(13)(32) & partial_products(13)(31) & partial_products(12)(32) & partial_products(12)(31);
pp1(54 downto 51) <= partial_products(11)(32) & partial_products(11)(31) & partial_products(10)(32) & partial_products(10)(31);
pp1(50 downto 47) <= partial_products(9)(32) & partial_products(9)(31) & partial_products(8)(32) & partial_products(8)(31);
pp1(46 downto 43) <= partial_products(7)(32) & partial_products(7)(31) & partial_products(6)(32) & partial_products(6)(31);
pp1(42 downto 39) <= partial_products(5)(32) & partial_products(5)(31) & partial_products(4)(32) & partial_products(4)(31);
pp1(38 downto 35) <= partial_products(3)(32) & partial_products(3)(31) & partial_products(2)(32) & not signs(1);
pp1(34 downto 2) <= partial_products(1);
pp1(0) <= signs(0);

-- Partial product 2
pp2(62 downto 59) <= partial_products(16)(30) & partial_products(16)(29) & partial_products(15)(30) & partial_products(15)(29);
pp2(58 downto 55) <= partial_products(14)(30) & partial_products(14)(29) & partial_products(13)(30) & partial_products(13)(29);
pp2(54 downto 51) <= partial_products(12)(30) & partial_products(12)(29) & partial_products(11)(30) & partial_products(11)(29);
pp2(50 downto 47) <= partial_products(10)(30) & partial_products(10)(29) & partial_products(9)(30) & partial_products(9)(29);
pp2(46 downto 43) <= partial_products(8)(30) & partial_products(8)(29) & partial_products(7)(30) & partial_products(7)(29);
pp2(42 downto 39) <= partial_products(6)(30) & partial_products(6)(29) & partial_products(5)(30) & partial_products(5)(29);
pp2(38 downto 36) <= partial_products(4)(30) & partial_products(4)(29) & partial_products(3)(30);
pp2(35 downto 4) <= partial_products(2)(31 downto 0);
pp2(2) <= signs(1);

-- Partial product 3
pp3(60 downto 57) <= partial_products(16)(28) & partial_products(16)(27) & partial_products(15)(28) & partial_products(15)(27);
pp3(56 downto 53) <= partial_products(14)(28) & partial_products(14)(27) & partial_products(13)(28) & partial_products(13)(27);
pp3(52 downto 49) <= partial_products(12)(28) & partial_products(12)(27) & partial_products(11)(28) & partial_products(11)(27);
pp3(48 downto 45) <= partial_products(10)(28) & partial_products(10)(27) & partial_products(9)(28) & partial_products(9)(27);
pp3(44 downto 41) <= partial_products(8)(28) & partial_products(8)(27) & partial_products(7)(28) & partial_products(7)(27);
pp3(40 downto 37) <= partial_products(6)(28) & partial_products(6)(27) & partial_products(5)(28) & partial_products(5)(27);
pp3(36) <= partial_products(4)(28);
pp3(35 downto 6) <= partial_products(3)(29 downto 0);
pp3(4) <= signs(2);

-- Partial product 4
pp4(58 downto 55) <= partial_products(16)(26) & partial_products(16)(25) & partial_products(15)(26) & partial_products(15)(25);
pp4(54 downto 51) <= partial_products(14)(26) & partial_products(14)(25) & partial_products(13)(26) & partial_products(13)(25);
pp4(50 downto 47) <= partial_products(12)(26) & partial_products(12)(25) & partial_products(11)(26) & partial_products(11)(25);
pp4(46 downto 43) <= partial_products(10)(26) & partial_products(10)(25) & partial_products(9)(26) & partial_products(9)(25);
pp4(42 downto 39) <= partial_products(8)(26) & partial_products(8)(25) & partial_products(7)(26) & partial_products(7)(25);
pp4(38 downto 36) <= partial_products(6)(26) & partial_products(6)(25) & partial_products(5)(26);
pp4(35 downto 8) <= partial_products(4)(27 downto 0);
pp4(6) <= signs(3);

-- Partial product 5
pp5(56 downto 53) <= partial_products(16)(24) & partial_products(16)(23) & partial_products(15)(24) & partial_products(15)(23);
pp5(52 downto 49) <= partial_products(14)(24) & partial_products(14)(23) & partial_products(13)(24) & partial_products(13)(23);
pp5(48 downto 45) <= partial_products(12)(24) & partial_products(12)(23) & partial_products(11)(24) & partial_products(11)(23);
pp5(44 downto 41) <= partial_products(10)(24) & partial_products(10)(23) & partial_products(9)(24) & partial_products(9)(23);
pp5(40 downto 37) <= partial_products(8)(24) & partial_products(8)(23) & partial_products(7)(24) & partial_products(7)(23);
pp5(36) <= partial_products(6)(24);
pp5(35 downto 10) <= partial_products(5)(25 downto 0);
pp5(8) <= signs(4);

-- Partial product 6
pp6(54 downto 51) <= partial_products(16)(22) & partial_products(16)(21) & partial_products(15)(22) & partial_products(15)(21);
pp6(50 downto 47) <= partial_products(14)(22) & partial_products(14)(21) & partial_products(13)(22) & partial_products(13)(21);
pp6(46 downto 43) <= partial_products(12)(22) & partial_products(12)(21) & partial_products(11)(22) & partial_products(11)(21);
pp6(42 downto 39) <= partial_products(10)(22) & partial_products(10)(21) & partial_products(9)(22) & partial_products(9)(21);
pp6(38 downto 36) <= partial_products(8)(22) & partial_products(8)(21) & partial_products(7)(22);
pp6(35 downto 12) <= partial_products(6)(23 downto 0);
pp6(10) <= signs(5);

-- Partial product 7
pp7(52 downto 49) <= partial_products(16)(20) & partial_products(16)(19) & partial_products(15)(20) & partial_products(15)(19);
pp7(48 downto 45) <= partial_products(14)(20) & partial_products(14)(19) & partial_products(13)(20) & partial_products(13)(19);
pp7(44 downto 41) <= partial_products(12)(20) & partial_products(12)(19) & partial_products(11)(20) & partial_products(11)(19);
pp7(40 downto 37) <= partial_products(10)(20) & partial_products(10)(19) & partial_products(9)(20) & partial_products(9)(19);
pp7(36) <= partial_products(8)(20);
pp7(35 downto 14) <= partial_products(7)(21 downto 0);
pp7(12) <= signs(6);

-- Partial product 8
pp8(50 downto 47) <= partial_products(16)(18) & partial_products(16)(17) & partial_products(15)(18) & partial_products(15)(17);
pp8(46 downto 43) <= partial_products(14)(18) & partial_products(14)(17) & partial_products(13)(18) & partial_products(13)(17);
pp8(42 downto 39) <= partial_products(12)(18) & partial_products(12)(17) & partial_products(11)(18) & partial_products(11)(17);
pp8(38 downto 36) <= partial_products(10)(18) & partial_products(10)(17) & partial_products(9)(18);
pp8(35 downto 16) <= partial_products(8)(19 downto 0);
pp8(14) <= signs(7);

-- Partial product 9
pp9(48 downto 45) <= partial_products(16)(16) & partial_products(16)(15) & partial_products(15)(16) & partial_products(15)(15);
pp9(44 downto 41) <= partial_products(14)(16) & partial_products(14)(15) & partial_products(13)(16) & partial_products(13)(15);
pp9(40 downto 37) <= partial_products(12)(16) & partial_products(12)(15) & partial_products(11)(16) & partial_products(11)(15);
pp9(36) <= partial_products(10)(16);
pp9(35 downto 18) <= partial_products(9)(17 downto 0);
pp9(16) <= signs(8);

-- Partial product 10
pp10(46 downto 43) <= partial_products(16)(14) & partial_products(16)(13) & partial_products(15)(14) & partial_products(15)(13);
pp10(42 downto 39) <= partial_products(14)(14) & partial_products(14)(13) & partial_products(13)(14) & partial_products(13)(13);
pp10(38 downto 36) <= partial_products(12)(14) & partial_products(12)(13) & partial_products(11)(14);
pp10(35 downto 20) <= partial_products(10)(15 downto 0);
pp10 (18) <= signs(9);

-- Partial product 11
pp11(44 downto 41) <= partial_products(16)(12) & partial_products(16)(11) & partial_products(15)(12) & partial_products(15)(11);
pp11(40 downto 37) <= partial_products(14)(12) & partial_products(14)(11) & partial_products(13)(12) & partial_products(13)(11);
pp11(36) <= partial_products(12)(12);
pp11(35 downto 22) <= partial_products(11)(13 downto 0);
pp11(20) <= signs(10);

-- Partial product 12
pp12(42 downto 39) <= partial_products(16)(10) & partial_products(16)(9) & partial_products(15)(10) & partial_products(15)(9);
pp12(38 downto 36) <= partial_products(14)(10) & partial_products(14)(9) & partial_products(13)(10);
pp12(35 downto 24) <= partial_products(12)(11 downto 0);
pp12(22) <= signs(11);

-- Partial product 13
pp13(40 downto 37) <= partial_products(16)(8) & partial_products(16)(7) & partial_products(15)(8) & partial_products(15)(7);
pp13(36) <= partial_products(14)(8);
pp13(35 downto 26) <= partial_products(13)(9 downto 0);
pp13(24) <= signs(12);

-- Partial product 14
pp14(38 downto 36) <= partial_products(16)(6) & partial_products(16)(5) & partial_products(15)(6);
pp14(35 downto 28) <= partial_products(14)(7 downto 0);
pp14(26) <= signs(13);

-- Partial product 15
pp15(36) <= partial_products(16)(4);
pp15(35 downto 30) <= partial_products(15)(5 downto 0);
pp15(28) <= signs(14);

-- Partial product 16
pp16(35 downto 32) <= partial_products(16)(3 downto 0);
pp16(30) <= signs(15);


----------------------------------------------------------------------------------------------------------
-- Dadda tree: Single component, internally characterized by 7 layers (6 PP + final RCA)
----------------------------------------------------------------------------------------------------------

dadda: DADDA_TREE PORT MAP(pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,pp9,pp10,pp11,pp12,pp13,pp14,pp15,pp16,PROD);

END beh;

