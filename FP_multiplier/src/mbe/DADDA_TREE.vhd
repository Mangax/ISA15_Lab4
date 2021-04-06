LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY DADDA_TREE IS
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
END DADDA_TREE;

ARCHITECTURE beh of DADDA_TREE IS

COMPONENT FA 
	PORT(	A : IN std_logic;
			B : IN std_logic;
			Ci : IN std_logic;
			S : OUT std_logic;
			Co : OUT std_logic);
END COMPONENT;

COMPONENT HA 
	PORT(	A : IN std_logic;
			B : IN std_logic;
			S : OUT std_logic;
			Co : OUT std_logic);
END COMPONENT;

signal l5pp0,l5pp1,l5pp2,l5pp3,l5pp4,l5pp5,l5pp6,l5pp7,l5pp8,l5pp9,l5pp10,l5pp11,l5pp12 : std_logic_vector(63 downto 0);
signal l4pp0,l4pp1,l4pp2,l4pp3,l4pp4,l4pp5,l4pp6,l4pp7,l4pp8 : std_logic_vector(63 downto 0);
signal l3pp0,l3pp1,l3pp2,l3pp3,l3pp4,l3pp5 : std_logic_vector(63 downto 0);
signal l2pp0,l2pp1,l2pp2,l2pp3 : std_logic_vector(63 downto 0);
signal l1pp0,l1pp1,l1pp2 : std_logic_vector(63 downto 0);
signal l0pp0,l0pp1 : std_logic_vector(64 downto 0);
signal prod64  : std_logic_vector(64 downto 0);

BEGIN

----------------------------------------------------------------------------------------------------------------
-- From LEVEL 6 to LEVEL 5 (to 13 pp): 40 FA & 12 HA
----------------------------------------------------------------------------------------------------------------

-- 40 FA

l6_fa_26_41: for i in 26 to 41 generate
	l6_fa_first_row : FA PORT MAP(pp0(i), pp1(i), pp2(i), l5pp0(i), l5pp1(i+1));
end generate l6_fa_26_41;

l6_fa_28_39: for i in 28 to 39 generate
	l6_fa_second_row : FA PORT MAP(pp3(i), pp4(i), pp5(i), l5pp2(i), l5pp3(i+1));
end generate l6_fa_28_39;

l6_fa_30_37: for i in 30 to 37 generate
	l6_fa_third_row: FA PORT MAP(pp6(i), pp7(i), pp8(i), l5pp4(i), l5pp5(i+1));
end generate l6_fa_30_37;

l6_fa_32_35: for i in 32 to 35 generate
	l6_fa_fourth_row: FA PORT MAP(pp9(i), pp10(i), pp11(i), l5pp6(i), l5pp7(i+1));
end generate l6_fa_32_35;

-- 12 HA

l6_ha_24: HA PORT MAP(pp0(24), pp1(24), l5pp0(24), l5pp1(25));
l6_ha_25: HA PORT MAP(pp0(25), pp1(25), l5pp0(25), l5pp1(26));

l6_ha_26: HA PORT MAP(pp3(26), pp4(26), l5pp2(26), l5pp3(27));
l6_ha_27: HA PORT MAP(pp3(27), pp4(27), l5pp2(27), l5pp3(28));

l6_ha_28: HA PORT MAP(pp6(28), pp7(28), l5pp4(28), l5pp5(29));
l6_ha_29: HA PORT MAP(pp6(29), pp7(29), l5pp4(29), l5pp5(30));

l6_ha_30: HA PORT MAP(pp9(30), pp10(30), l5pp6(30), l5pp7(31));
l6_ha_31: HA PORT MAP(pp9(31), pp10(31), l5pp6(31), l5pp7(32));

l6_ha_36: HA PORT MAP(pp9(36), pp10(36), l5pp6(36), l5pp6(37));

l6_ha_38: HA PORT MAP(pp6(38), pp7(38), l5pp4(38), l5pp4(39));

l6_ha_40: HA PORT MAP(pp3(40), pp4(40), l5pp2(40), l5pp2(41));

l6_ha_42: HA PORT MAP(pp0(42), pp1(42), l5pp0(42), l5pp0(43));

-- Not used dots

l5pp0(23 downto 0) <= pp0(23 downto 0);
l5pp1(43) <= pp0(43);
l5pp0(63 downto 44) <= pp0(63 downto 44);

l5pp1(23 downto 0) <= pp1(23 downto 0);
l5pp2(43) <= pp1(43);
l5pp1(63 downto 44) <= pp1(63 downto 44);

l5pp2(23 downto 0) <= pp2(23 downto 0);
l5pp1(24) <= pp2(24);
l5pp2(25) <= pp2(25);
l5pp2(42) <= pp2(42);
l5pp3(43) <= pp2(43);
l5pp2(63 downto 44) <= pp2(63 downto 44);

l5pp3(23 downto 0) <= pp3(23 downto 0);
l5pp2(24) <= pp3(24);
l5pp3(25) <= pp3(25);
l5pp3(42 downto 41) <= pp3(42 downto 41);
l5pp4(43) <= pp3(43);
l5pp3(63 downto 44) <= pp3(63 downto 44);

l5pp4(23 downto 0) <= pp4(23 downto 0);
l5pp3(24) <= pp4(24);
l5pp4(25) <= pp4(25);
l5pp4(42 downto 41) <= pp4(42 downto 41);
l5pp5(43) <= pp4(43);
l5pp4(63 downto 44) <= pp4(63 downto 44);

l5pp5(23 downto 0) <= pp5(23 downto 0);
l5pp4(24) <= pp5(24);
l5pp5(25) <= pp5(25);
l5pp3(26) <= pp5(26);
l5pp4(27) <= pp5(27);
l5pp4(40) <= pp5(40);
l5pp5(42 downto 41) <= pp5(42 downto 41);
l5pp6(43) <= pp5(43);
l5pp5(63 downto 44) <= pp5(63 downto 44);

l5pp6(23 downto 0) <= pp6(23 downto 0);
l5pp5(24) <= pp6(24);
l5pp6(25) <= pp6(25);
l5pp4(26) <= pp6(26);
l5pp5(27) <= pp6(27);
l5pp5(40 downto 39) <= pp6(40 downto 39);
l5pp6(42 downto 41) <= pp6(42 downto 41);
l5pp7(43) <= pp6(43);
l5pp6(63 downto 44) <= pp6(63 downto 44);

l5pp7(23 downto 0) <= pp7(23 downto 0);
l5pp6(24) <= pp7(24);
l5pp7(25) <= pp7(25);
l5pp5(26) <= pp7(26);
l5pp6(27) <= pp7(27);
l5pp6(40 downto 39) <= pp7(40 downto 39);
l5pp7(42 downto 41) <= pp7(42 downto 41);
l5pp8(43) <= pp7(43);
l5pp7(63 downto 44) <= pp7(63 downto 44);

l5pp8(23 downto 0) <= pp8(23 downto 0);
l5pp7(24) <= pp8(24);
l5pp8(25) <= pp8(25);
l5pp6(26) <= pp8(26);
l5pp7(27) <= pp8(27);
l5pp5(28) <= pp8(28);
l5pp6(29) <= pp8(29);
l5pp6(38) <= pp8(38);
l5pp7(40 downto 39) <= pp8(40 downto 39);
l5pp8(42 downto 41) <= pp8(42 downto 41);
l5pp9(43) <= pp8(43);
l5pp8(63 downto 44) <= pp8(63 downto 44);

l5pp9(23 downto 0) <= pp9(23 downto 0);
l5pp8(24) <= pp9(24);
l5pp9(25) <= pp9(25);
l5pp7(26) <= pp9(26);
l5pp8(27) <= pp9(27);
l5pp6(28) <= pp9(28);
l5pp7(29) <= pp9(29);
l5pp7(38 downto 37) <= pp9(38 downto 37);
l5pp8(40 downto 39) <= pp9(40 downto 39);
l5pp9(42 downto 41) <= pp9(42 downto 41);
l5pp10(43) <= pp9(43);
l5pp9(63 downto 44) <= pp9(63 downto 44);

