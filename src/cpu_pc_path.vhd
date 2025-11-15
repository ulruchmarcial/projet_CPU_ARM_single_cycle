----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 19:52:26
-- Design Name: 
-- Module Name: cpu_pc_path - Behavioral
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

entity cpu_pc_path is
 port (
   clk, arst  : in  std_logic;
   PCSrc      : in  std_logic;
   ExtImm     : in  std_logic_vector(31 downto 0);
   Instruction: out std_logic_vector(31 downto 0)
 );
end cpu_pc_path;

architecture Behavioral of cpu_pc_path is
signal PC, PCPlus4, PCBranch, PCNext : std_logic_vector(31 downto 0);
begin
 -- ===== Registre PC =====
 U_PC : entity work.pc_reg
   port map (
     clk    => clk,
     arst   => arst,
     PCNext => PCNext,
     PC     => PC
   );

 -- ===== Mémoire d'instruction =====
 U_IMEM : entity work.instruction_memory
   port map (
     addr => PC(6 downto 2),
     dout => Instruction
   );

 -- ===== Additionneur 1 : PC + 4 =====
 U_Add4 : entity work.adder_end
   port map (
     a => PC,
     b => x"00000004",
     y => PCPlus4
   );

 -- ===== Additionneur 2 : PCBranch = PCPlus4 + ExtImm =====
 U_AddBranch : entity work.adder_end_second
   port map (
     a => PCPlus4,
    -- b => ExtImm,
     b =>  x"00000004",
     y => PCBranch
   );

 -- ===== Multiplexeur =====
 U_MuxPC : entity work.mux_pc
   port map (
     PCSrc    => PCSrc,
     PCPlus4  => PCPlus4,
     PCBranch => PCBranch,
     PCNext   => PCNext
   );

end Behavioral;
