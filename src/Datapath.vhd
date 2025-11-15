----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2025 17:10:45
-- Design Name: 
-- Module Name: Datapath - Behavioral
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

entity Datapath is
    Port (
           CLK       : in  std_logic;
           Instr     : in  std_logic_vector(31 downto 0);
           RegWrite  : in  std_logic;
           MemWrite  : in  std_logic;
           ALUSrc    : in  std_logic;  -- 0=Reg, 1=Imm
           MemtoReg  : in  std_logic;  -- 0=ALUResult, 1=ReadData
           ImmSrc    : in  std_logic_vector(1 downto 0);
           ALUControl: in  std_logic_vector(1 downto 0);
           RegSrc    : in  std_logic_vector(1 downto 0);  -- contrôle pour RA1 et RA2
           R15       : in  std_logic_vector(31 downto 0); 
           --RD1        : out std_logic_vector(31 downto 0);
           --RD2        : out std_logic_vector(31 downto 0);
           ALUResult  : out std_logic_vector(31 downto 0);
          -- ExtImm     : out std_logic_vector(31 downto 0);
            ALUFlags      : out std_logic_vector(3 downto 0);
            WriteDataOut  : out std_logic_vector(31 downto 0) ;-- sortie après mémoire
           WriteData : out std_logic_vector(31 downto 0);
           ReadData : out std_logic_vector(31 downto 0) 
           

);
end Datapath;

architecture Behavioral of Datapath is
 -- Signaux internes
   signal RA1, RA2, A3 : std_logic_vector(3 downto 0);
   signal RD1, RD2, WD3 : std_logic_vector(31 downto 0);
   signal ExtImm, SrcB, SrcA ,  MemReadData , ALUResult_signal : std_logic_vector(31 downto 0);
   signal ShiftedReg : std_logic_vector(31 downto 0);
   
   signal Shamt    : std_logic_vector(4 downto 0);
   signal ShiftOp  : std_logic_vector(1 downto 0);



    
begin
  -- Sélection RA1 et RA2 selon RegSrc
    RA1 <= Instr(19 downto 16) when RegSrc(0) ='0' else "1111" ;
    RA2 <= Instr(3 downto 0)    when RegSrc(1) ='0' else Instr(15 downto 12);
   A3  <= Instr(15 downto 12); -- Rd pour écriture
   -- decodage des champ Shamt et ShiftOp
   Shamt   <= Instr(11 downto 7);  -- décalage sur 5 bits
   ShiftOp <= Instr(6 downto 5);   -- type de shift

   -- Instanciation Register File
   RF: entity work.RegisterFile
       Port map(
           clk      => CLK,
           RegWrite => RegWrite,
           RA1      => RA1,
           RA2      => RA2,
           A3       => A3,
           WD3      => WD3,
           R15      => R15,
           RD1      => RD1,
           RD2      => RD2
       );

   -- Instanciation Extend (24 LSB de l'instruction)
   EXT: entity work.Extend
       Port map(
           Instr  => Instr(23 downto 0),
           ImmSrc => ImmSrc,
           ExtImm => ExtImm
       );
       
   U_Shifter : entity work.Shifter
         port map (
           Data_in  => RD2,
           Shamt    =>  Shamt,
           ShiftOp  => ShiftOp,
           Data_out => ShiftedReg
         );
       
       

   -- Instanciation ALU
   ALU: entity work.UAL_flags
       generic map(N=>32)
       port map(
          -- A          => RD1,
            A          => SrcA,
           B          => SrcB,
           ALUControl => ALUControl,
           ALUResult  => ALUResult_signal,
           Flags      =>  ALUFlags 
           
       );

   -- Instanciation DataMemory
   DM: entity work.DataMemory
       port map(
           CLK      => CLK,
           MemWrite => MemWrite,
           A        => ALUResult_signal, -- adresse mémoire
           WD       => RD2,        -- données à écrire
           RD       => MemReadData
       );
       
      SrcA  <= RD1 ; 
    -- Multiplexeur ALUSrc
             SrcB <= ShiftedReg when ALUSrc = '0' else ExtImm;
       -- Sortie pour observer la donnée lue en  mémoire 
     ReadData <= MemReadData ;
     -- Sortie pour observer la valeur de ALUResult entrain d'aller en mémoire ou dans le registre.
     ALUResult  <= ALUResult_signal ;
      -- Sortie pour observer la donnée ecrite en  mémoire 
     WriteData <= RD2 ;
   -- Multiplexeur MemtoReg pour écrire dans WD3
   WD3 <= ALUResult_signal when MemtoReg='0' else MemReadData;
   
   -- Sortie pour observer la donnée après mémoire
   WriteDataOut <= WD3;
   

end Behavioral;
