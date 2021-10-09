module hack_ram (
    input wire          clk,
    input wire          write_en,
    input wire [15:0]   addr,
    input wire [15:0]   in_data,

    output reg [15:0]   out_data
);
reg [15:0] mem [16383:0]; // 16 Kb

// データの書き込み
// 立ち上がりエッジで書き込む
always @(posedge clk) begin
    if(write_en) begin
        mem[addr] <= in_data;
    end
    out_data <= mem[addr];
end


endmodule