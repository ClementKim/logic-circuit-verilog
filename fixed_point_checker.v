module fixed_point_checker(
    input [0:7] status,
    input clk,
    input n_clk, // negative clock
    input reset,
    output result
);
    
    reg [0:7] prev_status;
    reg temp_rst;

    always @(posedge clk or posedge n_clk or posedge reset) begin
        if (reset) begin // case of reset is 1
            temp_rst <= 1'b0;
            prev_status <= status;
        end else if (n_clk) begin // case of clk is 0 (n_clk is 1)
            prev_status <= status;
        end else begin // case of clk is 1
            if (prev_status == status) begin
                temp_rst <= 1'b1;
            end
        end
    end

    assign result = temp_rst;

endmodule
