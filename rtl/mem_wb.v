`timescale 1ns / 1ps

module mem_wb(
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] alu_res_in,
    input  wire [31:0] mem_data_in,
    input  wire [4:0]  rd_in,
    input  wire        reg_we_in,
    input  wire        mem_to_reg_in,

    output reg  [31:0] alu_res_out,
    output reg  [31:0] mem_data_out,
    output reg  [4:0]  rd_out,
    output reg         reg_we_out,
    output reg         mem_to_reg_out
);

always @(posedge clk) begin
    if (reset) begin
        alu_res_out    <= 32'b0;
        mem_data_out   <= 32'b0;
        rd_out         <= 5'b0;
        reg_we_out     <= 1'b0;
        mem_to_reg_out <= 1'b0;
    end else begin
        alu_res_out    <= alu_res_in;
        mem_data_out   <= mem_data_in;
        rd_out         <= rd_in;
        reg_we_out     <= reg_we_in;
        mem_to_reg_out <= mem_to_reg_in;
    end
end

endmodule
