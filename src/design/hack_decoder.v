module hack_decoder (
    input wire  [15:0] inst,

    output wire [14:0] out_data
);
wire write_m;
wire load_d;
wire load_a;
wire mux_sel1;

assign write_m  = inst[3] & inst[15];
assign load_d   = inst[4] & inst[15];
assign load_a   = inst[5] & ~inst[15];
assign mux_sel1 = inst[12] & inst[15];


assign out_data = {inst[0], inst[1], inst[2], write_m, load_a, inst[6], inst[7], inst[8], inst[9], inst[10], inst[11], mux_sel1, inst[15], inst[15]};
endmodule