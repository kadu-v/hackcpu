module hack_register (
    input wire          clk,
    input wire          xrst,
    input wire [15:0]   in_data,
    input wire          load,

    output reg [15:0]  out_data
);

always @(posedge clk) begin
    if (!xrst) begin
        out_data <= 0;
    end else if (load) begin
        out_data <= in_data;
    end
end

    
endmodule