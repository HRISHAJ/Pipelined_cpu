`timescale 1ns / 1ps

module if_id(
    input wire clk,
    input wire reset,
    input wire flush,             
    input wire ifid_write_in,      
    input wire [31:0] pc_plus4_in,
    input wire [31:0] instr_in,

    output reg [31:0] pc_plus4_out,
    output reg [31:0] instr_out
  
);

always @(posedge clk) begin
    if (reset || flush) begin
        pc_plus4_out <= 32'b0;
        instr_out    <= 32'b0;   
    end
    else if (ifid_write_in) begin
        pc_plus4_out <= pc_plus4_in;
        instr_out    <= instr_in;
        
    end
   
end

endmodule
