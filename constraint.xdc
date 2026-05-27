## ============================================================
## EGO1 / EGO-XA7 Xilinx Constraint File
## FPGA: XC7A35T-1CSG324C
##
## 說明：
## 1. XDC 的註解符號是 #
## 2. 目前所有腳位都先註解起來
## 3. 需要用哪個 port，就把該 port 對應行前面的 # 拿掉
## 4. Verilog top module 的 port 名稱必須和 get_ports 裡的名稱一致
##
## 重要注意：
## 1. EGO1 reset button 很可能是 active-low
##    未按下 reset = 1
##    按下 reset = 0
##
## 2. 如果 Verilog 寫成：
##
##    always @(posedge clk or posedge rst) begin
##        if (rst) begin
##            // reset
##        end
##    end
##
##    可能會導致：
##    未按 reset 時一直卡在 reset
##    按住 reset 時才正常執行
##
## 3. 建議 Verilog 寫法：
##
##    always @(posedge clk or negedge rst) begin
##        if (!rst) begin
##            // reset
##        end else begin
##            // normal running
##        end
##    end
##
## 4. 七段顯示器方向：
##    BIT1 是最左邊
##    BIT8 是最右邊
##
## ============================================================


## ============================================================
## 1. System Clock
## ============================================================
## EGO1 板上 100 MHz 系統時鐘
##
## Verilog port name:
## input clk;

set_property PACKAGE_PIN P17 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]


## ============================================================
## 2. Reset Button
## ============================================================
## FPGA_RESET / S6
##
## Verilog port name:
## input rst;
##
## 重要注意：
## EGO1 的 reset button 很可能是 active-low。
##
## 未按下 reset button 時：
## rst = 1
##
## 按下 reset button 時：
## rst = 0
##
## 所以 Verilog 建議寫：
##
## always @(posedge clk or negedge rst) begin
##     if (!rst) begin
##         // reset logic
##     end else begin
##         // normal logic
##     end
## end
##
## 如果不確定 reset 極性，可以先測試：
##
## assign led[0] = rst;
##
## 若未按 reset 時 led[0] 亮，按下 reset 時 led[0] 滅，
## 代表 rst 是 active-low。

set_property PACKAGE_PIN P15 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]


## ============================================================
## 3. Push Buttons
## ============================================================
## EGO1 有 5 個通用按鍵
##
## Verilog port name:
## input [4:0] btn;
##
## btn[0] = S0
## btn[1] = S1
## btn[2] = S2
## btn[3] = S3
## btn[4] = S4
##
## 一般按鍵通常是：
## 未按下 = 0
## 按下 = 1
##
## 但正式使用前仍建議用 LED 測試一次。

# set_property PACKAGE_PIN R11 [get_ports {btn[0]}]  ;# S0
# set_property PACKAGE_PIN R17 [get_ports {btn[1]}]  ;# S1
# set_property PACKAGE_PIN R15 [get_ports {btn[2]}]  ;# S2
# set_property PACKAGE_PIN V1  [get_ports {btn[3]}]  ;# S3
# set_property PACKAGE_PIN U4  [get_ports {btn[4]}]  ;# S4

# set_property IOSTANDARD LVCMOS33 [get_ports {btn[*]}]


## ============================================================
## 4. Slide Switches
## ============================================================
## 8 個滑動開關
##
## Verilog port name:
## input [7:0] sw;
##
## 如果用我前面寫的 timer top.v：
## sw[0] = 0：正數計時
## sw[0] = 1：倒數計時

# set_property PACKAGE_PIN R1 [get_ports {sw[0]}]  ;# SW0
# set_property PACKAGE_PIN N4 [get_ports {sw[1]}]  ;# SW1
# set_property PACKAGE_PIN M4 [get_ports {sw[2]}]  ;# SW2
# set_property PACKAGE_PIN R2 [get_ports {sw[3]}]  ;# SW3
# set_property PACKAGE_PIN P2 [get_ports {sw[4]}]  ;# SW4
# set_property PACKAGE_PIN P3 [get_ports {sw[5]}]  ;# SW5
# set_property PACKAGE_PIN P4 [get_ports {sw[6]}]  ;# SW6
# set_property PACKAGE_PIN P5 [get_ports {sw[7]}]  ;# SW7

