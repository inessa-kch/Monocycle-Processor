LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

---------------------------------------
ENTITY ALU IS
  ---------------------------------------
  PORT (
    OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    N, Z, C, V : OUT STD_LOGIC := '0');
END ENTITY ALU;
---------------------------------------
ARCHITECTURE BEHAVIORAL OF ALU IS
  ---------------------------------------
  SIGNAL temp_sum_pos : STD_LOGIC_VECTOR(32 DOWNTO 0);
  --SIGNAL temp_sum_neg : STD_LOGIC_VECTOR(32 DOWNTO 0);
  SIGNAL Output : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
  PROCESS (OP, A, B)
  BEGIN
    CASE OP IS
      WHEN "000" => Output <= STD_LOGIC_VECTOR(signed(A) + signed(B));
      WHEN "001" => Output <= B;
      WHEN "010" => Output <= STD_LOGIC_VECTOR(signed(A) - signed(B));
      WHEN "011" => Output <= A;
      WHEN "100" => Output <= A OR B;
      WHEN "101" => Output <= A AND B;
      WHEN "110" => Output <= A XOR B;
      WHEN "111" => Output <= NOT A;
      WHEN OTHERS => Output <= (OTHERS => '-');
    END CASE;
  END PROCESS;

  --Flags

  temp_sum_pos <= STD_LOGIC_VECTOR(('0' & signed(A)) + ('0' & signed(B)));
  --temp_sum_neg <= STD_LOGIC_VECTOR(('0' & unsigned(A)) - ('0' & unsigned(B)));
  N <= '1' WHEN (Output(31) = '1') ELSE '0';
  Z <= '1' WHEN (Output = (31 DOWNTO 0 => '0')) ELSE '0';
  C <= '1' WHEN ((temp_sum_pos(32) = '1' AND OP = "000") OR (A > B AND OP = "010")) ELSE '0';
  V <= '1' WHEN ((((A(31) = '1' AND B(31) = '1' AND Output(31) = '0') OR (A(31) = '0' AND B(31) = '0' AND Output(31) = '1')) AND OP = "000") OR
    (((A(31) = '1' AND B(31) = '0' AND Output(31) = '0') OR (A(31) = '0' AND B(31) = '1' AND Output(31) = '1')) AND OP = "010")) ELSE '0';

  S <= Output;
END ARCHITECTURE;