----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.09.2025 15:16:06
-- Design Name: 
-- Module Name: MULTIPLEXER2TO1 - Behavioral
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

entity MULTIPLEXER2TO1 is
 generic(N : integer := 32);
  port(
    b       : in  STD_LOGIC_VECTOR(N-1 downto 0);  -- l'unique opérande B
    sel     : in  STD_LOGIC;                       -- 0 = addition, 1 = soustraction
    b_out   : out STD_LOGIC_VECTOR(N-1 downto 0)   -- vers l'additionneur
  );
end MULTIPLEXER2TO1;

architecture Behavioral of MULTIPLEXER2TO1 is

begin
process(b, sel)
  begin
    if sel = '0' then
      b_out <= b;          -- Addition
    else
      b_out <= not b;      -- Soustraction
    end if;
  end process;

end Behavioral;
