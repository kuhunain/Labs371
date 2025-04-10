module parking_lot (
    input  logic clk, reset,
    input  logic outer_switch, inner_switch,
    output logic outer_led, inner_led,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    
    logic enter, exit;
    logic [4:0] count;

    
    car_detecting fsm (
        .clk(clk),
        .reset(reset),
        .outer(outer_switch),
        .inner(inner_switch),
        .enter(enter),
        .exit(exit)
    );

    
    upCounter counter (
        .clk(clk),
        .reset(reset),
        .incr(enter),
        .decr(exit),
        .out(count)
    );

    // led to switch
    assign outer_led = outer_switch;
    assign inner_led = inner_switch;

    
    logic [6:0] digit0, digit1;
    always_comb begin
		  // means parking lot is CLEAR
        if (count == 0) begin
            HEX0 = hex_all_num(0);
            HEX1 = hex_blank();
            HEX2 = hex_letter_r();
            HEX3 = hex_letter_a();
            HEX4 = hex_letter_e();
            HEX5 = hex_letter_c();
		  // means parking lot is FULL
        end else if (count == 16) begin
            HEX0 = hex_blank();
            HEX1 = hex_blank();
            HEX2 = hex_letter_l();
            HEX3 = hex_letter_l();
            HEX4 = hex_letter_u();
            HEX5 = hex_letter_f();
		  // show count
        end else begin
            HEX0 = hex_all_num(count % 10);
            HEX1 = hex_all_num(count / 10);
            HEX2 = hex_blank();
            HEX3 = hex_blank();
            HEX4 = hex_blank();
            HEX5 = hex_blank();
        end
    end

    
    function logic [6:0] hex_all_num(input int val);
        case (val)
            0: hex_all_num = 7'b1000000;
            1: hex_all_num = 7'b1111001;
            2: hex_all_num = 7'b0100100;
            3: hex_all_num = 7'b0110000;
            4: hex_all_num = 7'b0011001;
            5: hex_all_num = 7'b0010010;
            6: hex_all_num = 7'b0000010;
            7: hex_all_num = 7'b1111000;
            8: hex_all_num = 7'b0000000;
            9: hex_all_num = 7'b0010000;
            default: hex_all_num = 7'b1111111;
        endcase
    endfunction

    function logic [6:0] hex_blank(); return 7'b1111111; endfunction
    function logic [6:0] hex_letter_c(); return 7'b1000110; endfunction
    function logic [6:0] hex_letter_l(); return 7'b1000111; endfunction
    function logic [6:0] hex_letter_e(); return 7'b0000110; endfunction
    function logic [6:0] hex_letter_a(); return 7'b0001000; endfunction
    function logic [6:0] hex_letter_r(); return 7'b0101111; endfunction
    function logic [6:0] hex_letter_u(); return 7'b1000001; endfunction
    function logic [6:0] hex_letter_f(); return 7'b0001110; endfunction
endmodule
