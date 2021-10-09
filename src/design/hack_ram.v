module hack_ram (
    input wire          clk,
    input wire          write_en,
    input wire [15:0]   addr,
    input wire [15:0]   in_data,

    output wire [15:0]   out_data
);
reg [15:0] mem [16383:0]; // 16 Kb

// 実際のFPGA上ではおそらく実現不可能
assign out_data = mem[addr];


// データの書き込み
// 立ち上がりエッジで書き込む
always @(posedge clk) begin
    if(write_en) begin
        mem[addr] <= in_data;
    end
end

initial begin
    mem[0] <= 1;
    mem[1] <= 5;
end

endmodule