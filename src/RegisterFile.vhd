----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2025 23:57:14
-- Design Name: 
-- Module Name: RegisterFile - Behavioral
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

entity RegisterFile is
Port (
        clk      : in  std_logic;
        RegWrite : in  std_logic;
        RA1      : in  std_logic_vector(3 downto 0);
        RA2      : in  std_logic_vector(3 downto 0);
        A3       : in  std_logic_vector(3 downto 0);
        WD3      : in  std_logic_vector(31 downto 0);
        R15      : in  std_logic_vector(31 downto 0); -- pas utilisé pour l'instant
        RD1      : out std_logic_vector(31 downto 0);
        RD2      : out std_logic_vector(31 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
-- 16 registres de 32 bits initialisés à 0
    type reg_array is array (15 downto 0) of std_logic_vector(31 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin

     -- Lecture asynchrone
        RD1 <= regs(to_integer(unsigned(RA1)));
        RD2 <= regs(to_integer(unsigned(RA2)));

    -- Écriture synchrone
    process(clk)
    begin
        if rising_edge(clk) then
            if RegWrite = '1' then
                regs(to_integer(unsigned(A3))) <= WD3;
            end if;
        end if;
    end process;
    
   

end Behavioral;
