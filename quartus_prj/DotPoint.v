module DotPoint
(
	input No,
	input clock,
	output reg[15:0] Dot_R,
	output reg[3:0] Dot_C
);

reg[3:0] count;

always@(posedge clock)
begin
	if(count < 4'hf)
		count <= count +1'b1;
	else
	begin
		count <= 4'h0;
	end
	Dot_C = count;
end

always@ (posedge clock)
begin
	if(No == 0)	// lock;
		case(count)
			/*4'h0:Dot_R=16'b1111111111111111;
			4'h1:Dot_R=16'b1111111111111111;
			4'h2:Dot_R=16'b1100000001111111;
			4'h3:Dot_R=16'b1101111101111111;
			4'h4:Dot_R=16'b1101111100011111;
			4'h5:Dot_R=16'b1101111101100111;
			4'h6:Dot_R=16'b1101111101111011;
			4'h7:Dot_R=16'b1101111101111101;
			4'h8:Dot_R=16'b1101111101111101;
			4'h9:Dot_R=16'b1101111101111011;
			4'ha:Dot_R=16'b1101111101100111;
			4'hb:Dot_R=16'b1101111100011111;
			4'hc:Dot_R=16'b1101111101111111;
			4'hd:Dot_R=16'b1100000001111111;
			4'he:Dot_R=16'b1111111111111111;
			4'hf:Dot_R=16'b1111111111111111;*/
			
		endcase
	else if(No == 1)
		case(count)
			/*4'h0:Dot_R=16'b1111111111111111;
			4'h1:Dot_R=16'b1111111111111111;
			4'h2:Dot_R=16'b1100000001111111;
			4'h3:Dot_R=16'b1101111101111111;
			4'h4:Dot_R=16'b1101111100001111;
			4'h5:Dot_R=16'b1101111101110011;
			4'h6:Dot_R=16'b1101111101111101;
			4'h7:Dot_R=16'b1101111101111110;
			4'h8:Dot_R=16'b1101111101111110;
			4'h9:Dot_R=16'b1101111101111101;
			4'ha:Dot_R=16'b1101111101110011;
			4'hb:Dot_R=16'b1101111101111111;
			4'hc:Dot_R=16'b1101111101111111;
			4'hd:Dot_R=16'b1100000001111111;
			4'he:Dot_R=16'b1111111111111111;
			4'hf:Dot_R=16'b1111111111111111;*/
		endcase
end
endmodule
