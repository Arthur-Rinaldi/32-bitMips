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
    ir_enable           : in  std_logic;    -- Permite alterar RI
    pc_enable           : in  std_logic;    -- Permite alterar o PC
    flags_enable        : in  std_logic;    -- Permite alterar as flags
    write_reg_en        : in  std_logic;    -- Permite escrita no banco de registradores
    -- Multiplexadores
    load_mux            : in  std_logic;
    adress_mux          : in  std_logic;
    jmp_mux             : in  std_logic;
    branch_mux          : in  std_logic;
    -- Saidas do datapath
    decoded_inst        : out std_logic_vector (6 downto 0);   -- O sinal da instru��o que vai para a maquina de estados
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

signal instruction          : std_logic_vector (15 downto 0);   -- Saida do registrador de instru��es
signal pc_out               : std_logic_vector (8  downto 0);   -- Saida do PC 
signal pc_in                : std_logic_vector (8  downto 0);   -- Entrada do PC 

-- Sinais que saem do decoder
signal ULA_OP               : std_logic_vector (2  downto 0);   -- Seta a opera��o da ula
signal jp_adress            : std_logic_vector (8  downto 0);   -- 
signal brach_adress         : std_logic_vector (8  downto 0);   --
signal REG_A                : std_logic_vector (3  downto 0);   -- 
signal REG_B                : std_logic_vector (3  downto 0);   --
signal REG_DEST             : std_logic_vector (3  downto 0);   -- Seta o registrador destino
    
-- Registradores
signal reg0                : std_logic_vector (15 downto 0);
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

-- Sinais da ULA
signal a_operand    : STD_LOGIC_VECTOR (15 downto 0);      
signal b_operand    : STD_LOGIC_VECTOR (15 downto 0);   
signal ula_out      : STD_LOGIC_VECTOR (16 downto 0);

-- Sinais do banc de registradores
signal bus_a        : STD_LOGIC_VECTOR (15 downto 0);
signal bus_b        : STD_LOGIC_VECTOR (15 downto 0);
signal bus_c        : STD_LOGIC_VECTOR (15 downto 0);

-- FLAGS
signal zero         : std_logic;
signal neg          : std_logic;
signal overflow     : std_logic;
signal sig_overflow : std_logic;
  
begin
    
    PC : process (clk)
    begin
    if (rst_n = '0' AND rising_edge(clk)) then
        pc_out <= "000000000";
    elsif (pc_enable = '1' AND rising_edge(clk)) then
        pc_out <= pc_in;
    end if;
    end process PC;

    RI : process (clk)
    begin
        if (ir_enable = '1' AND rising_edge(clk)) then
            instruction <= data_in;
        end if;
    end process RI;

    FLAGS :    process (clk)
    begin
        if (flags_enable = '1' AND rising_edge(clk)) then
            flag_zero         <= zero;
            flag_neg          <= neg;
            flag_overflow     <= overflow;
            flag_sig_overflow <= sig_overflow;
    end if;
    end process flags;

    BANCO_DE_REGISTRADORES : process (clk) --Banco de registradores
    begin    
       data_out <= bus_a;
     if (rising_edge(clk)) then
            if (write_reg_en = '1') then
                case REG_DEST is
                     when "0000" => reg0  <= bus_a;
                     when "0001" => reg1  <= bus_a;
                     when "0010" => reg2  <= bus_a;
                     when "0011" => reg3  <= bus_a;
                     when "0100" => reg4  <= bus_a;
                     when "0101" => reg5  <= bus_a;
                     when "0110" => reg6  <= bus_a;
                     when "0111" => reg7  <= bus_a;
                     when "1000" => reg8  <= bus_a;
                     when "1001" => reg9  <= bus_a;
                     when "1010" => reg10 <= bus_a;
                     when "1011" => reg11 <= bus_a;
                     when "1100" => reg12 <= bus_a;
                     when "1101" => reg13 <= bus_a;
                     when "1110" => reg14 <= bus_a;
                     when others => reg15 <= bus_a;
                 end case;   
            else
                if (rst_n = '0') then
                    reg0 <= "0000000000000000";
                    reg1 <= "0000000000000000";
                    reg2 <= "0000000000000000";
                    reg3 <= "0000000000000000";
                    reg4 <= "0000000000000000"; 
                    reg5 <= "0000000000000000"; 
                    reg6 <= "0000000000000000"; 
                    reg7 <= "0000000000000000"; 
                    reg8 <= "0000000000000000"; 
                    reg9 <= "0000000000000000"; 
                    reg10<= "0000000000000000"; 
                    reg11<= "0000000000000000"; 
                    reg12<= "0000000000000000"; 
                    reg13<= "0000000000000000"; 
                    reg14<= "0000000000000000"; 
                    reg15<= "0000000000000000"; 
                 end if;
             end if;
    end if;
    end process BANCO_DE_REGISTRADORES;
    
    bus_a_wire : 
    bus_a <= reg0 when REG_DEST = "0000" else
    reg1  when REG_DEST = "0001" else
    reg2  when REG_DEST = "0010" else
    reg3  when REG_DEST = "0011" else
    reg4  when REG_DEST = "0100" else
    reg5  when REG_DEST = "0101" else
    reg6  when REG_DEST = "0110" else
    reg7  when REG_DEST = "0111" else
    reg8  when REG_DEST = "1000" else
    reg9  when REG_DEST = "1001" else
    reg10 when REG_DEST = "1010" else
    reg11 when REG_DEST = "1011" else
    reg12 when REG_DEST = "1100" else
    reg13 when REG_DEST = "1101" else
    reg14 when REG_DEST = "1110" else
    reg15;
    
    bus_b_wire : 
    bus_b <= reg0 when REG_A = "0000" else
    reg1  when REG_A = "0001" else
    reg2  when REG_A = "0010" else
    reg3  when REG_A = "0011" else
    reg4  when REG_A = "0100" else
    reg5  when REG_A = "0101" else
    reg6  when REG_A = "0110" else
    reg7  when REG_A = "0111" else
    reg8  when REG_A = "1000" else
    reg9  when REG_A = "1001" else
    reg10 when REG_A = "1010" else
    reg11 when REG_A = "1011" else
    reg12 when REG_A = "1100" else
    reg13 when REG_A = "1101" else
    reg14 when REG_A = "1110" else
    reg15;
    
    bus_c_wire : 
    bus_c <= reg0 when REG_B = "0000" else
    reg1  when REG_B = "0001" else
    reg2  when REG_B = "0010" else
    reg3  when REG_B = "0011" else
    reg4  when REG_B = "0100" else
    reg5  when REG_B = "0101" else
    reg6  when REG_B = "0110" else
    reg7  when REG_B = "0111" else
    reg8  when REG_B = "1000" else
    reg9  when REG_B = "1001" else
    reg10 when REG_B = "1010" else
    reg11 when REG_B = "1011" else
    reg12 when REG_B = "1100" else
    reg13 when REG_B = "1101" else
    reg14 when REG_B = "1110" else
    reg15;


end rtl;
