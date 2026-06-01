`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2026 10:42:50 AM
// Design Name: 
// Module Name: seven_seg_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg_display (
    input  wire        clk,       
    input  wire [3:0]  p1_score,   
    input  wire [3:0]  p2_score,   

    output reg  [6:0]  seg,
    output reg  [3:0]  an
);

    reg [16:0] refresh_counter = 0;
    always @(posedge clk)
        refresh_counter <= refresh_counter + 1;

    wire [1:0] digit_sel = refresh_counter[16:15];


    wire [3:0] p1_tens = p1_score / 10;
    wire [3:0] p1_ones = p1_score % 10;

    wire [3:0] p2_tens = p2_score / 10;
    wire [3:0] p2_ones = p2_score % 10;

    reg [3:0] current_digit;

    always @(*) begin
        case (digit_sel)

            2'b00: begin
                an = 4'b0111;
                current_digit = p1_tens;
            end

            2'b01: begin
                an = 4'b1011;
                current_digit = p1_ones;
            end

            2'b10: begin
                an = 4'b1101;
                current_digit = p2_tens;
            end

            2'b11: begin
                an = 4'b1110;
                current_digit = p2_ones;
            end

        endcase
    end

    always @(*) begin
        case (current_digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end

endmodule
