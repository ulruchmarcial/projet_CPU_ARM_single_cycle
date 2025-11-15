library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TB_CPU_Top_complet is
end TB_CPU_Top_complet;

architecture Behavioral of TB_CPU_Top_complet is

    --------------------------------------------------------------------------
    -- Composant à tester
    --------------------------------------------------------------------------
    component CPU_Top_complet
        port (
            CLK        : in  std_logic;
            ARST       : in  std_logic; --  Reset asynchrone 
            ALUResult  : out std_logic_vector(31 downto 0);
            WriteData  : out std_logic_vector(31 downto 0);
            ReadData   : out std_logic_vector(31 downto 0);
            Flags      : out std_logic_vector(3 downto 0);
             PC         : out std_logic_vector(31 downto 0)
        );
    end component;

    --------------------------------------------------------------------------
    -- Signaux de test
    --------------------------------------------------------------------------
    signal CLK_tb        : std_logic := '0';
    signal ARST_tb       : std_logic := '1';  -- Reset actif au début
    signal ALUResult_tb  : std_logic_vector(31 downto 0);
    signal WriteData_tb  : std_logic_vector(31 downto 0);
    signal ReadData_tb   : std_logic_vector(31 downto 0);
    signal Flags_tb      : std_logic_vector(3 downto 0);
    signal PC_tb         : std_logic_vector(31 downto 0);
    
    --signal ExpectedALUResult_signal   : std_logic_vector(31 downto 0);
    -- signal ExpectedData_signal   : std_logic_vector(31 downto 0);
      --signal CLK        : std_logic ;
    --constant CLK_PERIOD  : time := 10 ns;
    

begin

    --------------------------------------------------------------------------
    -- 1?? Instanciation du CPU complet
    --------------------------------------------------------------------------
    UUT: CPU_Top_complet
        port map (
           CLK       => CLK_tb,
           ARST      => ARST_tb,   
            ALUResult => ALUResult_tb,
            WriteData => WriteData_tb,
            ReadData  => ReadData_tb,
            Flags     => Flags_tb,
            PC        => PC_tb
        );
   
    --------------------------------------------------------------------------
    -- 2?? Génération de l'horloge (période 10 ns)
    --------------------------------------------------------------------------
    process
    begin
        while true  loop
           CLK_tb <= '0';
           wait for  5 ns;
           CLK_tb <= '1';
            wait for  5 ns;
       end loop;
       wait;
   end process;
    
     
    --------------------------------------------------------------------------
    -- 3?? Génération du reset
    --------------------------------------------------------------------------
    process
    begin
        --Reset actif pendant 2 ns
        ARST_tb <= '1';
        wait for 2 ns;
        ARST_tb <= '0';
        wait;
    end process;
   
  

end Behavioral;