# set_property IOSTANDARD LVCMOS33 [get_ports {sw[*]}]


## ============================================================
## 5. DIP Switches
## ============================================================
## 額外 8-bit DIP switch
##
## Verilog port name:
## input [7:0] dip;

# set_property PACKAGE_PIN T5 [get_ports {dip[0]}]  ;# DIP0
# set_property PACKAGE_PIN T3 [get_ports {dip[1]}]  ;# DIP1
# set_property PACKAGE_PIN R3 [get_ports {dip[2]}]  ;# DIP2
# set_property PACKAGE_PIN V4 [get_ports {dip[3]}]  ;# DIP3
# set_property PACKAGE_PIN V5 [get_ports {dip[4]}]  ;# DIP4
# set_property PACKAGE_PIN V2 [get_ports {dip[5]}]  ;# DIP5
# set_property PACKAGE_PIN U2 [get_ports {dip[6]}]  ;# DIP6
# set_property PACKAGE_PIN U3 [get_ports {dip[7]}]  ;# DIP7

# set_property IOSTANDARD LVCMOS33 [get_ports {dip[*]}]


## ============================================================
## 6. LEDs
## ============================================================
## 16 個 LED
##
## Verilog port name:
## output [15:0] led;
##
## 一般情況：
## 輸出 1，LED 亮
## 輸出 0，LED 滅
##
## 如果用我前面寫的 timer top.v：
## led[0]    = running
## led[1]    = lap_mode
## led[2]    = countdown_mode
## led[7:3]  = btn_clean
## led[15:8] = sw

set_property PACKAGE_PIN K3 [get_ports {led[0]}]   ;# LED0
# set_property PACKAGE_PIN M1 [get_ports {led[1]}]   ;# LED1
# set_property PACKAGE_PIN L1 [get_ports {led[2]}]   ;# LED2
# set_property PACKAGE_PIN K6 [get_ports {led[3]}]   ;# LED3
# set_property PACKAGE_PIN J5 [get_ports {led[4]}]   ;# LED4
# set_property PACKAGE_PIN H5 [get_ports {led[5]}]   ;# LED5
# set_property PACKAGE_PIN H6 [get_ports {led[6]}]   ;# LED6
# set_property PACKAGE_PIN K1 [get_ports {led[7]}]   ;# LED7

# set_property PACKAGE_PIN K2 [get_ports {led[8]}]   ;# LED8
# set_property PACKAGE_PIN J2 [get_ports {led[9]}]   ;# LED9
# set_property PACKAGE_PIN J3 [get_ports {led[10]}]  ;# LED10
# set_property PACKAGE_PIN H4 [get_ports {led[11]}]  ;# LED11
# set_property PACKAGE_PIN J4 [get_ports {led[12]}]  ;# LED12
# set_property PACKAGE_PIN G3 [get_ports {led[13]}]  ;# LED13
# set_property PACKAGE_PIN G4 [get_ports {led[14]}]  ;# LED14
# set_property PACKAGE_PIN F6 [get_ports {led[15]}]  ;# LED15

# set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]


## ============================================================
## 7. Seven-Segment Display
## ============================================================
## EGO1 有 8 位七段顯示器
##
## Verilog port names:
##
## output [7:0] seg0;
## output [7:0] seg1;
## output [7:0] an;
##
## seg0 / seg1 段選對應：
##
## seg0[0] = A0
## seg0[1] = B0
## seg0[2] = C0
## seg0[3] = D0
## seg0[4] = E0
## seg0[5] = F0
## seg0[6] = G0
## seg0[7] = DP0
##
## seg1[0] = A1
## seg1[1] = B1
## seg1[2] = C1
## seg1[3] = D1
## seg1[4] = E1
## seg1[5] = F1
## seg1[6] = G1
## seg1[7] = DP1
##
## 重要方向註釋：
## BIT1 是最左邊的七段顯示器
## BIT8 是最右邊的七段顯示器
##
## 也就是：
##
## an[0] = BIT1，最左邊
## an[1] = BIT2
## an[2] = BIT3
## an[3] = BIT4
## an[4] = BIT5
## an[5] = BIT6
## an[6] = BIT7
## an[7] = BIT8，最右邊
##
## 如果你的 Verilog 掃描邏輯把 an[0] 當最右邊，
## 那實際顯示會左右相反。
## ============================================================


