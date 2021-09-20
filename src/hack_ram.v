module hack_ram (
    clock,
    load,
    addr,
    in_data,
    out_data
);
    input clock, load;
    input [13:0] addr;
    input [15:0] in_data;
    output [15:0] out_data;

    wire out_data;
    reg [15:0] mem [16383:0]; // 16 Kb

    // データの読み出し
    assign out_data = mem[addr];

    // データの書き込み
    // 立ち上がりエッジで書き込む
    always @(posedge clock) begin
        if(load) begin
            mem[addr] <= in_data;
        end
    end

    // 全てのレジスタを０で初期化
    initial begin
        for (integer i = 0; i < 16384; i = i + 1) begin
            mem[i] = 0;
        end
    end
endmodule