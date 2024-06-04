LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


-----------------------------------------
ENTITY Processeur IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Afficheur : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Processeur;
---------------------------------------
ARCHITECTURE RTL OF Processeur IS
    ---------------------------------------
--signaux intern 
signal Instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal EtatPSR_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal EtatPSR_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal nPCSel : STD_LOGIC;
signal PSREn : STD_LOGIC;
signal RegWr : STD_LOGIC;
signal RegSel : STD_LOGIC;
signal ALUCtrl : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal ALUSrc : STD_LOGIC;
signal WrSrc : STD_LOGIC;
signal MemWr : STD_LOGIC;
signal RegAff : STD_LOGIC;
signal RW, RA, RB: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal Imm24 : STD_LOGIC_VECTOR(23 DOWNTO 0);
signal Imm8 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

RW<=Instruction(15 downto 12);
RA<=Instruction(19 downto 16);
RB<=Instruction(3 downto 0);

entity_udt: entity work.Unite_de_Traitement
    port map(
        CLK => CLK,
        Reset => Reset,
        RegWr => RegWr,
        WrEn => MemWr,
        RA => RA,
        RB => RB,
        RW => RW,
        Imm => Imm8,
        COM1 => ALUSrc,
        COM2 => WrSrc,
        OP => ALUCtrl,
        N => EtatPSR_in(31),
        C => EtatPSR_in(30),
        Z => EtatPSR_in(29),
        V => EtatPSR_in(28),
        Afficheur => Afficheur,
        RegAff => RegAff,
        RegSel => RegSel
    );


entity_udi: entity work.Unite_des_Instructions
    port map(
        CLK => CLK,
        Reset => Reset,
        Instruction => Instruction,
        Offset => Imm24,
        nPCSel => nPCSel
    );


entity_decodeur: entity work.Decodeur
    port map(
        Instruction => Instruction,
        EtatPSR => EtatPSR_out,
        nPCSel => nPCSel,
        PSREn => PSREn,
        Imm24 => Imm24,
        Imm8 => Imm8,
        RegWr => RegWr,
        RegSel => RegSel,
        ALUCtrl => ALUCtrl,
        ALUSrc => ALUSrc,
        WrSrc => WrSrc,
        MemWr => MemWr,
        RegAff => RegAff
    );

 

entity_psr : entity work.Registre
    port map(
        CLK => CLK,
        Reset => Reset,
        DATAIN =>EtatPSR_in,
        WE=> PSREn,
        DATAOUT => EtatPSR_out
    );    


END ARCHITECTURE;
