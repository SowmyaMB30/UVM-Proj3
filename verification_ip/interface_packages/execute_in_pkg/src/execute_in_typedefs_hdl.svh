//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains defines and typedefs to be compiled for use in
// the simulation running on the emulator when using Veloce.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
                                                                               

typedef enum bit [3:0] {
  ADD = 4'b0001,
  AND = 4'b0101,
  BR  = 4'b0000,
  JMP = 4'b1100,
  LD  = 4'b0010,
  LDI = 4'b1010,
  LDR = 4'b0110,
  LEA = 4'b1110,
  NOT = 4'b1001,
  ST  = 4'b0011,
  STI = 4'b1011,
  STR = 4'b0111
}
 opcode_t;
typedef string op_string[opcode_t] = '{
  ADD: "ADD",
  AND: "AND",
  BR: "BR",
  JMP: "JMP",
  LD: "LD",
  LDI: "LDI",
  LDR: "LDR",
  LEA: "LEA",
  NOT: "NOT",
  ST: "ST",
  STI: "STI",
  STR: "STR"
};
 op_string;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

