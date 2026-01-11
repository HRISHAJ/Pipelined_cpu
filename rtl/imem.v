`timescale 1ns / 1ps

module imem(
input wire [31:0] addr,
output wire [31:0] instr
    );
    reg [31:0] mem[0:255];
    initial begin
    $readmemh("C:/Users/shara/Documents/Hrisha/Vivado_projects/riscV/mem/imem.hex", mem);
    end
    wire [7:0] word_addr = addr[9:2];
    assign instr = mem[word_addr];
endmodule
