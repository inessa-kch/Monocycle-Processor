LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
---------------------------------------
ENTITY Extension IS
    ---------------------------------------
    GENERIC (
        N : INTEGER := 8
    );

    PORT (
        E : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Extension;
ARCHITECTURE BEHAVIORAL OF Extension IS
BEGIN
    PROCESS (E)
    BEGIN
        IF E(N - 1) = '1' THEN
            S <= (31 DOWNTO N => '1') & E;
        ELSE
            S <= (31 DOWNTO N => '0') & E;
        END IF;
    END PROCESS;
END BEHAVIORAL;