## ------------------------------------------------------------
## seg0 group
## ------------------------------------------------------------

# set_property PACKAGE_PIN B4 [get_ports {seg0[0]}]  ;# A0
# set_property PACKAGE_PIN A4 [get_ports {seg0[1]}]  ;# B0
# set_property PACKAGE_PIN A3 [get_ports {seg0[2]}]  ;# C0
# set_property PACKAGE_PIN B1 [get_ports {seg0[3]}]  ;# D0
# set_property PACKAGE_PIN A1 [get_ports {seg0[4]}]  ;# E0
# set_property PACKAGE_PIN B3 [get_ports {seg0[5]}]  ;# F0
# set_property PACKAGE_PIN B2 [get_ports {seg0[6]}]  ;# G0
# set_property PACKAGE_PIN D5 [get_ports {seg0[7]}]  ;# DP0


## ------------------------------------------------------------
## seg1 group
## ------------------------------------------------------------

# set_property PACKAGE_PIN D4 [get_ports {seg1[0]}]  ;# A1
# set_property PACKAGE_PIN E3 [get_ports {seg1[1]}]  ;# B1
# set_property PACKAGE_PIN D3 [get_ports {seg1[2]}]  ;# C1
# set_property PACKAGE_PIN F4 [get_ports {seg1[3]}]  ;# D1
# set_property PACKAGE_PIN F3 [get_ports {seg1[4]}]  ;# E1
# set_property PACKAGE_PIN E2 [get_ports {seg1[5]}]  ;# F1
# set_property PACKAGE_PIN D2 [get_ports {seg1[6]}]  ;# G1
# set_property PACKAGE_PIN H2 [get_ports {seg1[7]}]  ;# DP1


## ------------------------------------------------------------
## Digit enable pins
## ------------------------------------------------------------
## BIT1 是最左邊
## BIT8 是最右邊

# set_property PACKAGE_PIN G2 [get_ports {an[0]}]  ;# BIT1 / 最左邊
# set_property PACKAGE_PIN C2 [get_ports {an[1]}]  ;# BIT2
# set_property PACKAGE_PIN C1 [get_ports {an[2]}]  ;# BIT3
# set_property PACKAGE_PIN H1 [get_ports {an[3]}]  ;# BIT4
# set_property PACKAGE_PIN G1 [get_ports {an[4]}]  ;# BIT5
# set_property PACKAGE_PIN F1 [get_ports {an[5]}]  ;# BIT6
# set_property PACKAGE_PIN E1 [get_ports {an[6]}]  ;# BIT7
# set_property PACKAGE_PIN G6 [get_ports {an[7]}]  ;# BIT8 / 最右邊

# set_property IOSTANDARD LVCMOS33 [get_ports {seg0[*]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {seg1[*]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}]


## ============================================================
## 8. VGA Interface
## ============================================================
## 如果沒有使用 VGA，可以保持註解
##
## Verilog port names:
##
## output [3:0] vga_r;
## output [3:0] vga_g;
## output [3:0] vga_b;
## output vga_hsync;
## output vga_vsync;

# set_property PACKAGE_PIN F5 [get_ports {vga_r[0]}]  ;# VGA_R0
# set_property PACKAGE_PIN C6 [get_ports {vga_r[1]}]  ;# VGA_R1
# set_property PACKAGE_PIN C5 [get_ports {vga_r[2]}]  ;# VGA_R2
# set_property PACKAGE_PIN B7 [get_ports {vga_r[3]}]  ;# VGA_R3

