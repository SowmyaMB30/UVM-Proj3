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
                                                                               

typedef enum bit [3:0] {BR=4'b0000, ADD=4'b0001, LD=4'b0010, ST=4'b0011, AND=4'b0101, LDR=4'b0110, STR=4'b0111, NOT=4'b1001,   LDI=4'b1010, STI=4'b1011, JMP=4'b1100, LEA=4'b1110} op_t;
typedef bit [2:0] dest_f;
typedef bit [2:0] src1_f;
typedef bit [2:0] src2_f;
typedef bit [2:0] baser_f;
typedef bit [8:0] pcoffset9_f;
typedef bit [5:0] pcoffset6_f;
typedef bit [4:0] imm5_f;
typedef bit n_f;
typedef bit z_f;
typedef bit p_f;

// pragma uvmf custom additional begin
// pragma uvmf custom additional end

