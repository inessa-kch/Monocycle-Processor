LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY tb_Unite_des_Instructions_IRQ IS
    ---------------------------------------
END ENTITY;


---------------------------------------
ARCHITECTURE TEST OF tb_Unite_des_Instructions_IRQ IS
    ---------------------------------------
    CONSTANT Period : TIME := 4 ns; 
    SIGNAL tb_CLK : STD_LOGIC := '0';
    SIGNAL tb_Reset : STD_LOGIC :='0';
    SIGNAL tb_IRQ : STD_LOGIC := '0';
    SIGNAL tb_VICPC : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_IRQ_END : STD_LOGIC := '0';
    SIGNAL tb_Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_Offset : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_nPCsel : STD_LOGIC := '0';
    SIGNAL tb_IRQ_SERV : STD_LOGIC := '0';   
    SIGNAL Done : BOOLEAN := false;

BEGIN
    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;

    -- Unit Under Test instanciation
    entity_UDI : ENTITY work.Unite_des_Instructions_IRQ
        PORT MAP(
            CLK=> tb_CLK,
            Reset => tb_Reset,
            IRQ => tb_IRQ,
            VICPC => tb_VICPC,
            IRQ_END => tb_IRQ_END,
            Instruction => tb_Instruction,
            Offset => tb_Offset,
            nPCsel => tb_nPCsel,
            IRQ_SERV => tb_IRQ_SERV
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
        
        


        tb_IRQ <= '1';
        tb_VICPC <= x"00000009";
        wait for Period;

        tb_IRQ <= '0';

        wait for 3*Period;


        tb_IRQ_END<= '1';
        wait for Period;


        tb_IRQ_END<= '0';
        wait for 3*Period;

        tb_IRQ<= '1';
        tb_VICPC <= x"00000015";
        wait for Period;

        tb_IRQ<= '0';
        wait for 3*Period;

        tb_IRQ_END<= '1';
        wait for Period;

        tb_IRQ_END<= '0';
        wait for 3*Period;

        

        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE;