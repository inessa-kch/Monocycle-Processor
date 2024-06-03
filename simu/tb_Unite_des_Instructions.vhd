LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY tb_Unite_des_Instructions IS
    ---------------------------------------
END ENTITY;


---------------------------------------
ARCHITECTURE TEST OF tb_Unite_des_Instructions IS
    ---------------------------------------
    CONSTANT Period : TIME := 4 ns; 
    SIGNAL tb_CLK : STD_LOGIC := '0';
    SIGNAL tb_Reset : STD_LOGIC :='0';
    SIGNAL tb_Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_Offset : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_nPCsel : STD_LOGIC := '0';   
    SIGNAL Done : BOOLEAN := false;
BEGIN
    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;

    -- Unit Under Test instanciation
    entity_UDI : ENTITY work.Unite_des_Instructions
        PORT MAP(
            CLK=> tb_CLK,
            Reset => tb_Reset,
            Instruction => tb_Instruction,
            Offset => tb_Offset,
            nPCsel => tb_nPCsel
        );

    PROCESS
    BEGIN

        tb_Reset <= '1';
        WAIT FOR Period;
        tb_Reset <= '0';
        ASSERT tb_Instruction = x"E3A01020" report " Test 1 : Instruction is incorrect" severity error;

        tb_nPCsel <= '0';
        wait for period;
        ASSERT tb_Instruction = x"E3A02000" report " Test 2 : Instruction is incorrect" severity error;
        wait for 3*period;
        ASSERT tb_Instruction = X"E2811001" report " Test 3 : Instruction is incorrect" severity error;
        wait for period;
        
        

        tb_Offset <= "000000000000000000000010";  
        tb_nPCsel <= '1';
        WAIT FOR Period; 
        ASSERT tb_Instruction = X"EAFFFFF7" report " Test 4 : Instruction is incorrect" severity error;


        tb_Reset <= '1';
        WAIT FOR Period;
        ASSERT tb_Instruction = X"E3A01020" report " Test 5 : Instruction is incorrect" severity error;

        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE;