`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 12:13:22 AM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input clk,
    input rst,
    input btn,
    output reg btn_db
    );
    
    reg [15:0] counter = 0;    // Counter for debounce logic
    reg sync_to_clk0;          // Synchronization register 0
    reg sync_to_clk1;          // Synchronization register 1
        
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sync_to_clk0 <= 0;
            sync_to_clk1 <= 0;
            btn_db <= 0;
            counter <= 0;
        end else begin
            sync_to_clk0 <= btn;
            sync_to_clk1 <= sync_to_clk0;
        if (btn_db == sync_to_clk1) begin
            counter <= 0;
        end else begin
            counter <= counter + 1'b1;
            if (counter == 2) begin
                btn_db <= sync_to_clk1; // Toggle the debounced signal
            end
        end
    end
end    
endmodule
