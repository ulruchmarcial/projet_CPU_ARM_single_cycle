----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2025 22:43:09
-- Design Name: 
-- Module Name: CPU_Top - Behavioral
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

entity CPU_Top is
port (
        CLK        : in  std_logic;
        Instr: in  std_logic_vector(31 downto 0);
        -- sorties observables
        ALUResult  : out std_logic_vector(31 downto 0);
        WriteData  : out std_logic_vector(31 downto 0);
        ReadData   : out std_logic_vector(31 downto 0);
        Flags      : out std_logic_vector(3 downto 0)
    );
end CPU_Top;


architecture Behavioral of CPU_Top is
 -- signaux internes
   signal Branch, MemtoReg, MemWrite, ALUSrc, RegWrite: std_logic;
   signal ImmSrc, RegSrc : std_logic_vector(1 downto 0);
   signal ALUOp : std_logic;
   signal ALUControl : std_logic_vector(1 downto 0);
   signal FlagW : std_logic_vector(1 downto 0);
   signal R15  : std_logic_vector(3 downto 0);
   signal ALUResult_signal  : std_logic_vector(3 downto 0);

   -- extraction des champs Instruction
   signal Op    : std_logic_vector(1 downto 0);
   signal Funct : std_logic_vector(5 downto 0);

begin
 -- décodage des champs
   Op    <= Instr(27 downto 26);
   Funct <= Instr(25 downto 20);

   -- Instanciation du Main Decoder
   U1: entity work.MainDecoder
       port map (
           Op        => Op,
           Funct     => Funct,
           Branch    => Branch,
           MemtoReg  => MemtoReg,
           MemWrite  => MemWrite,
           ALUSrc    => ALUSrc,
           ImmSrc    => ImmSrc,
           RegWrite      => RegWrite,
           RegSrc    => RegSrc,
           ALUOp     => ALUOp
       );

   -- Instanciation du ALU Decoder
   U2: entity work.ALUDecoder
       port map (
           ALUOp      => ALUOp,
           Funct      => Funct(4 downto 0),
           ALUControl => ALUControl,
           FlagW      => FlagW
       );

   -- Instanciation du Datapath (du lab 2)
   U3: entity work.Datapath
       port map (
           CLK       => CLK,
           Instr => Instr,
           RegWrite  => RegWrite,
           MemtoReg  => MemtoReg,
           MemWrite  => MemWrite,
           ALUSrc    => ALUSrc,
           ImmSrc    => ImmSrc,
           RegSrc    => RegSrc,
           ALUControl=> ALUControl,
           ALUResult => ALUResult,
           WriteData => WriteData,
           ReadData  => ReadData,
           Flags     => Flags,
           R15       => R15           
       );


end Behavioral;
