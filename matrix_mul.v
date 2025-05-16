module matrix_mul (
    input wire clk,
    input wire rst,
    input wire start,

    input wire [7:0] A00, A01, A10, A11,
    input wire [7:0] B00, B01, B10, B11,

    output reg [15:0] C00, C01, C10, C11,
    output reg done
);

    reg [1:0] state;

    localparam IDLE = 2'b00,
               CALC = 2'b01,
               DONE = 2'b10;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
            C00 <= 0; C01 <= 0; C10 <= 0; C11 <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    if (start)
                        state <= CALC;
                end

                CALC: begin
                    C00 <= A00 * B00 + A01 * B10;
                    C01 <= A00 * B01 + A01 * B11;
                    C10 <= A10 * B00 + A11 * B10;
                    C11 <= A10 * B01 + A11 * B11;
                    state <= DONE;
                end

                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
