module ceas (input clock, 
				input mode, 
				output out);

wire clock_25;

assign out = (mode==1) ? clock : clock_25;

divizor_simplu #(0) d(clock, clock_25);

endmodule 