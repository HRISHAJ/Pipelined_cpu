`timescale 1ns / 1ps

module control_unit(
    input wire [6:0] opcode,
    input wire [2:0] func3,
    input wire [6:0] func7,

    output reg reg_we,
    output reg alu_src,
    output reg [2:0] alu_ctrl,
    output reg mem_we,
    output reg mem_to_reg,
    output reg branch,
    output reg branch_ne
);

always @(*) begin
    // Default values 
    reg_we     = 1'b0;
    alu_src    = 1'b0;
    alu_ctrl   = 3'b000;
    mem_we     = 1'b0;
    mem_to_reg = 1'b0;
    branch     = 1'b0;
    branch_ne  = 1'b0;

    case (opcode)

        // R-type: ADD, SUB
        7'b0110011: begin
            reg_we  = 1'b1;
            alu_src = 1'b0;
            case ({func7, func3})
                {7'b0000000, 3'b000}: alu_ctrl = 3'b000; 
                {7'b0100000, 3'b000}: alu_ctrl = 3'b001; 
                default: alu_ctrl = 3'b000;
            endcase
        end

        // ADDI
        7'b0010011: begin
            reg_we  = 1'b1;
            alu_src = 1'b1;
            alu_ctrl = 3'b000; 
        end

        // LW
        7'b0000011: begin
            reg_we     = 1'b1;
            alu_src    = 1'b1;
            alu_ctrl   = 3'b000; 
            mem_to_reg = 1'b1;
        end

        // SW
        7'b0100011: begin
            reg_we   = 1'b0;
            alu_src  = 1'b1;
            alu_ctrl = 3'b000; 
            mem_we   = 1'b1;
        end

        // Branch: BEQ, BNE
        7'b1100011: begin
            branch   = 1'b1;
            alu_src  = 1'b0;
            alu_ctrl = 3'b001; 
            case (func3)
                3'b000: branch_ne = 1'b0; 
                3'b001: branch_ne = 1'b1; 
                default: branch_ne = 1'b0;
            endcase
        end

        default: begin
        end
    endcase
end

endmodule
