module hack_rom (
    input wire          clk,
    input wire [15:0]   addr,

    output reg [15:0]   out_data
);

// localparam mem_width = 32766;
localparam mem_width = 15;
reg [15:0] mem [mem_width:0]; // 32K

always @(posedge clk) begin
    out_data <= mem[addr];
end

initial begin
    $readmemb("../../instructions/max.hack", mem);
end
endmodule