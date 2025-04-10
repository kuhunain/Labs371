module parking_lot_tb;
    logic clk, reset;
    logic outer_switch, inner_switch;
    logic outer_led, inner_led;
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

    parking_lot dut (
        .clk(clk),
        .reset(reset),
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

    // clock
    parameter CLOCK_PERIOD = 20;
    initial begin
        clk = 0;
        forever #(CLOCK_PERIOD / 2) clk = ~clk;
    end

    // testbench
    initial begin
        $display("Starting testbench...");
        reset = 1;
        outer_switch = 0;
        inner_switch = 0;
        @(posedge clk);
        reset = 0;

        // 3 cars entering
        repeat (3) begin
            outer_switch = 1; @(posedge clk);
            inner_switch = 1; @(posedge clk);
            outer_switch = 0; @(posedge clk);
            inner_switch = 0; @(posedge clk);
            #(CLOCK_PERIOD);
        end

        // 2 cars exiting
        repeat (2) begin
            inner_switch = 1; @(posedge clk);
            outer_switch = 1; @(posedge clk);
            inner_switch = 0; @(posedge clk);
            outer_switch = 0; @(posedge clk);
            #(CLOCK_PERIOD);
        end

        // display "FULL"
        repeat (13) begin
            outer_switch = 1; @(posedge clk);
            inner_switch = 1; @(posedge clk);
            outer_switch = 0; @(posedge clk);
            inner_switch = 0; @(posedge clk);
            #(CLOCK_PERIOD);
        end

        // display "CLEAR"
        repeat (16) begin
            inner_switch = 1; @(posedge clk);
            outer_switch = 1; @(posedge clk);
            inner_switch = 0; @(posedge clk);
            outer_switch = 0; @(posedge clk);
            #(CLOCK_PERIOD);
        end

        $stop;
    end

endmodule
