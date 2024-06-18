LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY tb_Unite_de_Traitement IS
    ---------------------------------------
END ENTITY;


---------------------------------------
ARCHITECTURE TEST OF tb_Unite_de_Traitement IS
    ---------------------------------------
    CONSTANT Period : TIME := 4 ns; -- speed up simulation with a 100kHz clock
    SIGNAL tb_CLK : STD_LOGIC := '0';
    SIGNAL tb_Reset : STD_LOGIC := '0';
    SIGNAL tb_RegWr : STD_LOGIC := '0'; --write-enable input connected to the register bank
    SIGNAL tb_WrEn : STD_LOGIC := '0'; --write-enable input connected to the data memory
    SIGNAL tb_RA : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_RB : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_RW : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_Imm : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_COM1 : STD_LOGIC := '0';
    SIGNAL tb_COM2 : STD_LOGIC := '0';
    SIGNAL tb_OP : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tb_N : STD_LOGIC;
    SIGNAL tb_C : STD_LOGIC;
    SIGNAL tb_Z : STD_LOGIC;
    SIGNAL tb_V : STD_LOGIC;
    SIGNAL Done : BOOLEAN := false;
BEGIN
    -- System Inputs
    tb_CLK <= '0' WHEN Done ELSE
        NOT tb_CLK AFTER Period / 2;
    tb_Reset <= '1', '0' AFTER Period/4;

    -- Unit Under Test instanciation
    entity_UDT : ENTITY work.Unite_de_Traitement
        PORT MAP(
            CLK => tb_CLK,
            Reset => tb_Reset,
            RegWr => tb_RegWr,
            WrEn => tb_WrEn,
            RA => tb_RA,
            RB => tb_RB,
            RW => tb_RW,
            Imm => tb_Imm,
            COM1 => tb_COM1,
            COM2 => tb_COM2,
            OP => tb_OP,
            N => tb_N,
            Z => tb_Z,
            V => tb_V,
            C => tb_C
        );
    PROCESS
    BEGIN
        --L’addition de 2 registres
        tb_RA <= "1111";
        tb_RB <= "0000";
        tb_COM1 <= '0';
        tb_OP <= "000";
        tb_COM2 <= '0';
        WAIT FOR Period/4;

        assert tb_N = '0' report "N is incorrect after addition of two registers" severity error;

        tb_RW <= "0000";
        tb_RegWr <= '1';
        Wait for Period;
        tb_RegWr<='0';
        WAIT FOR Period/4; --on a écrit l'addition1=0x00000030 dans R(0)

        --L'addition d’1 registre avec une valeur immédiate
        tb_RA <=  "1111";
        tb_Imm <= "11000000"; -- 0xFFFFFFC0 + 0x00000030
        tb_COM1 <= '1';
        tb_OP <= "000";
        tb_COM2 <= '0';
        WAIT FOR Period/4;

        assert tb_N = '1' report "N is incorrect after addition of register and immediate value" severity error;

        tb_RW<="0001";
        tb_RegWr <= '1';
        Wait for Period;
        tb_RegWr<='0';
        WAIT FOR Period/4; --on a écrit l'addition2=0xFFFFFFF0 dans R(1)

        -- La soustraction de 2 registres
        tb_RA <= "0000"; --0x00000030
        tb_RB <= "0001"; --0xFFFFFFF0
        tb_COM1 <= '0';
        tb_OP <= "010";
        tb_COM2 <= '0';
        WAIT FOR Period/4;

        assert tb_N = '0' report "N is incorrect after substraction of registers" severity error;
        
        tb_RW<="0010";
        tb_RegWr <= '1';
        Wait for Period;
        tb_RegWr<='0';
        WAIT FOR Period/4; --on a écrit la soustraction1=0x00000040 dans R(2)


        --La soustraction d’1 valeur immédiate à 1 registre
        tb_RA <= "1111"; -- 0x00000030
        tb_Imm <= "00010000"; -- 0x00000010
        tb_COM1 <= '1';
        tb_OP <= "010";
        tb_COM2 <= '0';
        WAIT FOR Period/4;

        assert tb_N = '0' report "N is incorrect after substraction of register and immediate value" severity error;
        --assert tb_Z = '1' report "Z is incorrect after substraction of register and immediate value" severity error;


        tb_RW <= "0011";
        tb_RegWr <= '1';
        Wait for Period;
        tb_RegWr<='0';
        WAIT FOR Period/4; --on a écrit la soustraction2=0x00000020 dans R(3)
        
        --La copie de la valeur d’un registre dans un autre registre
        tb_RA <= "0001";
        tb_OP <= "011";
        tb_COM2 <= '0';
        WAIT FOR Period/4;

        assert tb_N = '1' report "N is incorrect after copying a register value" severity error;

        tb_RW <= "0100";
        tb_RegWr <= '1';
        Wait for Period;
        tb_RegWr<='0';
        WAIT FOR Period/4; --on a copié la valeur  de R(1) 0xFFFFFFF0 dans R(4)


        --L’écriture d’un registre dans un mot de la mémoire.    
        tb_RB <= "0010";
        tb_OP <= "001";
        WAIT FOR Period/4;
        assert tb_N = '0' report "N is incorrect after writing a register value into data memory" severity error;

        tb_WrEn <= '1';
        WAIT FOR Period;
        tb_WrEn <='0';
        WAIT FOR Period/4; --on a copié la valeur  de R(2) 0x00000040 à l'addresse 32 du data memory

        --La lecture d’un mot de la mémoire dans un registre.
        tb_RB <= "0010"; --0x00000040
        tb_OP <= "001";
        tb_COM2 <= '1';
        WAIT FOR Period/4;

        tb_RW <= "0101";
        tb_RegWr <= '1';
        WAIT FOR Period;
        tb_RegWr <= '0';
        WAIT FOR Period/4; --on a écrit la valeur 0x00000040 de l'addresse 32 du data memory dans R(5)


        REPORT "End of test. Verify that no error was reported.";
        Done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE;