l5pp10(23 downto 0) <= pp10(23 downto 0);
l5pp9(24) <= pp10(24);
l5pp10(25) <= pp10(25);
l5pp8(26) <= pp10(26);
l5pp9(27) <= pp10(27);
l5pp7(28) <= pp10(28);
l5pp8(29) <= pp10(29);
l5pp8(38 downto 37) <= pp10(38 downto 37);
l5pp9(40 downto 39) <= pp10(40 downto 39);
l5pp10(42 downto 41) <= pp10(42 downto 41);
l5pp11(43) <= pp10(43);
l5pp10(63 downto 44) <= pp10(63 downto 44);

l5pp11(23 downto 0) <= pp11(23 downto 0);
l5pp10(24) <= pp11(24);
l5pp11(25) <= pp11(25);
l5pp9(26) <= pp11(26);
l5pp10(27) <= pp11(27);
l5pp8(28) <= pp11(28);
l5pp9(29) <= pp11(29);
l5pp7(30) <= pp11(30);
l5pp8(31) <= pp11(31);
l5pp8(36) <= pp11(36);
l5pp9(38 downto 37) <= pp11(38 downto 37);
l5pp10(40 downto 39) <= pp11(40 downto 39);
l5pp11(42 downto 41) <= pp11(42 downto 41);
l5pp12(43) <= pp11(43);
l5pp11(44) <= pp11(44);
l5pp11(63 downto 43) <= pp11(63 downto 43);

l5pp12(23 downto 0) <= pp12(23 downto 0);
l5pp11(24) <= pp12(24);
l5pp12(25) <= pp12(25);
l5pp10(26) <= pp12(26);
l5pp11(27) <= pp12(27);
l5pp9(28) <= pp12(28);
l5pp10(29) <= pp12(29);
l5pp8(30) <= pp12(30);
l5pp9(31) <= pp12(31);
l5pp8(35 downto 32) <= pp12(35 downto 32);
l5pp9(36) <= pp12(36);
l5pp10(38 downto 37) <= pp12(38 downto 37);
l5pp11(40 downto 39) <= pp12(40 downto 39);
l5pp12(63 downto 41) <= pp12(63 downto 41);

l5pp12(24) <= pp13(24);
l5pp11(26) <= pp13(26);
l5pp12(27) <= pp13(27);
l5pp10(28) <= pp13(28);
l5pp11(29) <= pp13(29);
l5pp9(30) <= pp13(30);
l5pp10(31) <= pp13(31);
l5pp9(35 downto 32) <= pp13(35 downto 32);
l5pp10(36) <= pp13(36);
l5pp11(38 downto 37) <= pp13(38 downto 37);
l5pp12(40 downto 39) <= pp13(40 downto 39);

l5pp12(26) <= pp14(26);
l5pp11(28) <= pp14(28);
l5pp12(29) <= pp14(29);
l5pp10(30) <= pp14(30);
l5pp11(31) <= pp14(31);
l5pp10(35 downto 32) <= pp14(35 downto 32);
l5pp11(36) <= pp14(36);
l5pp12(38 downto 37) <= pp14(38 downto 37);

l5pp12(28) <= pp15(28);
l5pp11(30) <= pp15(30);
l5pp12(31) <= pp15(31);
l5pp11(35 downto 32) <= pp15(35 downto 32);
l5pp12(36) <= pp15(36);

l5pp12(30) <= pp16(30);
l5pp12(35 downto 32) <= pp16(35 downto 32);

----------------------------------------------------------------------------------------------------------------
-- From LEVEL 5 to LEVEL 4 (to 9 pp): 104 FA & 12 HA
----------------------------------------------------------------------------------------------------------------

-- 104 FA

l5_fa_18_49 : for i in 18 to 49 generate
	l5_fa_first_row: FA PORT MAP(l5pp0(i), l5pp1(i), l5pp2(i), l4pp0(i), l4pp1(i+1));
end generate l5_fa_18_49;

l5_fa_20_47 : for i in 20 to 47 generate
	l5_fa_second_row: FA PORT MAP(l5pp3(i), l5pp4(i), l5pp5(i), l4pp2(i), l4pp3(i+1));
end generate l5_fa_20_47;

