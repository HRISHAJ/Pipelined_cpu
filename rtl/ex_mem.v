`timescale 1ns / 1ps

module ex_mem(
input wire clk,
input wire reset,
input wire [31:0] alu_res_in,
input wire [31:0] rd2_in,
input wire [4:0] rd_in,
input wire reg_we_in,
input wire mem_we_in,
input wire mem_to_reg_in,

output reg [31:0] alu_res_out,
output reg [31:0] rd2_out,
output reg [4:0] rd_out,
output reg reg_we_out,
output reg mem_we_out,
output reg mem_to_reg_out
    );
    
     always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_res_out    <= 0;
            rd2_out        <= 0;
            rd_out         <= 0;
            reg_we_out     <= 0;
            mem_we_out     <= 0;
            mem_to_reg_out <= 0;
        end else begin
            alu_res_out    <= alu_res_in;
            rd2_out        <= rd2_in;
            rd_out         <= rd_in;
            reg_we_out     <= reg_we_in;
            mem_we_out     <= mem_we_in;
            mem_to_reg_out <= mem_to_reg_in;
        end
    end
endmodule
