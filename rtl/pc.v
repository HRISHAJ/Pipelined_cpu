`timescale 1ns / 1ps

module pc(
input wire clk,
input wire reset,
input wire [31:0] pc_next,
input wire pc_enable,
output reg [31:0] pc
);

always@(posedge clk)
begin
if(reset)
pc <=32'h00000000;
else if(pc_enable)
begin
pc<= pc_next;
end
end
endmodule
