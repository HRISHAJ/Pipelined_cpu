`timescale 1ns / 1ps

module alu(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] alu_ctrl,
    output reg [31:0] result,
    output reg zero
);

always @(*) begin
    case (alu_ctrl)
        3'b000: result = a + b;   // ADD
        3'b001: result = a - b;   // SUB
        3'b010: result = a & b;   // AND
        3'b011: result = a | b;   // OR
        default: result = 32'b0;  // default
    endcase

    //zero flag for BEQ/BNE
    zero = (a == b) ? 1'b1 : 1'b0;
end

endmodule
