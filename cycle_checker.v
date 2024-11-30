module cycle_checker(
    input [0:7] status,
    input clk,
    input n_clk,
    input reset,
    output result
);

    reg [7:0] idx1;
    reg [0:7] prev_status[0:255];
    reg temp_rst;

    integer idx2;

    always @(posedge clk or posedge n_clk or posedge reset) begin
        if (reset) begin
            for (idx2 = 0; idx2 < 256; idx2 = idx2 + 1) begin
                prev_status[idx2] = 8'b00000000;
            end

            temp_rst <= 1'b0;
            idx1 <= 8'b0;
        end else if (n_clk) begin
            prev_status[idx1] <= status;
            idx1 = (idx1 + 1'b1);
        end else begin
            for (idx2 = 0; idx2 < idx1; idx2 = idx2 + 1) begin
                if (prev_status[idx2] == status) begin
                    temp_rst = 1'b1;
                end
            end
        end
    end

    assign result = temp_rst;

endmodule
