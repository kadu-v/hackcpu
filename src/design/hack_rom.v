module hack_rom (
    input wire          clk,
    input wire [15:0]   addr,

    output wire [15:0]   out_data
);

// localparam mem_width = 32766;
localparam mem_width = 15;
reg [15:0] mem [mem_width:0]; // 32K

// 非同期rom
assign out_data = mem[addr];

initial begin
    $readmemb("../../instructions/max.hack", mem);
end
endmodule