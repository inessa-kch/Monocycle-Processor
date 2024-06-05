LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-----------------------------------------
ENTITY Top_Processeur IS
    ---------------------------------------
    PORT (
        CLOCK_50 : IN STD_LOGIC;
        KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END ENTITY Top_Processeur;

---------------------------------------
ARCHITECTURE RTL OF Top_Processeur IS
    ---------------------------------------
    SIGNAL rst, clk, pol : STD_LOGIC;
    SIGNAL irq0, irq1 : STD_LOGIC;
    SIGNAL afficheur_int: STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    rst <= SW(0);
    irq0 <= NOT KEY(0);
    irq1 <= NOT KEY(1);
    clk <= CLOCK_50;
    pol <= SW(9);

    entity_processeur: entity work.Processeur
        PORT MAP (
            CLK=>clk,
            Reset=>rst,
            IRQ0=>irq0,
            IRQ1=>irq1,
            Afficheur=>afficheur_int
        );

    entity_HEX0: entity work.SEVEN_SEG
        PORT MAP(
            Data=>afficheur_int(3 DOWNTO 0),
            Pol=>pol,
            Segout=>HEX0
        );

    entity_HEX1: entity work.SEVEN_SEG
    PORT MAP(
        Data=>afficheur_int(7 downto 4),
        Pol=>pol,
        Segout=>HEX1
    );

    entity_HEX2: entity work.SEVEN_SEG
    PORT MAP(
        Data=>afficheur_int(11 DOWNTO 8),
        Pol=>pol,
        Segout=>HEX2
    );

    entity_HEX3: entity work.SEVEN_SEG
    PORT MAP(
        Data=>afficheur_int(15 DOWNTO 12),
        Pol=>pol,
        Segout=>HEX3
    );    

END ARCHITECTURE;