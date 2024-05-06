LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY tb_ALU IS
END;
    
ARCHITECTURE TEST OF tb_ALU IS
    -- Signal declarations
SIGNAL tb_OP : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
SIGNAL tb_A : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
SIGNAL tb_B : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
SIGNAL tb_S : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL tb_N, tb_Z, tb_C, tb_V : STD_LOGIC;

BEGIN
    -- Unit Under Test instanciation
    UUT: entity work.ALU 
    PORT MAP (
        OP => tb_OP,
        A => tb_A,
        B => tb_B,
        S => tb_S,
        N => tb_N,
        Z => tb_Z,
        C => tb_C,
        V => tb_V
    );

-- Control Simulation and check outputs
    PROCESS BEGIN
    
    -- Test 1
    tb_OP <= "000";
    tb_A <= "00000000000000000000000000000001";
    tb_B <= "00000000000000000000000000000010";
    WAIT FOR 10 ns;
    report "Checking output (should be 3).";
    ASSERT tb_S = "00000000000000000000000000000011" REPORT "Test 1 failed: Addition operation incorrect" SEVERITY WARNING;
    ASSERT tb_N = '0' REPORT "Test 1 failed: N flag incorrect" SEVERITY WARNING;
    ASSERT tb_Z = '0' REPORT "Test 1 failed: Z flag incorrect" SEVERITY WARNING;
    ASSERT tb_C = '0' REPORT "Test 1 failed: C flag incorrect" SEVERITY WARNING;
    ASSERT tb_V = '0' REPORT "Test 1 failed: V flag incorrect" SEVERITY WARNING;


    WAIT;
    END PROCESS;

END ARCHITECTURE tb_ALU;