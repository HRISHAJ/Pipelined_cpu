`timescale 1ns / 1ps

module forwarding_unit(
input wire [4:0] idex_rs1,
input wire [4:0] idex_rs2,
input wire [4:0] exmem_rd,
input wire exmem_reg_we,
input wire exmem_mem_to_reg,
input wire [4:0] memwb_rd,
input wire memwb_reg_we,
output reg [1:0] forward_a,
output reg [1:0] forward_b
    );
    
    always @(*) begin
    forward_a = 2'b00;
    forward_b = 2'b00;

    // EX hazard (but not for loads!)
    if (exmem_reg_we && (exmem_rd != 5'b00000) && (exmem_rd == idex_rs1) && !exmem_mem_to_reg)
        forward_a = 2'b10;

    if (exmem_reg_we && (exmem_rd != 5'b00000) && (exmem_rd == idex_rs2) && !exmem_mem_to_reg)
        forward_b = 2'b10;

    // MEM hazard
    if (memwb_reg_we && (memwb_rd != 5'b00000) &&
        !(exmem_reg_we && (exmem_rd != 5'b00000) && (exmem_rd == idex_rs1)) &&
        (memwb_rd == idex_rs1))
        forward_a = 2'b01;

    if (memwb_reg_we && (memwb_rd != 5'b00000) &&
        !(exmem_reg_we && (exmem_rd != 5'b00000) && (exmem_rd == idex_rs2)) &&
        (memwb_rd == idex_rs2))
        forward_b = 2'b01;
end

endmodule
