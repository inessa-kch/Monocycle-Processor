LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY tb_ALU IS
END;
    
ARCHITECTURE TB_ARCH OF tb_ALU IS
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
    tb_A <= "11100000000000000000000000000000";
    tb_B <= "01000000000000000000000000000000";
    WAIT FOR 10 ns;
    report "Checking output for Addition (should be 0x20000000).";
    ASSERT tb_S = std_logic_vector(unsigned(tb_A) + unsigned(tb_B)) REPORT "Test 1 failed: Addition operation incorrect" SEVERITY WARNING;
    ASSERT tb_N = '0' REPORT "Test 1 failed: N flag incorrect" SEVERITY WARNING;
    ASSERT tb_Z = '0' REPORT "Test 1 failed: Z flag incorrect" SEVERITY WARNING;
    ASSERT tb_C = '1' REPORT "Test 1 failed: C flag incorrect" SEVERITY WARNING;
    ASSERT tb_V = '0' REPORT "Test 1 failed: V flag incorrect" SEVERITY WARNING;


    -- Test 2
    tb_OP <= "001";
    tb_B <= "00000000000000000000000000000000";
    WAIT FOR 10 ns;
    report "Checking output for S=B (should be 0).";
    ASSERT tb_S = tb_B REPORT "Test 2 failed: S=B operation incorrect" SEVERITY WARNING;
    ASSERT tb_N = '0' REPORT "Test 2 failed: N flag incorrect" SEVERITY WARNING;
    ASSERT tb_Z = '1' REPORT "Test 2 failed: Z flag incorrect" SEVERITY WARNING;
    ASSERT tb_C = '0' REPORT "Test 2 failed: C flag incorrect" SEVERITY WARNING;
    ASSERT tb_V = '0' REPORT "Test 2 failed: V flag incorrect" SEVERITY WARNING;


    -- Test 3
    tb_OP <= "010";
    tb_A <= "11000000000000000000000000000000";
    tb_B <= "10000000000000000000000000000000";
    WAIT FOR 10 ns;
    report "Checking output for Substraction (should be 0x40000000).";
    ASSERT tb_S = std_logic_vector(unsigned(tb_A) - unsigned(tb_B)) REPORT "Test 3 failed: Substraction operation incorrect" SEVERITY WARNING;
    ASSERT tb_N = '0' REPORT "Test 3 failed: N flag incorrect" SEVERITY WARNING;
    ASSERT tb_Z = '0' REPORT "Test 3 failed: Z flag incorrect" SEVERITY WARNING;
    ASSERT tb_C = '1' REPORT "Test 3 failed: C flag incorrect" SEVERITY WARNING;
    ASSERT tb_V = '1' REPORT "Test 3 failed: V flag incorrect" SEVERITY WARNING;


    -- Test 4
    tb_OP <= "011";
    tb_A <= "10000000000000000000000000000000";
    WAIT FOR 10 ns;
    report "Checking output for S=A (should be 0x80000000).";
    ASSERT tb_S = tb_A REPORT "Test 4 failed: S=A operation incorrect" SEVERITY WARNING;
    ASSERT tb_N = '1' REPORT "Test 4 failed: N flag incorrect" SEVERITY WARNING;
    ASSERT tb_Z = '0' REPORT "Test 4 failed: Z flag incorrect" SEVERITY WARNING;
    ASSERT tb_C = '0' REPORT "Test 4 failed: C flag incorrect" SEVERITY WARNING;
    ASSERT tb_V = '0' REPORT "Test 4 failed: V flag incorrect" SEVERITY WARNING;
    


    WAIT;
    END PROCESS;

END ARCHITECTURE;