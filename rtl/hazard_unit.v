`timescale 1ns / 1ps

module hazard_unit(
input wire idex_mem_to_reg,
input wire [4:0] idex_rd,
input wire [4:0] ifid_rs1,
input wire [4:0] ifid_rs2,
output wire stall 
    );
    assign stall = idex_mem_to_reg &&
              ((idex_rd == ifid_rs1) || (idex_rd == ifid_rs2)) &&
              (idex_rd != 0);
endmodule
