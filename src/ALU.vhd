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
    N, Z, C, V : OUT STD_LOGIC);
END ENTITY ALU;
---------------------------------------
ARCHITECTURE RTL OF ALU IS
  ---------------------------------------
  SIGNAL temp_sum_pos : STD_LOGIC_VECTOR(32 DOWNTO 0);
  SIGNAL temp_sum_neg : STD_LOGIC_VECTOR(32 DOWNTO 0);

PROCESS(OP, A, B) IS 
BEGIN
    CASE OP IS
      WHEN "000" => S <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));
      WHEN "001" => S <= B;
      WHEN "010" => S <= STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));
      WHEN "011" => S <= A;
      WHEN "100" => S <= A OR B;
      WHEN "101" => S <= A AND B;
      WHEN "110" => S <= A XOR B;
      WHEN "111" => S <= NOT(A);
      WHEN OTHERS => S <= (OTHERS => '-');
    END CASE;

    --Flags
    temp_sum_pos <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));
    temp_sum_neg <= STD_LOGIC_VECTOR(unsigned(A) - unsigned(B));
    N <= S(31);
    Z <= '1' WHEN S = (OTHERS => '0') ELSE
      '0';
    C <= temp_sum_pos(32) OR temp_sum_neg(32);
    V <= '1' WHEN ((A(31) = '1' AND B(31) = '1' AND S(31) = '0') OR (A(31) = '0' AND B(31) = '0' AND S(31) = '1')) ELSE
      '0';
  END PROCESS;
END ARCHITECTURE;


