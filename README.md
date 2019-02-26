# VGA-Controller
VGA Controller for Altera DE1 FPGA Board - Verilog


This module has the purpose of creating a connection between the FPGA board and the monitor through a VGA cable. The module translates simple data (as rectangles or squares) so that they can be displayed on the monitor (the shapes can be moved using the switches on the FPGA board). It creates the proper synchronization signals that make the device recognize the data sent from the FPGA board and display it correctly.

module pixel (
              input clk, 		  //clock from FPGA – 50MHz  
              input mode,	    //selects the resolution we want the image to be displayed on   
                              //(800 X 600 or 640 X 480)  
              input mode_sync, 	//to be implemented, it selects the type of logic the monitor uses(direct //or reversed  
	            input rst, 		    //reset button   
	            input move_x_poz, 	//user input for movement of displayed geometric form to the right  
              input move_y_poz, 	//user input for movement of displayed geometric form up  
              input move_x_neg,	  //user input for movement of displayed geometric form to the left  
              input move_y_neg, 	//user input for movement of displayed geometric form down  
	            output [10:0] xpos, 	//horizontal position  
              output [10:0] ypos,	  //vertical position  
              output disp_active,	  //synchronization signal that indicates if the displayed pixel is in the  
                                    //active area of the display or in the back or front porch  
              output [4:0] R, G, B,	//4 bit output for the red, green and blue pixel which dictates the color   
                                    //of the displayed object  
              output hsync, 	      //horizontal sync – it activates after the active and the front porch areas   
                                    //of pixels were displayed horizontally and stays active until it reaches  
                                     //the back porch area  
              output vsync);        //vertical sync – it activates after the active and the front porch areas   
                                  //of pixels were displayed vertically and stays active until it reaches the   
                                  //back porch area  
             
