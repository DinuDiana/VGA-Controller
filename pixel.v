module pixel (	
					input clk,	 				//clock from FPGA – 50MHz
					//////////////////////USER INPUT///////////////////////
					input mode,					//selects the resolution we want the image to be displayed on 
														//(800 X 600 or 640 X 480)
					input rst, 
					input move_x_poz, 		//user input for movement of displayed geometric form to the right
					input move_y_poz, 		//user input for movement of displayed geometric form up
					input move_x_neg, 		//user input for movement of displayed geometric form to the left
					input move_y_neg,			//user input for movement of displayed geometric form down
					///////////////////////output for other modules//////////////
					output [10:0] xpos, 		//horizontal position
					output [10:0] ypos,		//vertical position
					//////////////////////VGA SIGNALS//////////////////////
					output disp_active,		//synchronization signal that indicates if the displayed pixel is in the 
														//active area of the display or in the back or front porch
					output [7:0] R, G, B,	//4 bit output for the red, green and blue pixel which dictates the color 
														//of the displayed object
					output hsync, 				//horizontal sync – it activates after the active and the front porch areas 
														//of pixels were displayed horizontally and stays active until it reaches 
														//the back porch area
					output vsync,				//vertical sync – it activates after the active and the front porch areas 
														//of pixels were displayed vertically and stays active until it reaches the 
														//back porch area
					output hsync_neg, 		//to be removed; has the same functionality as hsync, but it functions in 
														//direct logic
					output vsync_neg			//to be removed; has the same functionality as vsync, but it functions in 
														//direct logic
					);

////local registers/////
reg [10:0] i=0, j=0;
localparam [10:0] x0=50, y0=50, x1=100, y1=100;
reg [10:0] a, b;

reg [7:0] R_in_1 = 8'b1111_0101;
reg [7:0] G_in_1 = 8'b0111_1000;
reg [7:0] B_in_1 = 8'b0110_0100;

wire clock;

always @ (posedge clock)
	case (mode)
		0: begin a <= 640; b <= 480; end
		1: begin a <= 800; b <= 600; end
		default: begin a <= 800; b <= 600; end
	endcase

	//for a single pixel	
/*assign R = (disp_active==1) ? ( (xpos==x1 && ypos==y1) ? R_in : 8'b0000_0000) : 8'b0000_0000;		
assign G = (disp_active==1) ? ( (xpos==x1 && ypos==y1) ? G_in : 8'b0000_0000) : 8'b0000_0000;
assign B = (disp_active==1) ? ( (xpos==x1 && ypos==y1) ? B_in : 8'b0000_0000) : 8'b0000_0000;*/

	//for a rectangle
assign R = (disp_active==1) ? ( ((xpos<x1 && xpos>x0) && (ypos<y1 && ypos>y0)) ? R_in_1 : 8'b0000_0000) : 8'b0000_0000;	
assign G = (disp_active==1) ? ( ((xpos<x1 && xpos>x0) && (ypos<y1 && ypos>y0)) ? G_in_1 : 8'b0000_0000) : 8'b0000_0000;
assign B = (disp_active==1) ? ( ((xpos<x1 && xpos>x0) && (ypos<y1 && ypos>y0)) ? B_in_1 : 8'b0000_0000) : 8'b0000_0000;
	
	//remove comment to move rectangle
/*
always @ (posedge clock_movement)
		if (move_x_poz==0) 
			if (i==(a-x0))
				i <= 0;		
			else
				i <= i + 2;
		else if (move_x_neg==0)
				if (i==0)
					i <= a; 
				else
					i <= i - 1;
		else 
			i <= i;

always @ (posedge clock_movement)
		if (move_y_poz==0) 
			if (j==(b-y0))
				j <= 0;
			else
				j <= j + 2;
		else if (move_y_neg==0)
				if (j==0)
					j <= b; 
				else
					j <= j - 1;
		else 
			j <= j;
		
assign R = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? R_in_1 : 8'b0000_0000) : 8'b0000_0000;
assign G = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? G_in_1 : 8'b0000_0000) : 8'b0000_0000;
assign B = (disp_active==1) ? ( ((xpos<(x1+i) && xpos>(x0+i)) && (ypos<(y1+j) && ypos>(y0+j))) ? B_in_1 : 8'b0000_0000) : 8'b0000_0000;
*/
assign hsync_neg = ~hsync;
assign vsync_neg = ~vsync;
	
ceas c (clk, mode, clock);
divizor_simplu #(17) d1 (clk, clock_movement);
choose_sync sincr(clock, rst, mode, xpos, ypos, vsync, hsync, disp_active);

endmodule
