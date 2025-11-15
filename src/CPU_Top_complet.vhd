----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2025 21:05:57
-- Design Name: 
-- Module Name: CPU_Top_complet - Behavioral
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

entity CPU_Top_complet is
 port (
   CLK        : in  std_logic;
   ARST       : in  std_logic; --  Reset asynchrone 
   ALUResult  : out std_logic_vector(31 downto 0);
   WriteData  : out std_logic_vector(31 downto 0);
   ReadData   : out std_logic_vector(31 downto 0);
   Flags      : out std_logic_vector(3 downto 0);
   PC         : out std_logic_vector(31 downto 0)
 );
end CPU_Top_complet;

architecture Behavioral of CPU_Top_complet is
  -- signaux de contrôle
signal Branch, MemtoReg, MemWrite, ALUSrc, RegWrite : std_logic;
signal ImmSrc, RegSrc : std_logic_vector(1 downto 0);
signal ALUOp : std_logic;
signal ALUControl : std_logic_vector(1 downto 0);
signal FlagW : std_logic_vector(1 downto 0);

-- signaux internes
signal PC_reg, PCNext, PCPlus4, PCPlus8 : std_logic_vector(31 downto 0);
signal Instr, ExtImm ,R15 : std_logic_vector(31 downto 0);
signal CondEx, PCSrc , RegW , MemW  , NoWrite : std_logic;
signal Flags_reg : std_logic_vector(3 downto 0);
signal Op : std_logic_vector(1 downto 0);
signal Funct : std_logic_vector(5 downto 0);
signal ALUFlags : std_logic_vector(3 downto 0);


begin
 -- Décodage des champs
 Op    <= Instr(27 downto 26);
 Funct <= Instr(25 downto 20);

 -- Décodage principal
 U1: entity work.MainDecoder
   port map (
     Op        => Op,
     Funct     => Funct,
     Branch    => Branch,
     MemtoReg  => MemtoReg,
     MemWrite  => MemW,
     ALUSrc    => ALUSrc,
     ImmSrc    => ImmSrc,
     RegWrite  => RegW,
     RegSrc    => RegSrc,
     ALUOp     => ALUOp
   );

 -- ALU Decoder
 U2: entity work.ALUDecoder
   port map (
     ALUOp      => ALUOp,
     Funct      => Funct(4 downto 0),
     ALUControl => ALUControl,
     FlagW      => FlagW,
     NoWrite  => NoWrite
   );

 -- Registre PC
 U_PC : entity work.pc_reg
  port map (clk => CLK, PCNext => PCNext, PC => PC_reg, arst => ARST);

 -- Mémoire d'instruction
 U_IMEM : entity work.instruction_memory
   port map (A => PC_reg(6 downto 2), RD => Instr);

 -- Condition Check
 U_CondCheck : entity work.condition_check
   port map (Cond => Instr(31 downto 28), Flags => Flags_reg, CondEx => CondEx);

 -- Registre Flags
 U_Flags : entity work.flags_reg_vec
 port map (clk => CLK, FlagW => FlagW, CondEx => CondEx,
                     Flags_in =>  ALUFlags , Flags_out => Flags_reg, arst => ARST);
  

 -- Additionneurs
 U_Add4 : entity work.adder_end port map (a => PC_reg, b => x"00000004", y => PCPlus4);
 U_AddBranch : entity work.adder_end_second port map (a => PCPlus4, b => x"00000004" , y => PCPlus8);
 
 -- Multiplexeur du PC
 U_MuxPC : entity work.mux_pc
   port map (PCSrc => PCSrc, PCPlus4 => PCPlus4, PCPlus8 => PCPlus8, PCNext => PCNext);
   

 -- Datapath
 U3: entity work.Datapath
   port map (
     CLK       => CLK,
     Instr     => Instr,
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
     ALUFlags    =>  ALUFlags ,
     R15 => R15 
   );
-- gestion des signaux de contrôle
      RegWrite <= (RegW and CondEx )and (not NoWrite);
      MemWrite <= MemW and CondEx;
      
    -- PCSrc logique
    PCSrc <= Branch and CondEx;
 
 -- mise a jour du PC
 PC <= PC_reg;
 
 -- mise a jour des Flags 
 Flags  <= Flags_reg;

  -- R15 prend PC+8 si branch   
 R15 <= PCPlus8;
 
end Behavioral;
