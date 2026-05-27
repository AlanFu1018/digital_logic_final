module cdc_top (
    input  wire clk,        // EGO1 板載 100MHz 時脈
    input  wire rst,        // EGO1 板載 Reset 按鍵 (根據文件為 Active-Low)
    inout  wire [31:0] gpio,// EGO1 J5 GPIO 擴充排針
    output wire [15:0] led  // EGO1 板載 LED
);

    // 內部訊號宣告
    wire async_rx;          // 來自另一塊 FPGA 的訊號
    wire safe_rx;           // 經過 CDC 處理後的安全訊號

    // 1. 腳位分配邏輯
    // 假設我們使用 J5 排針的第一根腳 (gpio[0]) 當作接收端 (RX)
    assign async_rx = gpio[0]; 
    
    // 為了安全起見，我們將其他沒有用到的 GPIO 設為高阻抗 (High-Z)，避免兩邊短路
    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin : gpio_high_z
            assign gpio[i] = 1'bz;
        end
    endgenerate

    // 2. 實例化 CDC 同步器模組
    cdc_synchronizer u_cdc (
        .clk      (clk),        // 接上 100MHz 系統時脈
        .rst_n    (rst),        // 接上板載的 Reset 按鍵
        .async_in (async_rx),   // 輸入從 GPIO 讀取到的非同步訊號
        .sync_out (safe_rx)     // 輸出乾淨的同步訊號
    );

    // 3. 輸出觀察
    // 將同步後的安全訊號輸出到 LED[0]，讓你肉眼確認訊號狀態
    assign led[0] = safe_rx;

    // 將其餘沒用到的 LED 關閉
    assign led[15:1] = 15'b0;

endmodule