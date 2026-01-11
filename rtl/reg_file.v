`timescale 1ns / 1ps

module reg_file(
    input  wire        clk,
    input  wire        we,
    input  wire [4:0]  rs1,
    input  wire [4:0]  rs2,
    input  wire [4:0]  rd,
    input  wire [31:0] wd,
    output wire [31:0] rd1,
    output wire [31:0] rd2
);

    integer i;
    reg [31:0] regs [0:31];

    // Initialize registers to 0
    initial begin
        for (i = 0; i < 32; i = i + 1)
            regs[i] = 32'b0;
    end

    // Read ports 
    assign rd1 = (rs1 == 5'b00000) ? 32'b0 : regs[rs1];
    assign rd2 = (rs2 == 5'b00000) ? 32'b0 : regs[rs2];

    // Write port 
    always @(posedge clk) begin
        if (we && (rd != 5'b00000)) begin
            regs[rd] <= wd;
        end
    end

endmodule
