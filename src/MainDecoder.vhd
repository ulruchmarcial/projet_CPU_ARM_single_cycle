----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2025 22:18:58
-- Design Name: 
-- Module Name: MainDecoder - Behavioral
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

entity MainDecoder is
port (
        Op      : in  std_logic_vector(1 downto 0); -- bits Op[1:0]
        Funct   : in  std_logic_vector(5 downto 0); -- Funct[5:0] ; on utilisera Funct(5) et Funct(0)
        -- sorties de contrôle
        Branch   : out std_logic;
        MemtoReg : out std_logic;
        MemWrite     : out std_logic;
        ALUSrc   : out std_logic;
        ImmSrc   : out std_logic_vector(1 downto 0);
        RegWrite     : out std_logic;
        RegSrc   : out std_logic_vector(1 downto 0);
        ALUOp    : out std_logic
    );
end MainDecoder;

architecture Behavioral of MainDecoder is

begin
process(Op, Funct)
    begin
        -- Valeurs par défaut (sécurisées)
        Branch   <= '0';
        MemtoReg <= '0';
        MemWrite     <= '0';
        ALUSrc   <= '0';
        ImmSrc   <= "00";
        RegWrite      <= '0';
        RegSrc   <= "00";
        ALUOp    <= '0';

        -- Décodage suivant Op
        if Op = "00" then
            -- Data-Processing (DP)
            ALUOp <= '1';
            RegWrite   <= '1';
            Branch <= '0';
            MemWrite <= '0';
            MemtoReg <= '0';
            -- distinguer DP Reg vs DP Imm selon Funct(5)
            if Funct(5) = '0' then
                -- DP Reg
                ALUSrc <= '0';
                ImmSrc <= "00";   -- non utilisé ici ; mis à "00" par convention
                RegSrc <= "00";   -- Rd <- ALU result
            else
                -- DP Imm
                ALUSrc <= '1';
                ImmSrc <= "00";   -- immédiat de type 00 (tableau)
                -- tableau donne RegSrc = X0 (bit0 = '0') -> on choisit "00"
                RegSrc <= "00";
            end if;

        elsif Op = "01" then
            -- Load/Store
            ALUOp <= '0';      -- on n'utilise pas l'ALU decoder (ALUOp=0 => Not DP)
            ALUSrc <= '1';
            ImmSrc <= "01";    -- format d'imm pour LDR/STR
            Branch <= '0';

            if Funct(0) = '0' then
                -- STR
                MemWrite<= '1';
                MemtoReg <= '0'; -- don't care, pas utilisé (on n'écrit pas depuis mem)
                RegWrite  <= '0';
                -- RegSrc = "10" (tableau) : convention éventuelle (par ex. select WD)
                RegSrc <= "10";
            else
                -- LDR
               MemWrite <= '0';
                MemtoReg <= '1';
               RegWrite  <= '1';
                -- RegSrc = X0 (bit0=0) -> choisir "00" (ou "00" selon convention)
                RegSrc <= "00";
            end if;

        else
            -- autres Op : on garde valeurs par défaut (sécurisées)
            NULL;
        end if;
    end process;

end Behavioral;