l5_fa_22_45 : for i in 22 to 45 generate
	l5_fa_third_row: FA PORT MAP(l5pp6(i), l5pp7(i), l5pp8(i), l4pp4(i), l4pp5(i+1));
end generate l5_fa_22_45;

l5_fa_24_43 : for i in 24 to 43 generate
	l5_fa_fourth_row: FA PORT MAP(l5pp9(i), l5pp10(i), l5pp11(i), l4pp6(i), l4pp7(i+1));
end generate l5_fa_24_43;

-- 12 HA

l5_ha_16 : HA PORT MAP(l5pp0(16), l5pp1(16), l4pp0(16), l4pp1(17));
l5_ha_17 : HA PORT MAP(l5pp0(17), l5pp1(17), l4pp0(17), l4pp1(18));

l5_ha_18 : HA PORT MAP(l5pp3(18), l5pp4(18), l4pp2(18), l4pp3(19));
l5_ha_19 : HA PORT MAP(l5pp3(19), l5pp4(19), l4pp2(19), l4pp3(20));

l5_ha_20 : HA PORT MAP(l5pp6(20), l5pp7(20), l4pp4(20), l4pp5(21));
l5_ha_21 : HA PORT MAP(l5pp6(21), l5pp7(21), l4pp4(21), l4pp5(22));

l5_ha_22 : HA PORT MAP(l5pp9(22), l5pp10(22), l4pp6(22), l4pp7(23));
l5_ha_23 : HA PORT MAP(l5pp9(23), l5pp10(23), l4pp6(23), l4pp7(24));

l5_ha_44 : HA PORT MAP(l5pp9(44), l5pp10(44), l4pp6(44), l4pp6(45));

l5_ha_46 : HA PORT MAP(l5pp6(46), l5pp7(46), l4pp4(46), l4pp4(47));

l5_ha_48 : HA PORT MAP(l5pp3(48), l5pp4(48), l4pp2(48), l4pp2(49));

l5_ha_50 : HA PORT MAP(l5pp0(50), l5pp1(50), l4pp0(50), l4pp0(51));

-- Dots not used in any adder

l4pp0(15 downto 0) <= l5pp0(15 downto 0);
l4pp1(51) <= l5pp0(51);
l4pp0(63 downto 52) <= l5pp0(63 downto 52);

l4pp1(15 downto 0) <= l5pp1(15 downto 0);
l4pp2(51) <= l5pp1(51);
l4pp1(63 downto 52) <= l5pp1(63 downto 52);

l4pp2(15 downto 0) <= l5pp2(15 downto 0);
l4pp1(16) <= l5pp2(16);
l4pp2(17) <= l5pp2(17);
l4pp2(50) <= l5pp2(50);
l4pp3(51) <= l5pp2(51);
l4pp2(63 downto 52) <= l5pp2(63 downto 52);

l4pp3(15 downto 0) <= l5pp3(15 downto 0);
l4pp2(16) <= l5pp3(16);
l4pp3(17) <= l5pp3(17);
l4pp3(50 downto 49) <= l5pp3(50 downto 49);
l4pp4(51) <= l5pp3(51);
l4pp3(63 downto 52) <= l5pp3(63 downto 52);

l4pp4(15 downto 0) <= l5pp4(15 downto 0);
l4pp3(16) <= l5pp4(16);
l4pp4(17) <= l5pp4(17);
l4pp4(50 downto 49) <= l5pp4(50 downto 49);
l4pp5(51) <= l5pp4(51);
l4pp4(63 downto 52) <= l5pp4(63 downto 52);

l4pp5(15 downto 0) <= l5pp5(15 downto 0);
l4pp4(16) <= l5pp5(16);
l4pp5(17) <= l5pp5(17);
l4pp3(18) <= l5pp5(18);
l4pp4(19) <= l5pp5(19);
l4pp4(48) <= l5pp5(48);
l4pp5(50 downto 49) <= l5pp5(50 downto 49);
l4pp6(51) <= l5pp5(51);
l4pp5(63 downto 52) <= l5pp5(63 downto 52);

l4pp6(15 downto 0) <= l5pp6(15 downto 0);
l4pp5(16) <= l5pp6(16);
l4pp6(17) <= l5pp6(17);
l4pp4(18) <= l5pp6(18);
l4pp5(19) <= l5pp6(19);
l4pp5(47) <= l5pp6(47);
l4pp5(48) <= l5pp6(48);
l4pp6(50 downto 49) <= l5pp6(50 downto 49);
l4pp7(51) <= l5pp6(51);
l4pp6(63 downto 52) <= l5pp6(63 downto 52);

l4pp7(15 downto 0) <= l5pp7(15 downto 0);
l4pp6(16) <= l5pp7(16);
l4pp7(17) <= l5pp7(17);
l4pp5(18) <= l5pp7(18);
l4pp6(19) <= l5pp7(19);
l4pp6(48 downto 47) <= l5pp7(48 downto 47);
l4pp7(50 downto 49) <= l5pp7(50 downto 49);
l4pp8(51) <= l5pp7(51);
l4pp7(63 downto 52) <= l5pp7(63 downto 52);

l4pp8(15 downto 0) <= l5pp8(15 downto 0);
l4pp7(16) <= l5pp8(16);
l4pp8(17) <= l5pp8(17);
l4pp6(18) <= l5pp8(18);
l4pp7(19) <= l5pp8(19);
l4pp5(20) <= l5pp8(20);
l4pp6(21) <= l5pp8(21);
l4pp6(46) <= l5pp8(46);
l4pp7(48 downto 47) <= l5pp8(48 downto 47);
l4pp8(50 downto 49) <= l5pp8(50 downto 49);
l4pp8(63 downto 52) <= l5pp8(63 downto 52);

l4pp8(16) <= l5pp9(16);
l4pp7(18) <= l5pp9(18);
l4pp8(19) <= l5pp9(19);
l4pp6(20) <= l5pp9(20);
l4pp7(21) <= l5pp9(21);
l4pp7(46 downto 45) <= l5pp9(46 downto 45);
l4pp8(48 downto 47) <= l5pp9(48 downto 47);

l4pp8(18) <= l5pp10(18);
l4pp7(20) <= l5pp10(20);
l4pp8(21) <= l5pp10(21);
l4pp8(46 downto 45) <= l5pp10(46 downto 45);

l4pp8(20) <= l5pp11(20);
l4pp7(22) <= l5pp11(22);
l4pp8(23) <= l5pp11(23);
l4pp8(44) <= l5pp11(44);

l4pp8(43 downto 24) <= l5pp12(43 downto 24);
l4pp8(22) <= l5pp12(22);


----------------------------------------------------------------------------------------------------------------
-- From LEVEL 4 to LEVEL 3 (to 6 pp): 120 FA & 9 HA
----------------------------------------------------------------------------------------------------------------

-- 120 FA

l4_fa_12_55 : for i in 12 to 55 generate
	l4_fa_first_row : FA PORT MAP(l4pp0(i), l4pp1(i), l4pp2(i), l3pp0(i), l3pp1(i+1));
end generate l4_fa_12_55;

l4_fa_14_53 : for i in 14 to 53 generate
	l4_fa_second_row : FA PORT MAP(l4pp3	(i), l4pp4(i), l4pp5(i), l3pp2(i), l3pp3(i+1));
end generate l4_fa_14_53;

l4_fa_16_51 : for i in 16 to 51 generate
	l4_fa_third_row : FA PORT MAP(l4pp6(i), l4pp7(i), l4pp8(i), l3pp4(i), l3pp5(i+1));
end generate l4_fa_16_51;

-- 9 HA

l4_ha_10 : HA PORT MAP(l4pp0(10), l4pp1(10), l3pp0(10), l3pp1(11));
l4_ha_11 : HA PORT MAP(l4pp0(11), l4pp1(11), l3pp0(11), l3pp1(12));

l4_ha_12 : HA PORT MAP(l4pp3(12), l4pp4(12), l3pp2(12), l3pp3(13));
l4_ha_13 : HA PORT MAP(l4pp3(13), l4pp4(13), l3pp2(13), l3pp3(14));

