module hack_pc (
    input wire clk,
    input wire xrst,
    input wire load,
    input wire inc,
    input wire [15:0] a,

    output reg [15:0] out_data
);

always @(posedge clk) begin
    if (!xrst) begin
        out_data <= 0;
    end else if (load) begin
        out_data <= a;
    end else if (inc) begin
        out_data <= out_data + 1;
    end
end


endmodule