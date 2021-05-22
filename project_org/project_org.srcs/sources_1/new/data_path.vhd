----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Arthur Rinaldi de Oliveira
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
library mito;
use mito.mito_pkg.all;

entity data_path is
  Port (
    -- Entradas do datapath
    clk                 : in  std_logic;
    rst_n               : in  std_logic;
    -- Registradores
    ir_enable           : in  std_logic;    -- Registrador de instrução
    pc_enable           : in  std_logic;    -- Permite alterar o PC
    flags_enable        : in  std_logic;    -- Permite alterar as flags
    write_reg_en        : in  std_logic;    -- Permite escrita no banco de registradores
    -- Multiplexadores
    load_mux            : in  std_logic;
    adress_mux          : in  std_logic;
    jmp_mux             : in  std_logic;
    branch_mux          : in  std_logic;
    -- Saidas do datapath
    decoded_inst        : out std_logic_vector (6 downto 0);
    flag_zero           : out std_logic;
    flag_neg            : out std_logic;
    flag_overflow       : out std_logic;
    flag_sig_overflow   : out std_logic;
    -- Saida e entrada da memoria
    adress_pc           : out std_logic_vector (8 downto 0);
    data_in             : in  std_logic_vector (15 downto 0);       
    data_out            : out std_logic_vector (15 downto 0)        
    
  );
end data_path;

architecture rtl of data_path is


    signal data                 : std_logic_vector (15 downto 0);   -- Saida da memoria
    signal instruction          : std_logic_vector (15 downto 0);   -- Saida do registrador de instrução
    
    signal alu_or_mem_data      : std_logic_vector (15 downto 0);

    signal mem_addr             : std_logic_vector (8  downto 0); 
    signal program_counter      : std_logic_vector (8  downto 0); 
    signal out_pc_mux           : std_logic_vector (8  downto 0); 
    signal b_alu                : std_logic_vector (15 downto 0);
    signal dr_to_reg            : std_logic_vector (15 downto 0);

    
    -- registers
     signal reg1                : std_logic_vector (15 downto 0);
     signal reg2                : std_logic_vector (15 downto 0);
     signal reg3                : std_logic_vector (15 downto 0);
     signal reg4                : std_logic_vector (15 downto 0);
     signal reg5                : std_logic_vector (15 downto 0);
     signal reg6                : std_logic_vector (15 downto 0);
     signal reg7                : std_logic_vector (15 downto 0);
     signal reg8                : std_logic_vector (15 downto 0);
     signal reg9                : std_logic_vector (15 downto 0);
     signal reg10               : std_logic_vector (15 downto 0);
     signal reg11               : std_logic_vector (15 downto 0);
     signal reg12               : std_logic_vector (15 downto 0);
     signal reg13               : std_logic_vector (15 downto 0);
     signal reg14               : std_logic_vector (15 downto 0);
     signal reg15               : std_logic_vector (15 downto 0);
     
     signal reg_instruction     : std_logic_vector (15 downto 0); 
     
    -- Registrador destino
    signal reg_dest     : std_logic_vector(4 downto 0);
    signal reg_dest_duo : std_logic_vector(4 downto 0);
    
    -- Registrador A
    signal reg_op_a     : std_logic_vector(4 downto 0);
    signal reg_a_alu_out: std_logic_vector(15 downto 0);
    
    -- Registrador B
    signal reg_op_b     : std_logic_vector(4 downto 0);
    signal reg_b_alu_out: std_logic_vector(15 downto 0);
      
   -- ALU signals
    signal a_operand    : STD_LOGIC_VECTOR (15 downto 0);      
    signal b_operand    : STD_LOGIC_VECTOR (15 downto 0);   
    signal ula_out      : STD_LOGIC_VECTOR (16 downto 0);
    
    -- FLAGS
    signal zero         : std_logic;
    signal neg          : std_logic;
    signal overflow     : std_logic;
    signal sig_overflow : std_logic;
      
    begin
    
    IR : process (clk)
    begin
        if (ir_enable = '1' AND rising_edge(clk)) then
            reg_instruction <= data_in;
        end if;
    end process IR;
    
    
    

end rtl;
