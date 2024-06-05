LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


-----------------------------------------
ENTITY tb_Processeur IS
    ---------------------------------------
END ENTITY tb_Processeur;
---------------------------------------
ARCHITECTURE TEST OF tb_Processeur IS
    ---------------------------------------
CONSTANT Period : TIME := 4 ns; 
signal tb_CLK : STD_LOGIC:='0';
signal tb_Reset : STD_LOGIC:='0';
signal tb_IRQ0 : STD_LOGIC:='0';
signal tb_IRQ1 : STD_LOGIC:='0';
signal tb_Afficheur : STD_LOGIC_VECTOR(31 DOWNTO 0):=(others=>'0');
SIGNAL Done : BOOLEAN := false;
BEGIN
    -- System Inputs
tb_CLK <= '0' WHEN Done ELSE
NOT tb_CLK AFTER Period / 2;


-- Unit Under Test instanciation
entity_processeur: entity work.Processeur
port map(
    CLK => tb_CLK,
    Reset => tb_Reset,
    IRQ0 => tb_IRQ0,
    IRQ1 => tb_IRQ1,
    Afficheur => tb_Afficheur
);

PROCESS
BEGIN

    tb_Reset <= '1';
    WAIT FOR Period;
    tb_Reset <= '0';

    tb_IRQ0 <= '1';


    wait for 700*Period;


    REPORT "End of test. Verify that no error was reported.";
    Done <= true;
    WAIT;
END PROCESS;

   


END ARCHITECTURE;