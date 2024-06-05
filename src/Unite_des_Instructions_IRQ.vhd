LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-----------------------------------------
ENTITY Unite_des_Instructions_IRQ IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        IRQ: IN STD_LOGIC;
        VICPC: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        IRQ_END: IN STD_LOGIC;
        Instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Offset : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        nPCsel : IN STD_LOGIC;
        IRQ_SERV: OUT STD_LOGIC
    );
END ENTITY Unite_des_Instructions_IRQ;

---------------------------------------
ARCHITECTURE RTL OF Unite_des_Instructions_IRQ IS
    ---------------------------------------
    SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL int1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL int2 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL OffsetExt : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL LR : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    --SIGNAL IRQ_SERV: STD_LOGIC
    constant OffsetSize : integer := 24;
BEGIN

    int1 <= STD_LOGIC_VECTOR(unsigned(PC) + 1);
    int2 <= STD_LOGIC_VECTOR(unsigned(PC) + 1 + unsigned(OffsetExt));

    entity_extension : ENTITY work.Extension GENERIC MAP(N => OffsetSize)
        PORT MAP (
            E => Offset,
            S => OffsetExt
        );

    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            PC <= (OTHERS => '0');
            LR <= (OTHERS => '0');
            IRQ_SERV <= '0';
        ELSIF rising_edge(CLK) THEN
            IF IRQ = '1' and PC < X"00000009" THEN
                IF nPCsel = '0' then
                    LR <= STD_LOGIC_VECTOR(unsigned(PC) + 1);
                else
                    LR <= STD_LOGIC_VECTOR(unsigned(PC) + 1 + unsigned(OffsetExt));
                end if;
                PC <= VICPC;
                IRQ_SERV <= '1';
            ELSIF IRQ_END = '1' THEN
                PC <= LR;
                IRQ_SERV <= '0';
            ELSE
                IF nPCsel = '0' THEN
                    PC <= int1;
                ELSE
                    PC <= int2;
                END IF;
                IRQ_SERV <= '0';
            END IF;
        END IF;
    END PROCESS;

    entity_instruction : ENTITY work.Memoire_Instruction_IRQ
        PORT MAP (
            PC => PC,
            Instruction => Instruction
        );

END ARCHITECTURE;

