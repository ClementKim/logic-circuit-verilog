module gene_net(
    input [0:7] status,
    input clk,
    input n_clk,
    output [0:7] next_status
);
    reg [0:7] temp;

	always @(posedge clk or posedge n_clk) begin
		if (clk) begin
			temp = status;
		end else begin
    		temp[0] = ~status[2] & status[6] & ~status[7];
		    temp[1] = (status[4] | status[5]) & ~status[7];
    		temp[2] = status[7];
    		temp[3] = status[1] & ~status[6];
    		temp[4] = status[1] | status[3];
    		temp[5] = status[2] & ~status[7];
    		temp[6] = status[1] & ~status[7];
    		temp[7] = ~(status[0] | status[1]) & (status[3] | status[6]);
    	end
    end
   	
   	assign next_status = temp;

endmodule
