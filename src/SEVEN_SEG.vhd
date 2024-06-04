-- SevenSeg.vhd
-- ------------------------------
--   squelette de l'encodeur sept segment
-- ------------------------------

--
-- Notes :
--  * We don't ask for an hexadecimal decoder, only 0..9
--  * outputs are active high if Pol='1'
--    else active low (Pol='0')
--  * Order is : Segout(1)=Seg_A, ... Segout(7)=Seg_G
--
--  * Display Layout :
--
--       A=Seg(1)
--      -----
--    F|     |B=Seg(2)
--     |  G  |
--      -----
--     |     |C=Seg(3)
--    E|     |
--      -----
--        D=Seg(4)
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- ------------------------------
ENTITY SEVEN_SEG IS
  -- ------------------------------
  PORT (
    Data : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Expected within 0 .. 9
    Pol : IN STD_LOGIC; -- '0' if active LOW
    Segout : OUT STD_LOGIC_VECTOR(1 TO 7)); -- Segments A, B, C, D, E, F, G
END ENTITY SEVEN_SEG;

-- -----------------------------------------------
ARCHITECTURE COMB OF SEVEN_SEG IS
  -- ------------------------------------------------
  SIGNAL sevseg : STD_LOGIC_VECTOR(1 TO 7);
BEGIN

  PROCESS (Data, Pol, sevseg) IS
  BEGIN
    CASE(Data) IS
      WHEN x"0" => sevseg <= "1111110";
      WHEN x"1" => sevseg <= "0110000";
      WHEN x"2" => sevseg <= "1101101";
      WHEN x"3" => sevseg <= "1111001";
      WHEN x"4" => sevseg <= "0110011";
      WHEN x"5" => sevseg <= "1011011";
      WHEN x"6" => sevseg <= "1011111";
      WHEN x"7" => sevseg <= "1110000";
      WHEN x"8" => sevseg <= "1111111";
      WHEN x"9" => sevseg <= "1111011";
      WHEN x"A" => sevseg <= "1110111";
      WHEN x"B" => sevseg <= "0011111";
      WHEN x"C" => sevseg <= "1001110";
      WHEN x"D" => sevseg <= "0111101";
      WHEN x"E" => sevseg <= "1001111";
      WHEN x"F" => sevseg <= "1000111";
      WHEN OTHERS => sevseg <= (OTHERS => '-');
    END CASE;

    IF (Pol = '1') THEN
      Segout <= sevseg;
    ELSE
      Segout <= NOT(sevseg);
    END IF;
  END PROCESS;
END ARCHITECTURE COMB;