----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 16:43:38
-- Design Name: 
-- Module Name: flags_reg_vec - Behavioral
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

entity flags_reg_vec is
port (
    clk      : in  std_logic;
    arst     : in  std_logic; -- async reset, active high (1 => reset)
    FlagW    : in  std_logic_vector(1 downto 0); -- from decoder
    CondEx   : in  std_logic; -- from condition check
    Flags_in : in  std_logic_vector(3 downto 0); -- [3]=N, [2]=Z, [1]=C, [0]=V
    Flags_out: out std_logic_vector(3 downto 0)
  );
end flags_reg_vec;

architecture Behavioral of flags_reg_vec is
 signal flags_reg : std_logic_vector(3 downto 0);
begin
process(clk, arst)
  begin
    
    if arst = '1' then
        flags_reg <= (others => '0');
  
      elsif rising_edge(clk) then
        if CondEx = '1' then
          -- Mise à jour de N et Z si FlagW(1) = 1
          if FlagW(1) = '1' then
            flags_reg(3) <= Flags_in(3); -- N
            flags_reg(2) <= Flags_in(2); -- Z
          end if;
  
          -- Mise à jour de C et V si FlagW(0) = 1
          if FlagW(0) = '1' then
            flags_reg(1) <= Flags_in(1); -- C
            flags_reg(0) <= Flags_in(0); -- V
          end if;
        end if;
      end if;
    end process;
  
    Flags_out <= flags_reg;


end Behavioral;
