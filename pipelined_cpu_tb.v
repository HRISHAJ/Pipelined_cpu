`timescale 1ns / 1ps
`timescale 1ns / 1ps

module pipelined_cpu_tb;

    reg clk;
    reg reset;

    // Instantiate DUT
    pipelined_cpu uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #20;
        reset = 0;

        // Let CPU run
        #500;

        $finish;
    end

endmodule

