`timescale 1ns/1ps
module tb_ABC();
    reg [0:7] A_in;
    wire [0:7] A_out;
    wire is_fixed;
    wire is_cycle;

    reg clk;
    reg n_clk;
    reg reset;

    always begin
        if (n_clk) begin
            reset = 0;
        end

        #10
        clk = ~clk;
        n_clk = ~n_clk;
    end

    gene_net gn(
        .status(A_in),
        .clk(clk),
        .n_clk(n_clk),
        .next_status(A_out)
    );

    fixed_point_checker fpc(
        .status(A_out),
        .clk(clk),
        .n_clk(n_clk),
        .reset(reset),
        .result(is_fixed)
    );

    cycle_checker cc(
        .status(A_out),
        .clk(clk),
        .n_clk(n_clk),
        .reset(reset),
        .result(is_cycle)
    );

    initial begin
        clk = 1;
        n_clk = 0;
        reset = 1;

        A_in = 8'b00000000;
        repeat (10) begin
            #20
            A_in = A_out;
        end

        reset = 1;
        A_in = 8'b00001111;
        repeat (10) begin
            #20
            A_in = A_out;
        end

        reset = 1;
        A_in = 8'b11110000;
        repeat (10) begin
            #20
            A_in = A_out;
        end

        reset = 1;
        A_in = 8'b10101010;
        repeat (10) begin
            #20
            A_in = A_out;
        end

        reset = 1;
        A_in = 8'b01010101;
        repeat (10) begin
            #20
            A_in = A_out;
        end

        reset = 1;
        A_in = 8'b11111111;
        repeat (10) begin
            #20
            A_in = A_out;
        end
        $stop;
    end
endmodule
