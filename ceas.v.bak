module ceas (input clock, input mode, output out);

wire clock_25;

/*
always @ (posedge clock)
	case (mode)
		0: out <= clock_25;
		1: out <= clock;
		default: out <= clock;
	endcase 
*/	

assign out = (mode==1) ? clock : clock_25;

divizor_simplu #(0) d(clock, clock_25);

endmodule 