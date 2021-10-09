module hack_pc_load (
    input wire zr,
    input wire ng,
    input wire j1,
    input wire j2,
    input wire j3,
    input wire pc_flag,

    output wire load_pc
);
assign not_zr = !zr;
assign not_ng = !ng;
assign not_j1 = !j1;
assign not_j2 = !j2;

assign tmp = (not_j2 & j3 & not_zr & not_ng) | (not_j1 & j2 & zr & not_ng) | (j1 & j2 & j3) | (j1 & j2 & not_zr & ng) | (j1 & j2 & zr & ng);
assign load_pc = tmp & pc_flag;  
endmodule