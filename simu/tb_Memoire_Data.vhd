LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY tb_Memoire_Data IS
    ---------------------------------------
END ENTITY;

---------------------------------------
ARCHITECTURE TEST OF tb_Memoire_Data IS
    ---------------------------------------

    CONSTANT Period : TIME := 10 us; -- speed up simulation with a 100kHz clock

    -- Signal declarations
    SIGNAL tb_CLK : STD_LOGIC:='0';
    SIGNAL tb_Reset : STD_LOGIC:='0';
    SIGNAL tb_DataIn : STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
    SIGNAL tb_DataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL tb_Addr : STD_LOGIC_VECTOR(5 DOWNTO 0):=(OTHERS=>'0');
    SIGNAL tb_WrEn : STD_LOGIC:='0';
    SIGNAL Done : BOOLEAN := false;

BEGIN

    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;
    tb_Reset <= '1', '0' AFTER Period;
    -- Unit Under Test instanciation
    entity_memory : ENTITY work.Memoire_Data
        PORT MAP(
            CLK => tb_CLK,
            Reset => tb_Reset,
            DataIn => tb_DataIn,
            DataOut => tb_DataOut,
            Addr => tb_Addr,
            WrEn => tb_WrEn
        );

    PROCESS BEGIN
        WAIT FOR Period;

        tb_Addr <= "111110";
        tb_WrEn <= '1';
        tb_DataIn <= x"11001100";
        WAIT FOR Period;
        ASSERT tb_DataOut = tb_DataIn REPORT "Test 1 failed: register DataOut should be equal to 0x11001100" SEVERITY WARNING;
        
        
        tb_WrEn <= '0';
        tb_Addr <= "000010";
        WAIT FOR Period;
        ASSERT tb_DataOut = x"00000000" REPORT "Test 2 failed: register DataOut should be equal to 0x00000000" SEVERITY WARNING;

        tb_Addr <= "111110";
        tb_WrEn <= '1';
        tb_DataIn <= x"11111100";
        WAIT FOR Period;
        ASSERT tb_DataOut = tb_DataIn REPORT "Test 3 failed: register DataOut should be equal to 0x11111100" SEVERITY WARNING;

        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE;