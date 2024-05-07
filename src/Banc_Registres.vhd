LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
---------------------------------------
ENTITY Banc_Registres IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC; -- Horloge
        Reset : IN STD_LOGIC; -- Reset asynchrone (actif à l’état haut)
        W : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RA : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        WE : IN STD_LOGIC;
        A : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        B : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Banc_Registres;
---------------------------------------
ARCHITECTURE RTL OF Banc_Registres IS
    ---------------------------------------
    -- Declaration Type Tableau Memoire
    TYPE table IS ARRAY(15 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Fonction d'Initialisation du Banc de Registres
    FUNCTION init_banc RETURN table IS
        VARIABLE result : table;
    BEGIN
        FOR i IN 14 DOWNTO 0 LOOP
            result(i) := (OTHERS => '0');
        END LOOP;
        result(15) := X"00000030";
        RETURN result;
    END init_banc;
    -- Déclaration et Initialisation du Banc de Registres 16x32 bits
    SIGNAL Banc : table := init_banc;

BEGIN

    A <= Banc(to_integer(unsigned(RA)));
    B <= Banc(to_integer(unsigned(RB)));


    PROCESS (CLK, Reset) IS
    BEGIN
        IF Reset = '1' THEN
            Banc <= init_banc;
        ELSIF rising_edge(CLK) THEN
            IF WE = '1' THEN
                Banc(to_integer(unsigned(RW))) <= W;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;