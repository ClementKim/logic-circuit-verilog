`timescale 1ns/1ps
module tb_top();
    reg [0:7] initialized;
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
        initialized = 8'b00000000;
        clk = 1;
        n_clk = 0;
        reset = 1;
        
        A_in = initialized;
        repeat (256) begin
            repeat (256) begin
                #20
                A_in = A_out;
            end
            #20
            initialized = initialized + 1'b1;
            A_in = initialized;
            reset = 1;
        end
        $stop;
    end
endmodule

