----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2025 15:30:14
-- Design Name: 
-- Module Name: Shifter - Behavioral
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

entity Shifter is
port(
    Data_in  : in  std_logic_vector(31 downto 0);  -- donnee a l'entree du Shifter
    Shamt    : in  std_logic_vector(4 downto 0);  --  nombre de bits à décaler
    ShiftOp  : in  std_logic_vector(1 downto 0);  -- type de décalage ( 00=LSL, 01=LSR, 10=ASR , 11=ROR )
    Data_out : out std_logic_vector(31 downto 0) -- donnee a sortie  du Shifter  
  );
end Shifter;

architecture Behavioral of Shifter is
--signal temp : std_logic_vector(31 downto 0);
begin
   process(Data_in, Shamt, ShiftOp)
  variable sh : integer;
  variable temp : std_logic_vector(31 downto 0);
  begin 
    sh := to_integer(unsigned(Shamt));
          case ShiftOp is
  
              -- LSL: Logical Shift Left
              when "00" =>
                  if sh < 32 then
                      temp := std_logic_vector(shift_left(unsigned(Data_in), sh));
                  else
                      temp:= (others => '0');
                  end if;
  
              -- LSR: Logical Shift Right
              when "01" =>
                  if sh < 32 then
                      temp := std_logic_vector(shift_right(unsigned(Data_in), sh));
                  else
                      temp := (others => '0');
                  end if;
  
              -- ASR: Arithmetic Shift Right (conserve le bit de signe)
              when "10" =>
                  if sh < 32 then
                      if Data_in(31) = '1' then
                          temp := std_logic_vector(shift_right(signed(Data_in), sh));
                      else
                          temp := std_logic_vector(shift_right(signed(Data_in), sh));
                      end if;
                  else
                      if Data_in(31) = '1' then
                          temp := (others => '1');
                      else
                          temp := (others => '0');
                      end if;
                  end if;
  
              -- ROR: Rotate Right
              when "11" =>
                  if sh = 0 then
                      temp := Data_in;
                  else
                      temp := Data_in(sh-1 downto 0) & Data_in(31 downto sh);
                  end if;
  
              when others =>
                  temp := Data_in;
          end case;
  
          Data_out <= temp;
      end process;
end Behavioral;
