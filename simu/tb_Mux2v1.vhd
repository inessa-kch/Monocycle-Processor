LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;



ENTITY tb_Mux2v1 IS
END;


ARCHITECTURE TEST OF tb_Mux2v1 IS
-- Signal declarations
SIGNAL tb_A, tb_B : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_COM : STD_LOGIC;
SIGNAL tb_S : STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN
    -- Unit Under Test instanciation
    UUT: entity work.Mux2v1 GENERIC MAP(N => 32)
        PORT MAP(
            A => tb_A,
            B => tb_B,
            COM => tb_COM,
            S => tb_S
        );


    -- Control Simulation and check outputs
    PROCESS BEGIN
        tb_A <= "10000000000000000000000000000000";
        tb_B <= "00000000000000000000000000000000";
        tb_COM <= '0';
        WAIT FOR 10 ns;
        REPORT "Checking output (should be 0x80000000).";
        ASSERT tb_S = tb_A REPORT "Test failed: Mux2v1 incorrect" SEVERITY WARNING;
  


        tb_A <= "00000000000000000000000000000000";
        tb_B <= "00000000000000000000000000000011";
        tb_COM <= '1';
        WAIT FOR 10 ns;
        REPORT "Checking output (should be 0x00000003).";
        ASSERT tb_S = tb_B REPORT "Test failed: Mux2v1 incorrect" SEVERITY WARNING;

        REPORT "End of test. Verify that no error was reported.";

        WAIT;
    END PROCESS;

END ARCHITECTURE TEST;