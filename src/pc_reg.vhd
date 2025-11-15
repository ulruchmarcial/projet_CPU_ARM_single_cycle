----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 17:52:59
-- Design Name: 
-- Module Name: pc_reg - Behavioral
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

entity pc_reg is
  port (
  clk   : in  std_logic;
  arst  : in  std_logic;                    -- reset asynchrone actif haut
  PCNext: in  std_logic_vector(31 downto 0);-- prochaine adresse (PC+4 ou branchement)
  PC    : out std_logic_vector(31 downto 0) -- adresse courante
);
end pc_reg;

architecture Behavioral of pc_reg is
  signal PC_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
process(clk, arst)
  begin
  --  Reset asynchrone : priorité au reset
    if arst = '1' then
      PC_reg <= (others => '0');
   --  Sinon, mise à jour sur front montant
    elsif rising_edge(clk) then
      PC_reg <= PCNext;
    end if;
  end process;
  PC <= PC_reg;

end Behavioral;
