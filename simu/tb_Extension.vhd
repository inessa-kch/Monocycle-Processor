LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;



ENTITY tb_Extension IS
END;


ARCHITECTURE TEST OF tb_Extension IS
-- Signal declarations
signal tb_E : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal tb_S : STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN
    -- Unit Under Test instanciation
    UUT: entity work.Extension GENERIC MAP(N => 8)
        PORT MAP(
            E => tb_E,
            S => tb_S
        );


    -- Control Simulation and check outputs
    PROCESS BEGIN
        tb_E <= "10001000";
        WAIT FOR 10 ns;
        REPORT "Checking output (should be 0xFFFFFF88).";
        ASSERT tb_S = "11111111111111111111111110001000" REPORT "Test failed: Extension incorrect" SEVERITY WARNING;
  


        REPORT "End of test. Verify that no error was reported.";

        WAIT;
    END PROCESS;

END ARCHITECTURE TEST;