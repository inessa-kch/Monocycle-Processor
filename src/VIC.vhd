LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

---------------------------------------
ENTITY VIC IS
    ---------------------------------------
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        IRQ_SERV: IN STD_LOGIC;
        IRQ0: IN STD_LOGIC;
        IRQ1: IN STD_LOGIC;
        IRQ: OUT STD_LOGIC;
        VICPC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END VIC;
---------------------------------------
ARCHITECTURE RTL OF VIC IS
    ---------------------------------------
signal IRQ0_memo, IRQ1_memo: STD_LOGIC:='0';
signal IRQ0_prev, IRQ1_prev: STD_LOGIC:='0';

    ---------------------------------------
BEGIN

    process(CLK, Reset)
    begin
        if Reset = '1' then
            IRQ0_memo <= '0';
            IRQ1_memo <= '0';
            IRQ0_prev <= '0';
            IRQ1_prev <= '0';
            IRQ <= '0';
            VICPC <= (OTHERS => '0');
        elsif rising_edge(CLK) then
            IRQ0_prev <= IRQ0;
            IRQ1_prev <= IRQ1;

            if (IRQ0 = '1' and IRQ0_prev = '0') then
                IRQ0_memo <= '1';
                VICPC <= X"00000009";

            elsif (IRQ1 = '1' and IRQ1_prev = '0') then
                IRQ1_memo <= '1';
                VICPC <= X"00000015";

            elsif (IRQ_SERV = '1') THEN
                IRQ0_memo <= '0';
                IRQ1_memo <= '0';    
            else
                VICPC <= (OTHERS => '0');
            end if;

            IRQ <= IRQ0_memo or IRQ1_memo;

        end if;  

    end process;
            

END RTL;