# set_property PACKAGE_PIN B6 [get_ports {vga_g[0]}]  ;# VGA_G0
# set_property PACKAGE_PIN A6 [get_ports {vga_g[1]}]  ;# VGA_G1
# set_property PACKAGE_PIN A5 [get_ports {vga_g[2]}]  ;# VGA_G2
# set_property PACKAGE_PIN D8 [get_ports {vga_g[3]}]  ;# VGA_G3

# set_property PACKAGE_PIN C7 [get_ports {vga_b[0]}]  ;# VGA_B0
# set_property PACKAGE_PIN E6 [get_ports {vga_b[1]}]  ;# VGA_B1
# set_property PACKAGE_PIN E5 [get_ports {vga_b[2]}]  ;# VGA_B2
# set_property PACKAGE_PIN E7 [get_ports {vga_b[3]}]  ;# VGA_B3

# set_property PACKAGE_PIN D7 [get_ports vga_hsync]   ;# VGA_HSYNC
# set_property PACKAGE_PIN C4 [get_ports vga_vsync]   ;# VGA_VSYNC

# set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[*]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[*]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[*]}]
# set_property IOSTANDARD LVCMOS33 [get_ports vga_hsync]
# set_property IOSTANDARD LVCMOS33 [get_ports vga_vsync]


## ============================================================
## 9. USB-UART Interface
## ============================================================
## 如果沒有使用 UART，可以保持註解
##
## Verilog port names:
##
## input uart_rx;
## output uart_tx;
##
## 命名方向：
## uart_tx 是 FPGA 傳送到電腦
## uart_rx 是 FPGA 從電腦接收

# set_property PACKAGE_PIN T4 [get_ports uart_tx]  ;# FPGA TX
# set_property PACKAGE_PIN N5 [get_ports uart_rx]  ;# FPGA RX

# set_property IOSTANDARD LVCMOS33 [get_ports uart_tx]
# set_property IOSTANDARD LVCMOS33 [get_ports uart_rx]


## ============================================================
## 10. PS/2 Interface
## ============================================================
## 如果沒有使用 PS/2 鍵盤或滑鼠，可以保持註解
##
## Verilog port names:
##
## inout ps2_clk;
## inout ps2_data;

# set_property PACKAGE_PIN K5 [get_ports ps2_clk]   ;# PS2_CLK
# set_property PACKAGE_PIN L4 [get_ports ps2_data]  ;# PS2_DATA

# set_property IOSTANDARD LVCMOS33 [get_ports ps2_clk]
# set_property IOSTANDARD LVCMOS33 [get_ports ps2_data]


## ============================================================
## 11. Audio PWM Output
## ============================================================
## 如果沒有使用音訊，可以保持註解
##
## Verilog port names:
##
## output audio_pwm;
## output audio_sd;
##
## audio_sd 可能是 audio shutdown / enable 腳位
## 如果沒有聲音，可以嘗試讓 audio_sd 輸出 1

# set_property PACKAGE_PIN T1 [get_ports audio_pwm]  ;# AUDIO_PWM
# set_property PACKAGE_PIN M6 [get_ports audio_sd]   ;# AUDIO_SD

# set_property IOSTANDARD LVCMOS33 [get_ports audio_pwm]
# set_property IOSTANDARD LVCMOS33 [get_ports audio_sd]


## ============================================================
## 12. Bluetooth UART
## ============================================================
## 如果沒有使用 Bluetooth，可以保持註解
##
## Verilog port names:
##
## input bt_rx;
## output bt_tx;

# set_property PACKAGE_PIN N2 [get_ports bt_tx]  ;# FPGA TX to Bluetooth RX
# set_property PACKAGE_PIN L3 [get_ports bt_rx]  ;# FPGA RX from Bluetooth TX

# set_property IOSTANDARD LVCMOS33 [get_ports bt_tx]
# set_property IOSTANDARD LVCMOS33 [get_ports bt_rx]


