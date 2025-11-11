typedef enum bit [3:0] {
  ADD = 4'b0001,
  AND = 4'b0101,
  BR  = 4'b0000,
  JMP = 4'b1100,
  JSR = 4'b0100,
  LD  = 4'b0010,
  LDI = 4'b1010,
  LDR = 4'b0110,
  LEA = 4'b1110,
  NOT = 4'b1001,
  RTI = 4'b1000,
  ST  = 4'b0011,
  STI = 4'b1011,
  STR = 4'b0111,
  TRAP = 4'b1111,
  RESERVED = 4'b1101
} opcode_t;

typedef enum bit [1:0] {
  CONTROL,
  ALU,
  MEMORY,
  PRIVILEGE
} optype_t;

typedef struct packed {
  opcode_t opcode;
  optype_t optype;

  bit mod_cf;
  bit use_cf;

  bit use_dr;
  bit use_sr1;
  bit use_sr2;
  bit use_imm;

  bit[2:0] dr;
  bit[2:0] sr1;
  bit[2:0] sr2;
  bit[15:0] imm_ext;
} decoded_insn_t;
