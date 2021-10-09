`include "../design/hack_cpu_top.v"

`timescale 1ns/10ps

module test_hack_cpu ();

reg clk;
reg xrst;

initial begin
    clk <= 0;
    xrst <= 1;
end

hack_cpu_top hack_cpu_top(
    .clk    (   clk     ),
    .xrst   (   xrst    )
);

// 4MHz   -> 125ns
// 20MHz  -> 25ns
// 100Mhz -> 5ns

always #5 begin
    clk <= ~clk;
end
integer i;
initial begin
    $dumpfile("test_hack_cpu.vhd");
    $dumpvars(0, test_hack_cpu);
    for (i = 0; i < 5; i = i + 1)
        $dumpvars(1, hack_cpu_top.hack_ram_0.mem[i]);
    for (i = 0; i < 5; i = i + 1)
        $dumpvars(1, hack_cpu_top.hack_rom_0.mem[i]);
    #20
    xrst <= 0;
    #20
    xrst <= 1;
    #1000
    $finish;
end

endmodule