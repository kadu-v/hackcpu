`include "hack_ram.v"

module test_hack_ram ();
    reg clk, ld;
    reg [13:0] addr;
    reg [15:0] in_data;
    wire [15:0] out_data;

    hack_ram hack_ram(clk, ld, addr, in_data, out_data);

    initial begin
        $monitor("time %t, clock: %b, addr: %b, load: %b, in_data: %b, out_data: %b", $time, clk, addr, ld, in_data, out_data);
    end

    initial begin
        clk <= 0;
        ld <= 0;
        addr <= 0;
        in_data <= 0;
    end

    // #10の間隔でclkを発振
    always #10 begin
        clk <= ~clk;
    end

    always begin
        #10
            ld <= 1;
            addr <= 1;
            in_data <= 'b11111111;
        #10
            ld <= 0;
            addr <= 1;
            in_data <= 0;
        #10
            ld <= 1;
            addr <= 'b1000000000;
            in_data <= 'b00000011111;
        #10
            ld <= 0;
            addr <= 'b1000000000;
        #10
            $finish;
    end



endmodule