`timescale 1ns / 1ps

module id_ex (
    input wire clk,
    input wire reset,
    input wire flush,
    input wire stall,

    input wire [31:0] rd1_in,
    input wire [31:0] rd2_in,
    input wire [31:0] imm_in,
    input wire [31:0] imm_b_in,
    input wire [31:0] pc_plus4_in,
    input wire [4:0] rd_in,
    input wire [4:0] rs1_in,
    input wire [4:0] rs2_in,

    input wire reg_we_in,
    input wire alu_src_in,
    input wire [2:0] alu_ctrl_in,
    input wire mem_we_in,
    input wire mem_to_reg_in,
    input wire branch_in,
    input wire branch_ne_in,

    output reg [31:0] rd1_out,
    output reg [31:0] rd2_out,
    output reg [31:0] imm_out,
    output reg [31:0] imm_b_out,
    output reg [31:0] pc_plus4_out,
    output reg [4:0] rd_out,
    output reg [4:0] rs1_out,
    output reg [4:0] rs2_out,

    output reg reg_we_out,

    output reg alu_src_out,
    output reg [2:0] alu_ctrl_out,
    output reg mem_we_out,
    output reg mem_to_reg_out,
    output reg branch_out,
    output reg branch_ne_out
);


always@(posedge clk)
begin
if(reset || flush || stall)
begin
            rd1_out <=0;
            rd2_out      <= 0;
            imm_out      <= 0;
            rd_out       <= 0;
            reg_we_out   <= 0;
            alu_src_out  <= 0;
            alu_ctrl_out <= 0;
            mem_we_out <= 0;
            mem_to_reg_out <=0;
            rs1_out <=0;
            rs2_out<=0;
            branch_out<=0;
            branch_ne_out<=0;
            pc_plus4_out <=0;
        end 
        else 
        begin
            rd1_out      <= rd1_in;
            rd2_out      <= rd2_in;
            imm_out      <= imm_in;
            rd_out       <= rd_in;
            reg_we_out   <= reg_we_in;
            alu_src_out  <= alu_src_in;
            alu_ctrl_out <= alu_ctrl_in;
            mem_we_out <= mem_we_in;
            mem_to_reg_out <=mem_to_reg_in;
            rs1_out<= rs1_in;
            rs2_out <=rs2_in;
            branch_ne_out <= branch_ne_in;
            branch_out <= branch_in;
            pc_plus4_out <=pc_plus4_in;
        end
end
endmodule