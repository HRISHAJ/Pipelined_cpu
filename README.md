# Pipelined RISC-V Processor

This repository contains the RTL design of a 5-stage pipelined RISC-V processor implemented in Verilog. The project focuses on translating the RISC-V ISA into a synthesizable microarchitecture with a structured datapath, control path, and pipeline control logic.
The design is simulation-verified and follows standard RTL coding practices used in semiconductor front-end design.

Pipeline: IF → ID → EX → MEM → WB

Design Objectives

Implement a functional RISC-V microarchitecture at RTL.

Demonstrate pipeline operation with inter-stage registers and control propagation.

Handle data hazards using a dedicated hazard detection mechanism.

Verify correctness through simulation and waveform-based debugging.

Maintain modular, synthesizable Verilog suitable for ASIC/FPGA workflows.

Supported ISA

RV32I (subset)

Arithmetic/Logical: ADD, SUB, AND, OR, etc.

Immediate: ADDI, ANDI

Memory: LW, SW

Control: BEQ, BNE, JAL/JALR (if implemented)

(Adjust based on your implementation.)

Microarchitecture
Pipeline Stages

IF: Instruction fetch, PC update, PC+4 logic.

ID: Instruction decode, register file read, immediate generation, control generation.

EX: ALU operations, address calculation, branch evaluation.

MEM: Data memory access for loads/stores.

WB: Write-back to register file from ALU or memory.

Datapath & Control

Modular datapath blocks (ALU, register file, muxes, pipeline registers).

Centralized control unit generating stage-wise control signals.

Clean separation of combinational and sequential logic.

Hazard Handling

Hazard Detection Unit identifies data dependencies between pipeline stages.

Load-use hazards are resolved using stalling and control suppression to maintain correctness.
(Forwarding can be added as a future enhancement.)

Verification

Simulation-based functional verification using custom testbenches.

Validated arithmetic operations, memory access, control flow, and hazard scenarios.

Debugging performed through waveform analysis of pipeline registers and control signals.

Tools & Methodology

HDL: Verilog

Design: Modular RTL, synthesizable coding style

Verification: Testbenches, waveform debugging

Documentation: Block diagrams and pipeline flow

Limitations & Future Work

Simulation-only (no synthesis or timing analysis yet).

No cache or advanced memory hierarchy.

Planned enhancements: forwarding unit, branch prediction, CSR/exception support, PPA analysis.

Professional Relevance

This project demonstrates industry-relevant skills in VLSI front-end design, CPU microarchitecture, RTL coding, hazard analysis, and functional verification, reflecting practical understanding of mapping ISA specifications to hardware implementations.

Schematic of 32-bit Pipelined RISC-V Processor

<img width="1844" height="573" alt="image" src="https://github.com/user-attachments/assets/1cb85a9d-ce0a-4809-8e4d-b0ca4d53a637" />

