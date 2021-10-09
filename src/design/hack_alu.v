module hack_alu (
    input wire [15:0]   in_data0,
    input wire [15:0]   in_data1,
    input wire          zx,
    input wire          nx,
    input wire          zy,
    input wire          ny,
    input wire          f,
    input wire          no,

    output wire         zr,
    output wire         ng,
    output wire [15:0]  out_data
);

wire [15:0] x0;
wire [15:0] x1;
wire [15:0] y0;
wire [15:0] y1;
wire [15:0] z;

assign x0 = zx ? 0 : in_data0;
assign x1 = nx ? ~x0 : x0;

assign y0 = zy ? 0 : in_data1;
assign y1 = ny ? ~y0 : y0;

assign z = f ? x1 + y1 : x1 & y1;
assign out_data = no ? ~z : z;

assign zr = (out_data == 0) ? 1 : 0;
assign ng = (out_data < 0) ? 1 : 0;

    
endmodule