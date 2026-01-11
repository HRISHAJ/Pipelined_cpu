`timescale 1ns / 1ps

module pipelined_cpu(
    input wire clk,
    input wire reset
);

    
    //wire ifid_write = ~stall;
    wire stall = 1'b0;
    wire pc_enable = 1'b1;
    wire ifid_write= 1'b1;
    assign pc_enable = ~stall;
    assign ifid_write = ~stall;

  
    // IF stage

    wire [31:0] pc;
    wire [31:0] pc_next;
    wire [31:0] instr;
    wire [31:0] pc_plus4;

    assign pc_plus4 = pc + 32'd4;

   
    // IF/ID
 
    wire [31:0] ifid_pc;
    wire [31:0] ifid_instr;

   
    // ID stage
    
    wire [4:0] rs1, rs2, rd;
    wire [31:0] rd1, rd2;
    wire [31:0] imm, imm_b;

    assign rs1 = ifid_instr[19:15];
    assign rs2 = ifid_instr[24:20];
    assign rd  = ifid_instr[11:7];

   
    // Control
   
    wire reg_we, alu_src, mem_we, mem_to_reg, branch, branch_ne;
    wire [2:0] alu_ctrl;

    
    // Branch logic
    
    wire [31:0] idex_pc_plus4, idex_imm_b;
    wire take_branch;
    wire flush;

    wire [31:0] pc_branch;
    assign pc_branch = idex_pc_plus4 + idex_imm_b;
    assign pc_next   = take_branch ? pc_branch : pc_plus4;
    assign flush     = take_branch;

    
    // PC
  
    pc pc_inst(
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_enable(pc_enable),
        .pc(pc)
    );
    
    // Instruction Memory
    
    imem imem_inst(
        .addr(pc),
        .instr(instr)
    );

 
    // IF/ID Register

    if_id if_id_inst(
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .pc_plus4_in(pc_plus4),
        .instr_in(instr),
        .ifid_write_in(ifid_write),
        .pc_plus4_out(ifid_pc),
        .instr_out(ifid_instr)
    );

   
    // Register File

    wire [4:0]  rd_wb;
    wire [31:0] wb_data;
    wire        reg_we_wb;

    reg_file reg_f_inst(
        .clk(clk),
        .we(reg_we_wb),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd_wb),
        .rd1(rd1),
        .rd2(rd2),
        .wd(wb_data)
    );

  
    // Immediate Generator
  
    imm_gen imm_inst(
        .instr(ifid_instr),
        .imm(imm),
        .imm_b(imm_b)
    );


    // Control Unit

    control_unit control_inst(
        .opcode(ifid_instr[6:0]),
        .func3(ifid_instr[14:12]),
        .func7(ifid_instr[31:25]),
        .reg_we(reg_we),
        .alu_src(alu_src),
        .alu_ctrl(alu_ctrl),
        .mem_we(mem_we),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .branch_ne(branch_ne)
    );


    // ID/EX

    wire [4:0]  idex_rs1, idex_rs2, idex_rd;
    wire [31:0] idex_rd1, idex_rd2, idex_imm;
    wire        idex_reg_we, idex_alu_src;
    wire [2:0]  idex_alu_ctrl;
    wire        idex_mem_we, idex_mem_to_reg;
    wire        idex_branch, idex_branch_ne;

    id_ex id_exreg (
        .clk(clk),
        .reset(reset),
        .flush(flush),
        .stall(stall),

        .rd1_in(rd1),
        .rd2_in(rd2),
        .imm_in(imm),
        .imm_b_in(imm_b),
        .pc_plus4_in(ifid_pc),
        .rd_in(rd),
        .rs1_in(rs1),
        .rs2_in(rs2),

        .reg_we_in(reg_we),
        .alu_src_in(alu_src),
        .alu_ctrl_in(alu_ctrl),
        .mem_we_in(mem_we),
        .mem_to_reg_in(mem_to_reg),
        .branch_in(branch),
        .branch_ne_in(branch_ne),

        .rd1_out(idex_rd1),
        .rd2_out(idex_rd2),
        .imm_out(idex_imm),
        .imm_b_out(idex_imm_b),
        .pc_plus4_out(idex_pc_plus4),
        .rd_out(idex_rd),
        .rs1_out(idex_rs1),
        .rs2_out(idex_rs2),

        .reg_we_out(idex_reg_we),
        .alu_src_out(idex_alu_src),
        .alu_ctrl_out(idex_alu_ctrl),
        .mem_we_out(idex_mem_we),
        .mem_to_reg_out(idex_mem_to_reg),
        .branch_out(idex_branch),
        .branch_ne_out(idex_branch_ne)
    );


    // Branch Decision (EX)
    wire zero;
    assign take_branch = idex_branch &
                        ((~idex_branch_ne & zero) |
                         ( idex_branch_ne & ~zero));

    // Forwarding
    wire [1:0]  forward_a, forward_b;
    wire [31:0] exmem_alu_res, alu_in1, alu_in2;

    assign alu_in1 = (forward_a == 2'b10) ? exmem_alu_res :
                     (forward_a == 2'b01) ? wb_data :
                                             idex_rd1;

    assign alu_in2 = (forward_b == 2'b10) ? exmem_alu_res :
                     (forward_b == 2'b01) ? wb_data :
                                             idex_rd2;

 
    // ALU

    wire [31:0] alu_b, alu_result;
    assign alu_b = idex_alu_src ? idex_imm : alu_in2;

    alu alu_inst(
        .a(alu_in1),
        .b(alu_b),
        .alu_ctrl(idex_alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );


    // EX/MEM
    wire [31:0] exmem_rd2;
    wire [4:0]  exmem_rd;
    wire        exmem_reg_we;
    wire        exmem_mem_we;
    wire        exmem_mem_to_reg;

    ex_mem ex_mem_reg(
        .clk(clk),
        .reset(reset),

        .alu_res_in(alu_result),
        .rd2_in(idex_rd2),
        .rd_in(idex_rd),

        .reg_we_in(idex_reg_we),
        .mem_we_in(idex_mem_we),
        .mem_to_reg_in(idex_mem_to_reg),

        .alu_res_out(exmem_alu_res),
        .rd2_out(exmem_rd2),
        .rd_out(exmem_rd),
        .reg_we_out(exmem_reg_we),
        .mem_we_out(exmem_mem_we),
        .mem_to_reg_out(exmem_mem_to_reg)
    );


    // Data Memory 

    wire [31:0] dmem_rd;

    write_mem wmem (
        .clk(clk),
        .mem_we(exmem_mem_we),
        .addr(exmem_alu_res),
        .wd(exmem_rd2),
        .rd(dmem_rd)
    );


    // MEM/WB

    wire [31:0] wb_alu_res;
    wire [31:0] wb_mem_data;
    wire        mem_to_reg_wb;

    mem_wb mem_wb_inst(
        .clk(clk),
        .reset(reset),

        .alu_res_in(exmem_alu_res),
        .mem_data_in(dmem_rd),
        .rd_in(exmem_rd),

        .reg_we_in(exmem_reg_we),
        .mem_to_reg_in(exmem_mem_to_reg),

        .alu_res_out(wb_alu_res),
        .mem_data_out(wb_mem_data),
        .rd_out(rd_wb),
        .reg_we_out(reg_we_wb),
        .mem_to_reg_out(mem_to_reg_wb)
    );


    // Writeback MUX

    assign wb_data = mem_to_reg_wb ? wb_mem_data : wb_alu_res;


    // Forwarding Unit

    forwarding_unit frwd_inst(
        .idex_rs1(idex_rs1),
        .idex_rs2(idex_rs2),
        .exmem_rd(exmem_rd),
        .exmem_reg_we(exmem_reg_we),
        .exmem_mem_to_reg(exmem_mem_to_reg),
        .memwb_rd(rd_wb),
        .memwb_reg_we(reg_we_wb),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );


    // Hazard Unit 

    hazard_unit hazard_inst(
        .idex_mem_to_reg(idex_mem_to_reg),
        .idex_rd(idex_rd),
        .ifid_rs1(rs1),
        .ifid_rs2(rs2),
        .stall(stall)
    );

endmodule