l4_ha_14 : HA PORT MAP(l4pp6(14), l4pp7(14), l3pp4(14), l3pp5(15));
l4_ha_15 : HA PORT MAP(l4pp6(15), l4pp7(15), l3pp4(15), l3pp5(16));

l4_ha_52 : HA PORT MAP(l4pp6(52), l4pp7(52), l3pp4(52), l3pp4(53));

l4_ha_54 : HA PORT MAP(l4pp3(54), l4pp4(54), l3pp2(54), l3pp2(55));

l4_ha_56 : HA PORT MAP(l4pp0(56), l4pp1(56) , l3pp0(56), l3pp0(57));

-- Dots not used for any adder

l3pp0(9 downto 0) <= l4pp0(9 downto 0);
l3pp1(57) <= l4pp0(57);
l3pp0(63 downto 58) <= l4pp0(63 downto 58);

l3pp1(9 downto 0) <= l4pp1(9 downto 0);
l3pp2(57) <= l4pp1(57);
l3pp1(63 downto 58) <= l4pp1(63 downto 58);

l3pp2(9 downto 0) <= l4pp2(9 downto 0);
l3pp1(10) <= l4pp2(10);
l3pp2(11) <= l4pp2(11);
l3pp2(56) <= l4pp2(56);
l3pp3(57) <= l4pp2(57);
l3pp2(63 downto 58) <= l4pp2(63 downto 58);

l3pp3(9 downto 0) <= l4pp3(9 downto 0);
l3pp2(10) <= l4pp3(10);
l3pp3(11) <= l4pp3(11);
l3pp3(56 downto 55) <= l4pp3(56 downto 55);
l3pp4(57) <= l4pp3(57);
l3pp3(63 downto 58) <= l4pp3(63 downto 58);

l3pp4(9 downto 0) <= l4pp4(9 downto 0);
l3pp3(10) <= l4pp4(10);
l3pp4(11) <= l4pp4(11);
l3pp4(56 downto 55) <= l4pp4(56 downto 55);
l3pp5(57) <= l4pp4(57);
l3pp4(63 downto 58) <= l4pp4(63 downto 58);

l3pp5(9 downto 0) <= l4pp5(9 downto 0);
l3pp4(10) <= l4pp5(10);
l3pp5(11) <= l4pp5(11);
l3pp3(12) <= l4pp5(12);
l3pp4(13) <= l4pp5(13);
l3pp4(54) <= l4pp5(54);
l3pp5(63 downto 55) <= l4pp5(63 downto 55);

l3pp5(10) <= l4pp6(10);
l3pp4(12) <= l4pp6(12);
l3pp5(13) <= l4pp6(13);
l3pp5(53) <= l4pp6(53);
l3pp5(54) <= l4pp6(54);

l3pp5(12) <= l4pp7(12);

l3pp5(14) <= l4pp8(14);

----------------------------------------------------------------------------------------------------------------
-- From LEVEL 3 to LEVEL 2 (to 4 pp): 100 FA & 6 HA
----------------------------------------------------------------------------------------------------------------

-- 100 FA

l3_fa_8_59 : for i in 8 to 59 generate
	l3_fa_first_row : FA PORT MAP(l3pp0(i), l3pp1(i), l3pp2(i), l2pp0(i), l2pp1(i+1));
end generate l3_fa_8_59;

l3_fa_10_57 : for i in 10 to 57 generate
	l3_fa_second_row : FA PORT MAP(l3pp3(i), l3pp4(i), l3pp5(i), l2pp2(i), l2pp3(i+1));
end generate l3_fa_10_57;

-- 6 HA

l3_ha_6 : HA PORT MAP(l3pp0(6), l3pp1(6), l2pp0(6), l2pp1(7));
l3_ha_7 : HA PORT MAP(l3pp0(7), l3pp1(7), l2pp0(7), l2pp1(8));

l3_ha_8 : HA PORT MAP(l3pp3(8), l3pp4(8), l2pp2(8), l2pp3(9));
l3_ha_9 : HA PORT MAP(l3pp3(9), l3pp4(9), l2pp2(9), l2pp3(10));

l3_ha_58 : HA PORT MAP(l3pp3(58), l3pp4(58), l2pp2(58), l2pp2(59));

