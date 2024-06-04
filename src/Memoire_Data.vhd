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
        result(32):=X"00000001";
        result(33):=X"00000001";
        result(34):=X"00000001";
        result(35):=X"00000001";
        result(36):=X"00000001";
        result(37):=X"00000001";
        result(38):=X"00000001";
        result(39):=X"00000001";
        result(40):=X"00000001";
        result(41):=X"00000001";
        result(42):=X"00000001";

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



