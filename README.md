# Hack CPUをFPGAで実装しよう
このリポジトリは[コンピュータシステムの理論と実装](https://www.oreilly.co.jp/books/9784873117126/)のHackアーキテクチャのCPUをFPGAで実装しようというプロジェクトのためのものです．

# 実行環境
- iverilog v11.0
- gtkwave  v3.3.111  

現在は、ソフトウェアシミュレーションでのみ動作を確認しています．
FPGAボードを入手次第実装してみようと思っています．

# How to do a software simulation
- max.hackのソフトウェアシミュレーション
    ```
    $ git clone git@github.com:kadu-v/hackcpu.git
    $ cd ./hackcpu/src/testbench
    $ iverilo -I ../design test_hack_cpu.v
    $ ./a.out
    ```
    生成されたvhdをgtkawaveで読み込むと、mem[0]とmem[1]の大きい方をmem[2]に格納されます．(初期設定だと以下のようにmem[0]=1, mem[1]=5なので、mem[2]=5と格納されます.)  
    ![max.png](https://github.com/kadu-v/hackcpu/blob/main/imgs/max.png)

# Hack CPUのRAMに関する仕様について
Hack CPUのRAMは、仕様によると非同期読み出しのRAMです．
従って、`hack_ram.v`では以下のように非同期RAMとして実装しています．
```verilog
module hack_ram (...);
reg [15:0] mem [16383:0]; // 16 Kb

// 非同期読み出し
assign out_data = mem[addr];

// データの書き込み
// 立ち上がりエッジで書き込む
always @(posedge clk) begin
    if(write_en) begin
        mem[addr] <= in_data;
    end
end
...
endmodule
```
読み出しが非同期なので、FPGAボードの種類によっては内蔵のRAMに実装されなかったりするかもしれません．  
詳しい方がいましたら教えてください．