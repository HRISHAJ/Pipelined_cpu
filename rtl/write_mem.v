`timescale 1ns / 1ps

module write_mem(
input wire clk,
input wire mem_we,
input wire [31:0] addr,
input wire [31:0] wd,
output wire [31:0] rd
    );
    
    reg [31:0] mem [255:0];
    integer i;
initial begin
    for (i = 0; i < 256; i = i + 1)
        mem[i] = 32'b0;
end
    wire[7:0] word_add = addr[9:2];
    assign rd = mem[word_add];
    always @(posedge clk)
    begin
    if(mem_we)
    mem[word_add] <= wd;
    end
endmodule
