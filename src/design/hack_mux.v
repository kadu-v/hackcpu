module hack_mux (
    input   [15:0]  in_data0,
    input   [15:0]  in_data1,
    input           mux_sel,

    output  [15:0]  out_data
);

assign out_data = mux_sel ? in_data0 : in_data1;
endmodule