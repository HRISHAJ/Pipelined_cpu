# Pipelined RISC-V Processor


This repository contains the RTL design of a 5-stage pipelined RISC-V processor implemented in Verilog. The project focuses on translating the RISC-V ISA into a synthesizable microarchitecture with a structured datapath, control path, hazard detection, and data forwarding logic.
The design is simulation-verified and follows standard front-end VLSI design practices.

Pipeline: IF → ID → EX → MEM → WB

Design Objectives
Implement a functional RISC-V microarchitecture at RTL.
Demonstrate pipelined execution with inter-stage registers and control propagation.
Resolve data hazards using forwarding and stalling mechanisms.
Verify correctness through simulation and waveform-based debugging.
Maintain modular, synthesizable Verilog suitable for ASIC/FPGA workflows.

Supported ISA
RV32I (subset)

Arithmetic/Logical: ADD, SUB.
Immediate: ADDI
Memory: LW, SW
Control: BEQ, BNE.

Microarchitecture
Pipeline Stages
IF: Instruction fetch, PC update, PC+4 logic.
ID: Instruction decode, register file read, immediate generation, control signal generation.
EX: ALU operations, effective address computation, branch condition evaluation.
MEM: Data memory access for load/store instructions.
WB: Write-back to register file from ALU or memory.

Datapath & Control
Modular datapath blocks: ALU, register file, multiplexers, pipeline registers.
Centralized control unit with stage-wise control signal propagation.
Clear separation of combinational and sequential logic for synthesizability.

Hazard Handling & Forwarding
Data Hazards
Implemented a Forwarding Unit to resolve RAW (Read-After-Write) hazards by bypassing results from:
EX/MEM → EX stage
MEM/WB → EX stage
This significantly reduces pipeline stalls for dependent ALU instructions.

Load-Use Hazards
A Hazard Detection Unit identifies cases where forwarding is insufficient (e.g., load followed immediately by a dependent instruction).
In such cases, the pipeline is stalled and control signals are suppressed to preserve correctness.

Verification
Simulation-based functional verification using custom testbenches.

Tools & Methodology
HDL: Verilog
Design: Modular RTL, synthesizable coding style
Verification: Testbenches, waveform debugging

Professional Relevance

This project demonstrates industry-relevant skills in CPU microarchitecture, RTL design, hazard analysis, data forwarding, and functional verification, reflecting a practical understanding of mapping RISC-V ISA specifications into pipelined hardware implementations.
Schematic of 32-bit Pipelined RISC-V Processor

<img width="1844" height="573" alt="image" src="https://github.com/user-attachments/assets/1cb85a9d-ce0a-4809-8e4d-b0ca4d53a637" />

