LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Registre_PC IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        D : IN std_logic_vector(31 DOWNTO 0);
        Q : OUT std_logic_vector(31 DOWNTO 0)
    );
END Registre_PC;

ARCHITECTURE RTL OF Registre_PC IS
    SIGNAL Qin : signed(31 DOWNTO 0);
BEGIN

    PROCESS (CLK, Reset) 
    BEGIN
    IF Reset = '1' THEN
        Qin <= (OTHERS=>'0');
    ELSIF RISING_EDGE(CLK) THENN
            Qin <= D;
        END IF;
    END PROCESS;
    Q <= Qin;
END RTL;