## ============================================================
## 13. General-Purpose Expansion I/O J5
## ============================================================
## 可用於兩塊 FPGA 之間通訊
##
## Verilog port name:
## inout [31:0] gpio;
##
## 重要注意：
## 1. 兩塊 FPGA 板子通訊時，GND 一定要共地
## 2. 不要讓兩邊同時對同一條線輸出相反電位
## 3. 建議用杜邦線接 GPIO
## 4. 不建議直接用 Type-C 當 FPGA-to-FPGA GPIO 通訊線

set_property PACKAGE_PIN B16 [get_ports {gpio[0]}]   ;# J5 pin 1
# set_property PACKAGE_PIN B17 [get_ports {gpio[1]}]   ;# J5 pin 2
# set_property PACKAGE_PIN A15 [get_ports {gpio[2]}]   ;# J5 pin 3
# set_property PACKAGE_PIN A16 [get_ports {gpio[3]}]   ;# J5 pin 4
# set_property PACKAGE_PIN A13 [get_ports {gpio[4]}]   ;# J5 pin 5
# set_property PACKAGE_PIN A14 [get_ports {gpio[5]}]   ;# J5 pin 6
# set_property PACKAGE_PIN B18 [get_ports {gpio[6]}]   ;# J5 pin 7
# set_property PACKAGE_PIN A18 [get_ports {gpio[7]}]   ;# J5 pin 8
# set_property PACKAGE_PIN F13 [get_ports {gpio[8]}]   ;# J5 pin 9
# set_property PACKAGE_PIN F14 [get_ports {gpio[9]}]   ;# J5 pin 10
# set_property PACKAGE_PIN B13 [get_ports {gpio[10]}]  ;# J5 pin 11
# set_property PACKAGE_PIN B14 [get_ports {gpio[11]}]  ;# J5 pin 12
# set_property PACKAGE_PIN D14 [get_ports {gpio[12]}]  ;# J5 pin 13
# set_property PACKAGE_PIN C14 [get_ports {gpio[13]}]  ;# J5 pin 14
# set_property PACKAGE_PIN B11 [get_ports {gpio[14]}]  ;# J5 pin 15
# set_property PACKAGE_PIN A11 [get_ports {gpio[15]}]  ;# J5 pin 16
# set_property PACKAGE_PIN E15 [get_ports {gpio[16]}]  ;# J5 pin 17
# set_property PACKAGE_PIN E16 [get_ports {gpio[17]}]  ;# J5 pin 18
# set_property PACKAGE_PIN D15 [get_ports {gpio[18]}]  ;# J5 pin 19
# set_property PACKAGE_PIN C15 [get_ports {gpio[19]}]  ;# J5 pin 20
# set_property PACKAGE_PIN H16 [get_ports {gpio[20]}]  ;# J5 pin 21
# set_property PACKAGE_PIN G16 [get_ports {gpio[21]}]  ;# J5 pin 22
# set_property PACKAGE_PIN F15 [get_ports {gpio[22]}]  ;# J5 pin 23
# set_property PACKAGE_PIN F16 [get_ports {gpio[23]}]  ;# J5 pin 24
# set_property PACKAGE_PIN H14 [get_ports {gpio[24]}]  ;# J5 pin 25
# set_property PACKAGE_PIN G14 [get_ports {gpio[25]}]  ;# J5 pin 26
# set_property PACKAGE_PIN E17 [get_ports {gpio[26]}]  ;# J5 pin 27
# set_property PACKAGE_PIN D17 [get_ports {gpio[27]}]  ;# J5 pin 28
# set_property PACKAGE_PIN K13 [get_ports {gpio[28]}]  ;# J5 pin 29
# set_property PACKAGE_PIN J13 [get_ports {gpio[29]}]  ;# J5 pin 30
# set_property PACKAGE_PIN H17 [get_ports {gpio[30]}]  ;# J5 pin 31
# set_property PACKAGE_PIN G17 [get_ports {gpio[31]}]  ;# J5 pin 32

# set_property IOSTANDARD LVCMOS33 [get_ports {gpio[*]}]


## ============================================================
## End of EGO1 / EGO-XA7 Constraint File
## ============================================================