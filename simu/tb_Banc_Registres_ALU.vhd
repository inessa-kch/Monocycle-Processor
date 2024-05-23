LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY tb_Banc_Registres_ALU IS
END;

ARCHITECTURE TEST OF tb_Banc_Registres_ALU IS

    CONSTANT Period : TIME := 10 us; -- speed up simulation with a 100kHz clock

    -- Signal declarations
    SIGNAL tb_CLK : STD_LOGIC := '0';
    SIGNAL tb_Reset : STD_LOGIC := '1';
    SIGNAL tb_RA : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL tb_RB : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL tb_RW : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL tb_WE : STD_LOGIC := '0';
    SIGNAL tb_OP : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL tb_W : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
    SIGNAL tb_N, tb_Z, tb_C, tb_V : STD_LOGIC;
    SIGNAL tb_A : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
    SIGNAL tb_B : STD_LOGIC_VECTOR(31 DOWNTO 0):= (others => '0');
    SIGNAL Done : BOOLEAN;
BEGIN

    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;
    tb_Reset <= '1', '0' AFTER Period;
    -- Unit Under Test instanciation
    UUT : ENTITY work.Banc_Registres
        PORT MAP(
            CLK => tb_CLK,
            Reset => tb_Reset,
            W => tb_W,
            RA => tb_RA,
            RB => tb_RB,
            RW => tb_RW,
            WE => tb_WE,
            A => tb_A,
            B => tb_B
        );

    entity_ALU : ENTITY work.ALU
        PORT MAP(
            OP => tb_OP,
            A => tb_A,
            B => tb_B,
            S => tb_W,
            N => tb_N,
            Z => tb_Z,
            C => tb_C,
            V => tb_V
        );
    -- Control Simulation and check outputs
    PROCESS     
    
    BEGIN
        WAIT FOR Period;
        -- R(1) = R(15)
        tb_RA <= "1111";
        tb_RW <= "0001";
        tb_WE <= '1';
        tb_OP <= "011";
        WAIT FOR Period;
        tb_WE <= '0';
        WAIT FOR Period;
        ASSERT tb_A = tb_W REPORT "Test 1 failed: register W should be equal to 0x00000030" SEVERITY WARNING;


        -- R(1) = R(1) + R(15)
        tb_RA <= "0001";
        tb_RB <= "1111";
        tb_RW <= "0001";
        tb_WE <= '1';
        tb_OP <= "000";
        WAIT FOR Period;
        tb_WE <= '0';
        WAIT FOR Period;
        ASSERT tb_W = std_logic_vector(signed(tb_A) + signed(tb_B)) REPORT "Test 2 failed: register W should be equal to 0x00000060" SEVERITY WARNING;

        -- R(2) = R(1) + R(15)
        tb_RA <= "0001";
        tb_RB <= "1111";
        tb_RW <= "0010";
        tb_WE <= '1';
        tb_OP <= "000";
        WAIT FOR Period;
        tb_WE <= '0';
        WAIT FOR Period;
        ASSERT tb_W = std_logic_vector(signed(tb_A) + signed(tb_B)) REPORT "Test 3 failed: register W should be equal to 0x00000090" SEVERITY WARNING;

        -- R(3) = R(1) – R(15)
        tb_WE <= '1';
        tb_RA <= "0001";
        tb_RB <= "1111";
        tb_RW <= "0011";
        tb_OP <= "010";
        WAIT FOR Period;
        tb_WE <= '0';
        WAIT FOR Period;
        ASSERT tb_W = std_logic_vector(signed(tb_A) - signed(tb_B)) REPORT "Test 4 failed: register W should be equal to 0x00000030" SEVERITY WARNING;


        -- R(5) = R(7) – R(15)
        tb_RA <= "0111";
        tb_RB <= "1111";
        tb_RW <= "0101";
        tb_WE <= '1';
        tb_OP <= "010";
        WAIT FOR Period;
        tb_WE <= '0';
        WAIT FOR Period;
        ASSERT tb_W = std_logic_vector(signed(tb_A) - signed(tb_B)) REPORT "Test 5 failed: register W should be equal to 0xFFFFFFD0" SEVERITY WARNING;
        

        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE;