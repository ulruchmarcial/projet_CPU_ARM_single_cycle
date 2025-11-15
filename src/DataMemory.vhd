----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2025 12:10:48
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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

entity DataMemory is
 Port (
       CLK : in  std_logic;
      MemWrite  : in  std_logic;                        -- Write Enable
       A   : in  std_logic_vector(31 downto 0);     -- adresse 32 bits (on utilise A(5 downto 0))
       WD  : in  std_logic_vector(31 downto 0);    -- Donnée à écrire (write data)
       RD  : out std_logic_vector(31 downto 0)     -- Donnée lue (read data)
   );
end DataMemory;

architecture Behavioral of DataMemory is
    type mem_array is array(0 to 63) of std_logic_vector(31 downto 0);
    signal MEM : mem_array := (others => (others => '0'));  -- initialisation à 0
begin
 -- Lecture combinatoire
    RD <= MEM(to_integer(unsigned(A(5 downto 0))));

   -- Écriture synchrone
   process(CLK)
   begin
       if rising_edge(CLK) then
           if MemWrite = '1' then
              MEM(to_integer(unsigned(A(5 downto 0)))) <= WD;
           end if;
       end if;
   end process;

end Behavioral;
