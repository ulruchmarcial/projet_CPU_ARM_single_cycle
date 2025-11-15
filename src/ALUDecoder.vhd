----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2025 22:35:28
-- Design Name: 
-- Module Name: ALUDecoder - Behavioral
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

entity ALUDecoder is
 port (
       ALUOp     : in  std_logic;                 -- signal du décodeur principal
       Funct     : in  std_logic_vector(4 downto 0); -- bits 4:0 de l'instruction
       ALUControl: out std_logic_vector(1 downto 0); -- code pour l'ALU
       FlagW     : out std_logic_vector(1 downto 0);  -- update flags (
       NoWrite  : out std_logic  -- pour empecher l'ecriture du registre 
        
   );
end ALUDecoder;

architecture Behavioral of ALUDecoder is

begin
process(ALUOp, Funct )
    begin
        if ALUOp = '0' then
            -- pas Data-Processing
            ALUControl <= "00"; -- ADD par défaut
            FlagW      <= "00"; -- Pas de mise à jour de flags
            NoWrite  <= '0' ;
        else
            -- Mode Data Processing
              case Funct(4 downto 1) is
                when "0100" =>  -- ADD
                  ALUControl <= "00";
                  NoWrite  <= '0' ;
                  if Funct(0) = '1' then
                    FlagW <= "11"; -- MAJ N,Z,C,V
                  else
                    FlagW <= "00";
                  end if;
        
                when "0010" =>  -- SUB
                  ALUControl <= "01";
                  NoWrite  <= '0' ;
                  if Funct(0) = '1' then
                    FlagW <= "11"; -- MAJ N,Z,C,V
                  else
                    FlagW <= "00";
                  end if;
        
                when "0000" =>  -- AND
                  ALUControl <= "10";
                  NoWrite  <= '0' ;
                  if Funct(0) = '1' then
                    FlagW <= "10"; -- MAJ N,Z seulement
                  else
                    FlagW <= "00";
                  end if;
        
                when "1100" =>  -- ORR
                  ALUControl <= "11";
                  NoWrite  <= '0' ;
                  if Funct(0) = '1' then
                    FlagW <= "10"; -- MAJ N,Z seulement
                  else
                    FlagW <= "00";
                  end if;
                
                  when "1010" =>  -- CMP
                    ALUControl <= "01";
                    NoWrite  <= '1' ;
                    if Funct(0) = '1' then
                      FlagW <= "11"; -- -- MAJ N,Z,C,V
                    end if;
                when others =>
                  ALUControl <= "00";
                  FlagW      <= "00";
                  NoWrite  <= '0' ;
              end case;
        end if;
    end process;

end Behavioral;
