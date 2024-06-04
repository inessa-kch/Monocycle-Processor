LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

---------------------------------------
ENTITY tb_VIC IS
    ---------------------------------------
END tb_VIC;


---------------------------------------
ARCHITECTURE TEST OF tb_VIC IS
    ---------------------------------------
    CONSTANT Period : TIME := 4 ns; 
    SIGNAL tb_CLK : STD_LOGIC := '0';
    SIGNAL tb_Reset : STD_LOGIC :='0';
    SIGNAL tb_IRQ_SERV: STD_LOGIC:='0';
    SIGNAL tb_IRQ0: STD_LOGIC:= '0';
    SIGNAL tb_IRQ1: STD_LOGIC:= '0';
    SIGNAL tb_IRQ: STD_LOGIC:= '0';
    SIGNAL tb_VICPC : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Done : BOOLEAN := false;
BEGIN
    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;


    -- Unit Under Test instanciation
    entity_VIC : ENTITY work.VIC
    PORT MAP(
        CLK => tb_CLK,
        Reset => tb_Reset,
        IRQ_SERV => tb_IRQ_SERV,
        IRQ0 => tb_IRQ0,
        IRQ1 => tb_IRQ1,
        IRQ => tb_IRQ,
        VICPC => tb_VICPC
    );
    
    
    -- Stimulus process
    Stimulus : PROCESS
    BEGIN
        tb_Reset <= '1';
        WAIT FOR Period;
        tb_Reset <= '0';
        

        tb_IRQ1<= '1';
        wait for Period;

        tb_IRQ0<= '1';
        wait for Period;

        tb_IRQ_SERV<= '1';
        wait for Period;







        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE;