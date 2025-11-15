----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 19:56:58
-- Design Name: 
-- Module Name: adder_end_2 - Behavioral
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

entity adder_end_second is
port(
    a, b : in  std_logic_vector(31 downto 0);
    y    : out std_logic_vector(31 downto 0)
  );
end adder_end_second;

architecture Behavioral of adder_end_second is

begin
--y <= a + b ;
y <= std_logic_vector(unsigned(a) + unsigned(b));

end Behavioral;
