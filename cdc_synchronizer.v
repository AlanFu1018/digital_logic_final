//clock domain crossing synchronizer module

module cdc_synchronizer (
    input  wire clk,       // 本機端的主時脈
    input  wire rst_n,     // 本機端的非同步復位訊號 (Active-Low)
    input  wire async_in,  // 來自另一塊 FPGA 或外部的非同步輸入訊號
    output wire sync_out   // 已經與本機 clk 同步的安全輸出訊號
);

    // 使用 ASYNC_REG 屬性，防止 Vivado 在綜合時將這兩個暫存器優化掉
    // 同時提示佈線工具將這兩個觸發器靠得越近越好
    (* ASYNC_REG = "TRUE" *) reg q1; // 第一級觸發器：吸收亞穩態
    (* ASYNC_REG = "TRUE" *) reg q2; // 第二級觸發器：輸出穩定訊號

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
        end else begin
            q1 <= async_in; // 捕捉外部非同步訊號
            q2 <= q1;       // 捕捉第一級穩定後的結果
        end
    end

    // 將第二級的輸出作為最終結果
    assign sync_out = q2;

endmodule