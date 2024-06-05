LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY Memoire_Data IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        DataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Addr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        WrEn : IN STD_LOGIC
    );
END ENTITY Memoire_Data;

---------------------------------------
ARCHITECTURE RTL OF Memoire_Data IS
    ---------------------------------------
    -- Declaration Type Tableau Memoire
    TYPE MemoryType IS ARRAY(63 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- Fonction d'Initialisation de la mémoire de données
    FUNCTION init_memoire RETURN MemoryType IS
        VARIABLE result : MemoryType;
    BEGIN
        FOR i IN 63 DOWNTO 0 LOOP
            result(i) := X"00000000";
        END LOOP;
        result(16):=X"00000001";
        result(17):=X"00000001";
        result(18):=X"00000001";
        result(19):=X"00000001";
        result(20):=X"00000001";
        result(21):=X"00000001";
        result(22):=X"00000001";
        result(23):=X"00000001";
        result(24):=X"00000001";
        result(25):=X"00000001";
        result(26):=X"00000001";

        RETURN result;
    END init_memoire;

-- Déclaration et Initialisation de la mémoire de données 64x32 bits
SIGNAL Memory : MemoryType:=init_memoire;
BEGIN
    --lecture
    DataOut <= Memory(to_integer(unsigned(Addr)));
    --ecriture
    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            Memory<= init_memoire;
        ELSIF RISING_EDGE(CLK) THEN
            IF WrEn = '1' THEN
                Memory(to_integer(unsigned(Addr))) <= DataIn;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;



