----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 17:11:07
-- Design Name: 
-- Module Name: condition_check - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity condition_check is
port (
    Cond   : in  std_logic_vector(3 downto 0); -- bits 31:28 de l'instruction
    Flags  : in  std_logic_vector(3 downto 0); -- N,Z,C,V (ordre = 3,2,1,0)
    CondEx : out std_logic                    -- 1 = instruction exécutée
  );
end condition_check;

architecture Behavioral of condition_check is
signal N, Z, C, V : std_logic;
begin
  N <= Flags(3);
  Z <= Flags(2);
  C <= Flags(1);
  V <= Flags(0);

  process (Cond, N, Z, C, V)
  begin
    case Cond is
      when "0000" => CondEx <= Z;                        -- EQ
      when "0001" => CondEx <= not Z;                    -- NE
      when "0010" => CondEx <= C;                        -- CS/HS
      when "0011" => CondEx <= not C;                    -- CC/LO
      when "0100" => CondEx <= N;                        -- MI
      when "0101" => CondEx <= not N;                    -- PL
      when "0110" => CondEx <= V;                        -- VS
      when "0111" => CondEx <= not V;                    -- VC
      when "1000" => CondEx <= (C and (not Z));          -- HI
      when "1001" => CondEx <= ((not C) or Z);           -- LS
      when "1010" => CondEx <= (N xnor V);               -- GE
      when "1011" => CondEx <= (N xor  V);               -- LT
      when "1100" => CondEx <= ((not Z) and (N xnor V)); -- GT
      when "1101" => CondEx <= (Z or (N xor V));         -- LE
      when "1110" => CondEx <= '1';                      -- AL (always)
      when others => CondEx <= '0';                      -- undefined => never
    end case;
  end process;

end Behavioral;
