----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.09.2025 13:56:38
-- Design Name: 
-- Module Name: UAL_flags - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL_flags is
generic(N : integer := 32);
  port(
    A, B     : in  STD_LOGIC_VECTOR(N-1 downto 0);
    ALUControl     : in  STD_LOGIC_VECTOR(1 downto 0);  -- 00=ADD, 01=SUB, 10=AND, 11=OR
    ALUResult    : out STD_LOGIC_VECTOR(N-1 downto 0);
    -- Flags
    Flags : out STD_LOGIC_VECTOR(3 downto 0)
   -- N_flag   : out STD_LOGIC;  -- Negative
    --Z_flag   : out STD_LOGIC;  -- Zero
   -- C_flag   : out STD_LOGIC;  -- Carry
   -- V_flag   : out STD_LOGIC   -- Overflow
  );
end UAL_flags;

architecture Behavioral of UAL_flags is
-- Signaux internes
  signal b_mux   : STD_LOGIC_VECTOR(N-1 downto 0);
  signal sum     : STD_LOGIC_VECTOR(N-1 downto 0);
  signal cout    : STD_LOGIC;
  signal and_res   : STD_LOGIC_VECTOR(N-1 downto 0);
  signal or_res    : STD_LOGIC_VECTOR(N-1 downto 0);
  signal result_internal : STD_LOGIC_VECTOR(N-1 downto 0);
  signal zero_vector : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); 
begin
  -----------------------------------------------------------------
 -- MUX2 pour gérer Addition / Soustraction
 -----------------------------------------------------------------
 mux_b : entity work.MULTIPLEXER2TO1
   generic map(N => N)
   port map(
     b     => B,
     sel   => ALUControl(0),   -- 0=ADD, 1=SUB
     b_out => b_mux
   );
    -----------------------------------------------------------------
    -- Additionneur
    -----------------------------------------------------------------
    add_inst : entity work.adder
      generic map(N => N)
      port map(
        a    => A,
        b    => b_mux,
        cin  => ALUControl(0),     -- cin=0 pour ADD, cin=1 pour SUB
        sum  => sum,
        cout => cout
      );
   -----------------------------------------------------------------
   -- Opérations logiques
   -----------------------------------------------------------------
   and_res <= A and B;
   or_res  <= A or B;
   -----------------------------------------------------------------
   -- MUX4 : sélection de l'opération finale
   -----------------------------------------------------------------
   mux_out : entity work.mux4to1
     generic map(N => N)
     port map(
       d0  => sum,      -- ADD
       d1  => sum,      -- SUB
       d2  => and_res,  -- AND
       d3  => or_res,   -- OR
       sel => ALUControl,
       --y   => Result
        y   => result_internal
     );
     ALUResult  <=  result_internal;
    -----------------------------------------------------------------
     -- Flags
     -----------------------------------------------------------------
     -- Negative flag : MSB du résultat
    Flags(3) <= result_internal(N-1);
   
     -- Zero flag : 1 si tout le résultat est nul
     --Z_flag <= '1' when result_internal = (others => '0') else '0';
     Flags(2) <= '1' when result_internal = zero_vector else '0';
   
     -- Carry flag : seulement valide en opérations arithmétiques
     Flags(1)<= cout and (not ALUControl(1));
   
     -- Overflow flag (formule de la figure 5.17)
     Flags(0) <= (not (A(N-1) xor B(N-1) xor ALUControl(0)) and
                (A(N-1) xor sum(N-1)) and
                not ALUControl(1));
end Behavioral;
