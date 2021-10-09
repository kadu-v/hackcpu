`include "hack_core.v"
`include "hack_ram.v"
`include "hack_rom.v"


module hack_cpu_top (
    input wire clk,
    input wire xrst
);

// rom
wire [15:0] inst;

// core
wire [15:0] out_m, wirte_m, addr_m, pc;

// ram
wire [15:0] in_m;

// rom
hack_rom hack_rom_0(
    .clk        (   clk     ),
    .addr       (   pc      ),

    .out_data   (   inst    ) 
);

// core
hack_core hack_core_0(
    .clk        (   clk         ),
    .xrst       (   xrst        ),
    .inst       (   inst        ),
    .in_m       (   in_m        ),

    .out_m      (   out_m       ),
    .write_m    (   write_m     ),
    .addr_m     (   addr_m      ),
    .pc         (   pc          )
);

// ram
hack_ram hack_ram_0(
    .clk        (   clk     ),
    .write_en   (   write_m ),
    .addr       (   pc      ),
    .in_data    (   out_m   ),

    .out_data   (   in_m    )   
);

endmodule