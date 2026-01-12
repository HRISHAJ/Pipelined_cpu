# Pipelined RISC-V Processor


This project implements a 32-bit, 5-stage pipelined RISC-V processor using Verilog RTL. The design follows standard microarchitectural principles and supports arithmetic, memory, and branch instructions with hazard detection, data forwarding, and branch handling. 

Architecture
Pipeline Stages: IF → ID → EX → MEM → WB
Instruction fetch and decode with control generation
ALU execution and branch evaluation
Memory access for load/store
Write-back to register file
Pipeline Registers: IF/ID, ID/EX, EX/MEM, MEM/WB
Supported Instructions
Arithmetic: ADD, SUB, ADDI
Memory: LW, SW
Branch: BEQ, BNE

Hazard Management
Data Hazards: Forwarding from EX/MEM and MEM/WB stages
Load-Use Hazards: Automatic stall insertion
Control Hazards: Branch decision in EX stage with pipeline flush and PC redirection

Key Modules
pc, imem, if_id, reg_file, imm_gen, control_unit, id_ex, alu, forwarding_unit, hazard_unit, ex_mem, write_mem, mem_wb, pipelined_cpu

Schematic of 32-bit Pipelined RISC-V Processor

<img width="1844" height="573" alt="image" src="https://github.com/user-attachments/assets/1cb85a9d-ce0a-4809-8e4d-b0ca4d53a637" />

