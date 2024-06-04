LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

---------------------------------------
ENTITY Decodeur IS
    ---------------------------------------
    PORT (
        Instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        EtatPSR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nPCSel : OUT STD_LOGIC;
        PSREn : OUT STD_LOGIC;
        Imm24 : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
        Imm8 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        RegWr : OUT STD_LOGIC;
        RegSel : OUT STD_LOGIC;
        ALUCtrl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALUSrc : OUT STD_LOGIC;
        WrSrc : OUT STD_LOGIC;
        MemWr : OUT STD_LOGIC;
        RegAff : OUT STD_LOGIC;
        IRQ_END : OUT STD_LOGIC
    );
END Decodeur;
---------------------------------------
ARCHITECTURE RTL OF Decodeur IS
    ---------------------------------------

    TYPE enum_instruction IS (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, BX);
    SIGNAL instr_courante : enum_instruction;

BEGIN
    Imm8 <= instruction(7 DOWNTO 0);
    Imm24 <= instruction(23 DOWNTO 0);



    PROCESS (Instruction)
    BEGIN
        IF (Instruction(31 DOWNTO 28) = "1110") THEN
            IF (Instruction(27 DOWNTO 26) = "00") THEN
                IF (Instruction(24 DOWNTO 21) = "1101") THEN
                    instr_courante <= MOV;
                ELSIF (Instruction(24 DOWNTO 21) = "0100") THEN
                    IF Instruction(25) = '1' THEN
                        instr_courante <= ADDi;
                    ELSE
                        instr_courante <= ADDr;
                    END IF;
                ELSIF (Instruction(24 DOWNTO 21) = "1010") THEN
                    instr_courante <= CMP;
                END IF;
            ELSIF (Instruction(27 DOWNTO 26) = "01") THEN
                IF (Instruction(20) = '1') THEN
                    instr_courante <= LDR;
                ELSE
                    instr_courante <= STR;
                END IF;
            ELSIF (Instruction(27 DOWNTO 24) = "1010") THEN
                instr_courante <= BAL;
            ELSIF (Instruction(27 DOWNTO 24) = "1011") THEN
                instr_courante <= BX;
            END IF;
        ELSIF (Instruction(31 DOWNTO 24) = "10111010") THEN
            instr_courante <= BLT;
        END IF;
    END PROCESS;

        --sorties du decodeur
        PROCESS (instruction, instr_courante, EtatPSR)
        BEGIN
            CASE (instr_courante) IS
                WHEN MOV =>
                    nPCSel <= '0';
                    PSREn <= '0';
                    --Rd <= instruction(15 DOWNTO 12);
                    --Imm8 <= instruction(7 DOWNTO 0);
                    RegWr <= '1';
                    ALUCtrl <= "001";
                    ALUSrc <= '1';
                    WrSrc <= '0';
                    MemWr <= '0';
                    RegAff <= '0';

                WHEN ADDi =>
                    nPCSel <= '0';
                    PSREn <= '0';
                    --Rn <= instruction(19 DOWNTO 16);
                    --Rd <= instruction(15 DOWNTO 12);
                    --Imm8 <= instruction(7 DOWNTO 0);
                    RegWr <= '1';
                    ALUCtrl <= "000";
                    ALUSrc <= '1';
                    WrSrc <= '0';
                    MemWr <= '0';
                    RegAff <= '0';

                WHEN ADDr =>
                    nPCSel <= '0';
                    PSREn <= '0';
                    --Rn <= instruction(19 DOWNTO 16);
                    --Rd <= instruction(15 DOWNTO 12);
                    --Rm <= instruction(3 DOWNTO 0);
                    RegWr <= '1';
                    RegSel <= '0';
                    ALUCtrl <= "000";
                    ALUSrc <= '0';
                    WrSrc <= '0';
                    MemWr <= '0';
                    RegAff <= '0';

                WHEN CMP =>
                    nPCSel <= '0';
                    PSREn <= '1';
                    --Rn <= instruction(19 DOWNTO 16);
                    --Imm8 <= instruction(7 DOWNTO 0);
                    RegWr <= '0';
                    ALUCtrl <= "010";
                    ALUSrc <= '1';
                    MemWr <= '0';
                    RegAff <= '0';

                WHEN LDR =>
                    nPCSel <= '0';
                    PSREn <= '0';
                    --Rn <= instruction(19 DOWNTO 16);
                    --Rd <= instruction(15 DOWNTO 12);
                    RegWr <= '1';
                    ALUCtrl <= "000";
                    ALUSrc <= '1';
                    WrSrc <= '1';
                    MemWr <= '0';
                    RegAff <= '0';

                WHEN STR =>
                    nPCSel <= '0';
                    PSREn <= '0';
                    --Rn <= instruction(19 DOWNTO 16);
                    --Rd <= instruction(15 DOWNTO 12);
                    RegWr <= '0';
                    RegSel <= '1';
                    ALUCtrl <= "000";
                    ALUSrc <= '1';
                    MemWr <= '1';
                    RegAff <= '1';

                WHEN BAL =>
                    nPCSel <= '1';
                    PSREn <= '0';
                    RegWr <= '0';
                    MemWr <= '0';
                    RegAff <= '0';
                    --Imm24 <= instruction(23 DOWNTO 0);

                WHEN BLT =>
                    IF EtatPSR(31) = '1' THEN
                        nPCSel <= '1';
                        --Imm24 <= instruction(23 DOWNTO 0);
                    ELSE
                        nPCSel <= '0';
                    END IF;
                    PSREn <= '0';
                    RegWr <= '0';
                    MemWr <= '0';
                    RegAff <= '0';


                WHEN BX =>
                    IRQ_END <= '1';    

                WHEN OTHERS =>
                    nPCSel <= '0';
                    PSREn <= '0';
                    --Rn <= "0000";
                    --Rd <= "0000";
                    --Rm <= "0000";
                    --Imm24 <= (OTHERS => '0');
                    --Imm8 <= (OTHERS => '0');
                    RegWr <= '0';
                    RegSel <= '0';
                    ALUCtrl <= "000";
                    ALUSrc <= '0';
                    WrSrc <= '0';
                    MemWr <= '0';
                    RegAff <= '0';
            END CASE;
        END PROCESS;
END RTL;