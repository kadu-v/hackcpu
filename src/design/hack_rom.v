module hack_rom (
    input wire          clk,
    input wire [15:0]   addr,

    output reg [15:0]   out_data
);
    reg [15:0] mem [32766:0]; // 32K

    always @(posedge clk) begin
        out_data <= mem[addr];
    end
    
    initial begin
        $readmemh("program.hex", mem);
    end
endmodule