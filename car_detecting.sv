// singular parking lot car detection
// detects if car has entered or exited a parking spot
module car_detecting (
    input  logic clk, reset,
    input  logic outer, inner,
    output logic enter, exit);


	typedef enum logic [1:0] {
		NO_CAR    = 2'b00, // no car in lot
		ENTER = 2'b10, // outer signal 1, so car entering lot
		CAR  = 2'b11, // outer & inner 1, so car actively in lot
		EXIT   = 2'b01 // only inner block
	} state_type;
	
	state_type ps, ns;
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= NO_CAR;
	  else
			ps <= ns;
	end

 
	always_comb begin  
	  case (ps)
	  
		  NO_CAR:    ns = (outer && !inner) ? ENTER : NO_CAR;
        ENTER:     ns = (outer && inner) ? CAR : ENTER;
        CAR:       ns = (!outer && inner) ? EXIT : CAR;
        EXIT:      ns = (!outer && !inner) ? NO_CAR : EXIT;
        default:   ns = NO_CAR;
			
	  endcase
	end

	 // Output logic
	 always_comb begin
		  // Default outputs
		  enter = 1'b0;
		  exit = 1'b0;
		  
		  // Assert enter/exit signals for one clock cycle when transitioning from ENTERING/EXITING to IDLE
		  enter = (ps == EXIT && ns == NO_CAR);
		  exit  = (ps == EXIT && ns == NO_CAR);
	 end

endmodule