l3_ha_60 : HA PORT MAP(l3pp0(60), l3pp1(60), l2pp0(60), l2pp0(61));

-- Dots not used in any adder

l2pp0(5 downto 0) <= l3pp0(5 downto 0);
l2pp1(61) <= l3pp0(61);
l2pp0(63 downto 62) <= l3pp0(63 downto 62);

l2pp1(5 downto 0) <= l3pp1(5 downto 0);
l2pp2(61) <= l3pp1(61);
l2pp1(63 downto 62) <= l3pp1(63 downto 62);

l2pp2(5 downto 0) <= l3pp2(5 downto 0);
l2pp1(6) <= l3pp2(6);
l2pp2(7) <= l3pp2(7);
l2pp2(60) <= l3pp2(60);
l2pp3(61) <= l3pp2(61);
l2pp2(63 downto 62) <= l3pp2(63 downto 62);

l2pp3(5 downto 0) <= l3pp3(5 downto 0);
l2pp2(6) <= l3pp3(6);
l2pp3(7) <= l3pp3(7);
l2pp3(60 downto 59) <= l3pp3(60 downto 59);
l2pp3(63 downto 62) <= l3pp3(63 downto 62);

l2pp3(6) <= l3pp4(6);

l2pp3(8) <= l3pp5(8);

----------------------------------------------------------------------------------------------------------------
-- From LEVEL 2 to LEVEL 1 (to 3 pp): 56 FA & 3 HA
----------------------------------------------------------------------------------------------------------------

-- 56 FA

l2_fa_6_61 : for i in 6 to 61 generate
	l2_fa_row : FA PORT MAP(l2pp0(i), l2pp1(i), l2pp2(i), l1pp0(i), l1pp1(i+1));
end generate l2_fa_6_61;

-- 3 HA

l2_ha_4 : HA PORT MAP(l2pp0(4), l2pp1(4), l1pp0(4), l1pp1(5));
l2_ha_5 : HA PORT MAP(l2pp0(5), l2pp1(5), l1pp0(5), l1pp1(6));

l2_ha_62 : HA PORT MAP(l2pp0(62), l2pp1(62), l1pp0(62), l1pp0(63));

-- Dots not used for any adder

l1pp0(3 downto 0) <= l2pp0(3 downto 0);
l1pp1(63) <= l2pp0(63);

l1pp1(3 downto 0) <= l2pp1(3 downto 0);
l1pp2(63) <= l2pp1(63);

l1pp2(3 downto 0) <= l2pp2(3 downto 0);
l1pp1(4) <= l2pp2(4);
l1pp2(5) <= l2pp2(5);
l1pp2(62) <= l2pp2(62);

l1pp2(4) <= l2pp3(4);
l1pp2(61 downto 6) <= l2pp3(61 downto 6);

----------------------------------------------------------------------------------------------------------------
-- From LEVEL 1 to LEVEL 0 (to 2 pp): 60 FA & 2 HA
----------------------------------------------------------------------------------------------------------------

-- 60 FA

l1_fa_4_63 : for i in 4 to 63 generate
	l1_fa_row : FA PORT MAP(l1pp0(i), l1pp1(i), l1pp2(i), l0pp0(i), l0pp1(i+1));
end generate l1_fa_4_63;

-- 2 HA 

l1_ha_2 : HA PORT MAP(l1pp0(2), l1pp1(2), l0pp0(2), l0pp1(3));
l1_ha_3 : HA PORT MAP(l1pp0(3), l1pp1(3), l0pp0(3), l0pp1(4));

-- Not used dots

l0pp0(1 downto 0) <= l1pp0(1 downto 0);
l0pp0(64) <= '0';

l0pp1(0) <= l1pp1(0);
l0pp1(1) <= '0';
l0pp1(2) <= l1pp2(2);

----------------------------------------------------------------------------------------------------------------
-- Final ADDER: 64 bits inputs
----------------------------------------------------------------------------------------------------------------

prod64 <= unsigned(l0pp0) + unsigned(l0pp1);
PROD <= prod64(63 downto 0); 

END beh;


