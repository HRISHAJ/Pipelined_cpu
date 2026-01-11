`timescale 1ns / 1ps

module imm_gen(
    input wire [31:0] instr,
    output wire [31:0] imm,
    output wire [31:0] imm_b
);

    // B-type immediate
    
    assign imm_b = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};

    // I-type or S-type immediate
    assign imm = (instr[6:0] == 7'b0100011) ?   // S-type
                 {{20{instr[31]}}, instr[31:25], instr[11:7]} :
                 {{20{instr[31]}}, instr[31:20]};              // I-type

endmodule
