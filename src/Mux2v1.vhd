LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

---------------------------------------
ENTITY Mux2v1 IS
    ---------------------------------------
    GENERIC (
        N : INTEGER := 32
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        COM : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END ENTITY Mux2v1;


---------------------------------------
ARCHITECTURE BEHAVIORAL OF Mux2v1 IS
---------------------------------------
BEGIN
    PROCESS (COM, A, B)
    BEGIN
        IF COM = '0' THEN
            S <= A;
        ELSE
            S <= B;
        END IF;
    END PROCESS;
END ARCHITECTURE BEHAVIORAL;



