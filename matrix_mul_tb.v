//`timescale 1ns/1ps

module matrix_mul_tb;

    reg clk;
    reg rst;
    reg start;

    reg [7:0] A00, A01, A10, A11;
    reg [7:0] B00, B01, B10, B11;

    wire [15:0] C00, C01, C10, C11;
    wire done;

    // Instantiate DUT
    matrix_mul dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A00(A00), .A01(A01), .A10(A10), .A11(A11),
        .B00(B00), .B01(B01), .B10(B10), .B11(B11),
        .C00(C00), .C01(C01), .C10(C10), .C11(C11),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("matrix_mul.vcd");   // For VCS / GTKWave
        $dumpvars(0, matrix_mul_tb);

        clk = 0;
        rst = 1;
        start = 0;

        A00 = 0; A01 = 0; A10 = 0; A11 = 0;
        B00 = 0; B01 = 0; B10 = 0; B11 = 0;

        #10;
        rst = 0;

        // Provide matrices
        A00 = 8'd1; A01 = 8'd2;
        A10 = 8'd3; A11 = 8'd4;

        B00 = 8'd5; B01 = 8'd6;
        B10 = 8'd7; B11 = 8'd8;

        #10;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;

        $display("\n=== Matrix C = A x B ===");
        $display("C00 = %0d", C00);
        $display("C01 = %0d", C01);
        $display("C10 = %0d", C10);
        $display("C11 = %0d", C11);
        $display("========================\n");
        

        #10;
        $finish;
    end

endmodule
