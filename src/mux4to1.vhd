----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.09.2025 14:27:52
-- Design Name: 
-- Module Name: mux4to1 - Behavioral
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

entity mux4to1 is

generic(N : integer := 32);
  port(
    d0, d1, d2, d3 : in  STD_LOGIC_VECTOR(N-1 downto 0);
    sel            : in  STD_LOGIC_VECTOR(1 downto 0);
    y              : out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end mux4to1;

architecture Behavioral of mux4to1 is

begin
process(d0, d1, d2, d3, sel)
  begin
    case sel is
      when "00" => y <= d0;   -- ADD
      when "01" => y <= d1;   -- SUB
      when "10" => y <= d2;   -- AND
      when "11" => y <= d3;   -- OR
      when others => y <= (others => '0');
    end case;
 end process;

end Behavioral;
