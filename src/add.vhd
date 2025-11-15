----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.09.2025 00:44:02
-- Design Name: 
-- Module Name: add - Behavioral
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
--use IEEE.NUMERIC_STD_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
generic(N: integer := 32);
port(
    a, b  : in  STD_LOGIC_VECTOR(N-1 downto 0);
    cin   : in  STD_LOGIC;
    sum   : out STD_LOGIC_VECTOR(N-1 downto 0);
    cout  : out STD_LOGIC
  );
end adder;

architecture Behavioral of adder is
 signal result: STD_LOGIC_VECTOR(N downto 0);
begin
 --result <= ("0" & a) + ("0" & b) + cin;
 --sum <= result(N-1 downto 0);
 --cout <= result(N);
 result <= std_logic_vector(unsigned("0" & a) + unsigned("0" & b) + unsigned'("" & cin));
 sum <= result(N-1 downto 0);
 cout <= result(N);
end Behavioral;
