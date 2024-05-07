LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
-----------------------------------------
ENTITY Unite_de_Traitement IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        RegWr : IN STD_LOGIC;
        RA : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Imm : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        COM : IN STD_LOGIC;
        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        N : OUT
        C : OUT
        Z : OUT
        V : OUT
        WrEn : IN STD_LOGIC
    );
END ENTITY Unite_de_Traitement;
---------------------------------------
ARCHITECTURE RTL OF Unite_de_Traitement IS
    ---------------------------------------
    SIGNAL busA
    SIGNAL busB
    SIGNAL busW
    SIGNAL ALUout

    SIGNAL DataOut
    SIGNAL S_extension
    SIGNAL S_mux1
BEGIN

    entity_Banc_Registres : ENTITY work.Banc_Registres
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            W => busW,
            RA => RA,
            RB => RB,
            RW => RW,
            WE => RegWr,
            A => busA,
            B => busB
        );

    entity_extension : ENTITY work.Extension GENERIC MAP(N => 8)
        PORT MAP(
            E => Imm,
            S => S_extension
        );

    entity_mux1 : ENTITY work.Mux2v1 GENERIC MAP(N => 32)
        PORT MAP(
            A => BusB,
            B => S_extension,
            COM => COM,
            S => S_mux1
        );

    entity_ALU : ENTITY work.ALU
        PORT MAP(
            OP => OP,
            A => busA,
            B => S_mux1,
            S => ALUout,
            N => N,
            Z => Z,
            C => C,
            V => V
        );

    entity_Memory : ENTITY work.Memoire_Data
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            DataIn => busB,
            DataOut => DataOut,
            Addr => ALUout(5 DOWNTO 0),
            WrEn => WrEn
        );
    entity_mux2 : ENTITY work.Mux2v1 GENERIC MAP(N => 32)
        PORT MAP(
            A => ALUout,
            B => DataOut,
            COM => COM,
            S => busW
        );

END ARCHITECTURE;