LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

---------------------------------------
ENTITY Registre IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        DATAIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        WE : IN STD_LOGIC;
        DATAOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Registre;
---------------------------------------
ARCHITECTURE RTL OF Registre IS
    ---------------------------------------
    SIGNAL d_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            d_out <= (OTHERS => '0');
        ELSIF RISING_EDGE(CLK) THEN
            IF WE = '1' THEN
                d_out <= DATAIN;
            END IF;
        END IF;
    END PROCESS;
    DATAOUT <= d_out;
END RTL;