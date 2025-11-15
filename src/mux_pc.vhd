----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 19:36:21
-- Design Name: 
-- Module Name: mux_pc - Behavioral
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

entity mux_pc is
 port (
   PCSrc   : in  std_logic;
   PCPlus4 : in  std_logic_vector(31 downto 0);
   PCPlus8: in  std_logic_vector(31 downto 0);
   PCNext  : out std_logic_vector(31 downto 0)
 );
end mux_pc;

architecture Behavioral of mux_pc is

begin

PCNext <= PCPlus8 when PCSrc = '1' else PCPlus4;

end Behavioral;
