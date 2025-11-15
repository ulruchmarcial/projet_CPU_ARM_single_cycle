----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2025 10:38:01
-- Design Name: 
-- Module Name: Extend - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Extend is
  Port (
       Instr   : in  STD_LOGIC_VECTOR(23 downto 0); -- 24 LSB de l'instruction
       ImmSrc  : in  STD_LOGIC_VECTOR(1 downto 0);  -- selecteur
       ExtImm  : out STD_LOGIC_VECTOR(31 downto 0)  -- sortie 32 bits
   );
end Extend;

architecture Behavioral of Extend is

begin
 process(Instr, ImmSrc)
   begin
       case ImmSrc is
           when "00" => -- Imm8
               ExtImm <= (31 downto 8 => '0') & Instr(7 downto 0);
           when "01" => -- Imm12
               ExtImm <= (31 downto 12 => '0') & Instr(11 downto 0);
           when "10" => -- Imm24
               ExtImm <= (31 downto 24 => '0') & Instr(23 downto 0);
           when others =>
               ExtImm <= (others => '0'); -- sécurité
       end case;
   end process;

end Behavioral;
