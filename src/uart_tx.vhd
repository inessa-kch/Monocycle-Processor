LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY UART_TX IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Go : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Tick : IN STD_LOGIC;
        Tx : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE RTL OF UART_TX IS
    TYPE StateType IS (Idle, Start_Tx, Load_Tx, Stop_Tx);
    SIGNAL state : StateType := IDLE;
    SIGNAL bit_counter : INTEGER RANGE 0 TO 9 := 0;
    SIGNAL Tx_i : STD_LOGIC := '1';
    SIGNAL Tx_Busy : STD_LOGIC;
BEGIN
    Tx <= Tx_i;
    PROCESS (Clk, Reset)
    BEGIN
        IF Reset = '1' THEN
            state <= IDLE;
            bit_counter <= 0;
            Tx_i <= '1';
            Tx_Busy <= '0';
        ELSIF rising_edge(Clk) THEN
            Tx_Busy <= '1';

            CASE state IS

                WHEN Idle =>
                    IF Go = '1' THEN
                        Tx_Busy <= '1';
                        state <= Start_Tx;
                    ELSE
                        Tx_Busy <= '0';
                    END IF;

                WHEN Start_Tx =>
                    IF Tick = '1' THEN
                        Tx_i <= '0';
                        state <= Load_Tx;
                    END IF;

                WHEN Load_Tx =>
                    IF Tick = '1' THEN
                        IF bit_counter < 8 THEN
                            Tx_i <= Data(bit_counter);
                            bit_counter <= bit_counter + 1;
                        ELSE
                            state <= Stop_Tx;
                            bit_counter <= 0;
                        END IF;
                    END IF;

                WHEN Stop_Tx =>
                    IF Tick = '1' AND Go = '0' THEN

                        Tx_i <= '1';
                        state <= Idle;
                        Tx_Busy <= '0';
                    END IF;
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE;