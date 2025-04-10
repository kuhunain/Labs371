/* Top-level module for LandsLand hardware connections to implement the parking lot system.*/

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, V_GPIO);

	input  logic		 CLOCK_50;	// 50MHz clock
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	// active low
	output logic [9:0] LEDR;
	inout  logic [35:0] V_GPIO;	// expansion header 0 (LabsLand board)
	
   // Internal signals for switches and LEDs
    logic outer_switch, inner_switch;
    logic outer_led, inner_led;

    // === GPIO pin assignments ===
    assign outer_switch = V_GPIO[24];     // Input from off-board switch
    assign inner_switch = V_GPIO[25];     // Input from off-board switch

    assign V_GPIO[34] = outer_led;        // Output to off-board LED
    assign V_GPIO[35] = inner_led;        // Output to off-board LED

    // Instantiate your parking lot system
    parking_lot lot (
        .clk(CLOCK_50),
        .reset(1'b0),                     // You can connect this to a KEY button if desired
        .outer_switch(outer_switch),
        .inner_switch(inner_switch),
        .outer_led(outer_led),
        .inner_led(inner_led),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

endmodule  // DE1_SoC
