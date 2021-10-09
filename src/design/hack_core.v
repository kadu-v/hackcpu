`include "hack_decoder.v"
`include "hack_mux.v"
`include "hack_register.v"
`include "hack_alu.v"
`include "hack_pc.v"
`include "hack_pc_load.v"

module hack_core (
    input wire          clk,
    input wire          xrst,
    input wire [15:0]   inst,
    input wire [15:0]   in_m,

    output wire [15:0]  out_m,
    output wire         write_m,
    output wire [15:0]  addr_m,
    output wire [15:0]  pc
);

// decoder
wire j1, j2, j3, mux_sel0, mux_sel1, pc_flag;
wire [14:0] out_data_dec;

// mux_0
wire [15:0] out_data_mux0;

// A register
wire [15:0] out_data_a;

// mux_1
wire [15:0] out_data_mux1;

// D register
wire [15:0] out_data_d;

// ALU
wire [15:0] out_data_alu;

assign {j1, j2, j3, write_m, load_a, load_d, no, f, ny, zy, nx, zx, mux_sel1, mux_sel0, pc_flag} = out_data_dec;
assign addr_m = out_data_a;


// decoder
hack_decoder hack_decoder_0(
    .inst       (   inst        ),

    .out_data   (   out_data_dec )
);



// Mux 0
hack_mux hack_mux_0(
    .in_data0   (   inst            ),
    .in_data1   (   out_m           ),
    .mux_sel    (   mux_sel0        ),

    .out_data   (   out_data_mux0   )
);

// A register
hack_register hack_register_a(
    .clk        (   clk             ),
    .xrst       (   xrst            ),
    .in_data    (   out_data_mux0   ),
    .load       (   load_a          ),

    .out_data   (   out_data_a      )
);

// Mux 1
hack_mux hack_mux_1(
    .in_data0   (   out_data_a      ),
    .in_data1   (   in_m            ),
    .mux_sel    (   mux_sel1        ),

    .out_data   (   out_data_mux1   )
);

// D registe
hack_register hack_register_d(
    .clk        (   clk         ),
    .xrst       (   xrst        ),
    .in_data    (   out_m       ),
    .load       (   load_d      ),

    .out_data   (   out_data_d  )    
);

hack_alu hack_alu(
    .in_data0   (   out_data_d      ),
    .in_data1   (   out_data_mux1   ),
    .zx         (   zx              ),
    .nx         (   nx              ),
    .zy         (   zy              ),
    .ny         (   ny              ),
    .f          (   f               ),
    .no         (   no              ),

    .zr         (   zr              ),
    .ng         (   ng              ),
    .out_data   (   out_m           )
);

hack_pc_load hack_pc_load_0(
    .zr         (   zr          ),
    .ng         (   ng          ),
    .j1         (   j1          ),
    .j2         (   j2          ),
    .j3         (   j3          ),
    .pc_flag    (   pc_flag     ),

    .load_pc    (   load_pc     )
);

hack_pc hack_pc(
    .clk        (   clk         ),
    .xrst       (   xrst        ),
    .load       (   load_pc     ),
    .inc        (   1'b1        ),
    .a          (   out_data_a  ),

    .out_data   (   pc          )
);

endmodule