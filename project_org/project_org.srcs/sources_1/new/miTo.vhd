----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Newton Jr
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library mito;
use mito.mito_pkg.all;

entity miTo is
  Port (
      rst_n                  : in  std_logic;
      clk                    : in  std_logic;
      data_in                : in  std_logic_vector (15 downto 0);
      data_out               : out std_logic_vector (15 downto 0);
      escrita                : out std_logic
   );
end miTo;

architecture rtl of miTo is

signal decoded_inst_s           : decoded_instruction_type;
signal flag_zero_s              : std_logic;
signal flag_neg_s               : std_logic;
signal flag_overflow_s          : std_logic;
signal flag_sig_overflow_s      : std_logic;
signal data_in_s                : std_logic_vector (15 downto 0);
signal data_out_s               : std_logic_vector (15 downto 0);
signal adress_pc_s              : std_logic_vector (8  downto 0);
signal ir_enable_s              : std_logic;
signal pc_enable_s              : std_logic;
signal load_mux_s               : std_logic;
signal adress_mux_s             : std_logic;
signal new_pc_sel_s             : std_logic;
signal branch_mux_s             : std_logic;
signal flags_enable_s           : std_logic;
signal write_reg_en_s           : std_logic;
signal escrita_s                : std_logic;

begin

control_unit_i : control_unit
    port map( 
    clk                 => clk,
    rst_n               => rst_n,
    decoded_inst        => decoded_inst_s,      
    flag_zero           => flag_zero_s,         
    flag_neg            => flag_neg_s,          
    flag_overflow       => flag_overflow_s,     
    flag_sig_overflow   => flag_sig_overflow_s,                  
    ir_enable           => ir_enable_s,
    pc_enable           => pc_enable_s,         
    load_mux            => load_mux_s,         
    adress_mux          => adress_mux_s,        
    new_pc_sel          => new_pc_sel_s,        
    branch_mux          => branch_mux_s,        
    flags_enable        => flags_enable_s,      
    write_reg_en        => write_reg_en_s,
    escrita             => escrita_s  
    );

data_path_i : data_path
  port map (
   clk                 => clk,                    
   rst_n               => rst_n,                  
   decoded_inst        => decoded_inst_s,         
   flag_zero           => flag_zero_s,            
   flag_neg            => flag_neg_s,             
   flag_overflow       => flag_overflow_s,        
   flag_sig_overflow   => flag_sig_overflow_s,    
   data_in             => data_in_s,              
   data_out            => data_out_s,             
   adress_pc           => adress_pc_s,            
   ir_enable           => ir_enable_s,            
   pc_enable           => pc_enable_s,            
   load_mux            => load_mux_s,             
   adress_mux          => adress_mux_s,           
   new_pc_sel          => new_pc_sel_s,           
   branch_mux          => branch_mux_s,           
   flags_enable        => flags_enable_s,         
   write_reg_en        => write_reg_en_s         
  );
  
memory_i : memory
  port map(
    clk                 => clk,
    rst_n               => rst_n,    
    adress_pc           => adress_pc_s,
    escrita             => escrita_s,
    data_in             => data_in_s,
    data_out            => data_out_s
  );
 
end rtl;
