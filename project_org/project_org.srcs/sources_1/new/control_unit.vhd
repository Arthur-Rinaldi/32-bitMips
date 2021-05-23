----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Arthur Rinaldi de Oliveira
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
library mito;
use mito.mito_pkg.all;

entity control_unit is
    Port ( 
        -- Entradas do controle
        clk                 : in  std_logic;
        rst_n               : in  std_logic;
        flag_zero           : in  std_logic;
        flag_neg            : in std_logic;
        flag_overflow       : in std_logic;
        flag_sig_overflow   : in std_logic;
        decoded_inst        : in decoded_instruction_type;
        -- Saidas do controle
        --Registradores
        ir_enable           : out  std_logic;    -- Permite alterar RI                                
        pc_enable           : out  std_logic;    -- Permite alterar o PC                              
        flags_enable        : out  std_logic;    -- Permite alterar as flags                          
        write_reg_en        : out  std_logic;    -- Permite escrita no banco de registradores         
        -- Multiplexadores
        load_mux            : out  std_logic;
        adress_mux          : out  std_logic;
        new_pc_sel          : out  std_logic;    -- Seletor da entrada de PC, desvio ou soma um
        branch_mux          : out  std_logic;
        -- Controle da memoria
        escrita             : out  std_logic
        );
end control_unit;


architecture rtl of control_unit is

        type state_type is (FETCH,DECODE,NEXT1,ULA_1,ULA_2,STORE,LOAD,BRANCH,JUMP,HALT);
        signal state : state_type;
        
begin

        process(clk, rst_n)
    begin
    if rst_n = '0' and rising_edge(clk) then
        ir_enable <= '1';
        state <= FETCH;
    elsif(rising_edge(clk)) then
        ir_enable     <= '0';
        pc_enable     <= '0';
        flags_enable  <= '0';
        write_reg_en  <= '0';
        load_mux      <= '0';
        adress_mux    <= '0';
        new_pc_sel    <= '0';
        branch_mux    <= '0';
        escrita       <= '0';
        case state is
            when FETCH=>
                state <= DECODE;
            when DECODE=> 
            
        when others=>
                    halt <= '1';     
           end case;
           DECODE,NEXT1,ULA_1,ULA_2,STORE,LOAD,BRANCH,JUMP,HALT
           
     end if;

end process;

end rtl;
