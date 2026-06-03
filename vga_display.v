module vga_display
    (
        input wire clk, reset,
        input wire [3:0] output_pattern,
        input wire [3:0] state,
        input wire [32:0] counter,
        input wire [32:0] PERIOD,
        output wire hsync, vsync,
        output wire [11:0] rgb
    );
    
//        wire level_tick = 12*level;
    
    localparam START = 0, DISPLAY_PATTERN = 1, DISPLAY_FLASH = 2, PLAY = 3, TEST = 4, P1_WIN = 5, P2_WIN = 6, BOTH_LOST = 7, P1_DONE = 8, P2_DONE = 9;// PASS = 5, FAIL = 6;

    // Local parameters for box borders
    
    
            localparam V_EDGE1_L_BORDER    = 210;
            localparam V_EDGE1_R_BORDER    = 216;
            localparam V_EDGE2_L_BORDER    = 423;
            localparam V_EDGE2_R_BORDER    = 429;
    
            localparam H_EDGE1_T_BORDER    = 157;
            localparam H_EDGE1_B_BORDER    = 163;
            localparam H_EDGE2_T_BORDER    = 317;
            localparam H_EDGE2_B_BORDER    = 323;
    
            localparam V_CAP1_L_BORDER    = 0;
            localparam V_CAP1_R_BORDER    = 6;
            localparam V_CAP1_T_BORDER    = 163;
            localparam V_CAP1_B_BORDER    = 317;
            
            localparam V_CAP2_L_BORDER    = 634;
            localparam V_CAP2_R_BORDER    = 640;
            localparam V_CAP2_T_BORDER    = 163;
            localparam V_CAP2_B_BORDER    = 317;
            
            localparam H_CAP1_L_BORDER    = 216;
            localparam H_CAP1_R_BORDER    = 423;
            localparam H_CAP1_T_BORDER    = 0;
            localparam H_CAP1_B_BORDER    = 6;
            
            localparam H_CAP2_L_BORDER    = 216;
            localparam H_CAP2_R_BORDER    = 423;
            localparam H_CAP2_T_BORDER    = 474;
            localparam H_CAP2_B_BORDER    = 480;
    
            localparam BOX_ONE_L_BORDER    = 0;
            localparam BOX_ONE_R_BORDER    = 320;
            localparam BOX_ONE_T_BORDER    = 0;
            localparam BOX_ONE_B_BORDER    = 220;
        
            localparam BOX_TWO_L_BORDER  = 321;
            localparam BOX_TWO_R_BORDER  = 640;
            localparam BOX_TWO_T_BORDER  = 0;
            localparam BOX_TWO_B_BORDER  = 220;
        
            localparam BOX_THREE_L_BORDER = 0;
            localparam BOX_THREE_R_BORDER = 320;
            localparam BOX_THREE_T_BORDER = 221;
            localparam BOX_THREE_B_BORDER = 440;
        
            localparam BOX_FOUR_L_BORDER   = 321;
            localparam BOX_FOUR_R_BORDER   = 640;
            localparam BOX_FOUR_T_BORDER   = 221;
            localparam BOX_FOUR_B_BORDER   = 440;

    // Register for RGB DAC
    reg [11:0] rgb_reg;

    // Video status output from vga_sync to tell when to route out RGB signal to DAC
    wire video_on;
    
    wire [9:0] x, y;
    
    wire [63:0] counter_bar_wide;
    assign counter_bar_wide = (counter * 640) / (40 * PERIOD);
    wire [9:0] counter_bar;
    assign counter_bar = counter_bar_wide[9:0];

    // Instantiate vga_sync
    vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                            .video_on(video_on), .p_tick(), .x(x), .y(y));

    always @(posedge clk or posedge reset) begin
        if (reset)
            rgb_reg <= 12'b000000001111; // Black screen on reset
        else begin
        
                      
            if (state == P1_DONE) begin
            
                // P - left stroke
                if      (x >= 164 && x <= 169 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // P - top bar
                else if (x >= 164 && x <= 196 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // P - mid bar
                else if (x >= 164 && x <= 196 && y >= 237 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // P - right stroke (top half only)
                else if (x >= 191 && x <= 196 && y >= 210 && y <= 242)
                    rgb_reg <= 12'b111111111111;
            
                // 1 - vertical
                else if (x >= 218 && x <= 223 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // 1 - top-left serif
                else if (x >= 213 && x <= 218 && y >= 210 && y <= 220)
                    rgb_reg <= 12'b111111111111;
            
                // (space between P1 and WINS - nothing drawn from x=236 to x=260)
            
                // W - left stroke
                else if (x >= 260 && x <= 265 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // W - right stroke
                else if (x >= 296 && x <= 301 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // W - mid stroke
                else if (x >= 278 && x <= 283 && y >= 240 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // W - bottom bar
                else if (x >= 260 && x <= 301 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // I - top bar
                else if (x >= 313 && x <= 341 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // I - bot bar
                else if (x >= 313 && x <= 341 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // I - mid stroke
                else if (x >= 325 && x <= 330 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // N - left stroke
                else if (x >= 353 && x <= 358 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // N - right stroke
                else if (x >= 389 && x <= 394 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // N - diagonal (approximated as thick top bar)
                else if (x >= 358 && x <= 389 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
            
                // S - top bar
                else if (x >= 406 && x <= 438 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // S - mid bar
                else if (x >= 406 && x <= 438 && y >= 237 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // S - bot bar
                else if (x >= 406 && x <= 438 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // S - top-left stroke
                else if (x >= 406 && x <= 411 && y >= 210 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // S - bot-right stroke
                else if (x >= 433 && x <= 438 && y >= 237 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // green background everywhere else
                else if (x >= 0 && x <= 640 && y >= 0 && y <= 480)
                    rgb_reg <= 12'b000011110000;
                else
                    rgb_reg <= 12'b000000000000;
            end
            
            else if (state == P2_DONE) begin
            
                // P - left stroke
                if      (x >= 164 && x <= 169 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // P - top bar
                else if (x >= 164 && x <= 196 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // P - mid bar
                else if (x >= 164 && x <= 196 && y >= 237 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // P - right stroke (top half only)
                else if (x >= 191 && x <= 196 && y >= 210 && y <= 242)
                    rgb_reg <= 12'b111111111111;
            
                // 2 - top bar
                else if (x >= 213 && x <= 245 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // 2 - top-right stroke
                else if (x >= 240 && x <= 245 && y >= 210 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // 2 - mid bar
                else if (x >= 213 && x <= 245 && y >= 237 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // 2 - bot-left stroke
                else if (x >= 213 && x <= 218 && y >= 237 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // 2 - bot bar
                else if (x >= 213 && x <= 245 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // (space between P2 and WINS - nothing drawn from x=245 to x=260)
            
                // W - left stroke
                else if (x >= 260 && x <= 265 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // W - right stroke
                else if (x >= 296 && x <= 301 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // W - mid stroke
                else if (x >= 278 && x <= 283 && y >= 240 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // W - bottom bar
                else if (x >= 260 && x <= 301 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // I - top bar
                else if (x >= 313 && x <= 341 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // I - bot bar
                else if (x >= 313 && x <= 341 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // I - mid stroke
                else if (x >= 325 && x <= 330 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // N - left stroke
                else if (x >= 353 && x <= 358 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // N - right stroke
                else if (x >= 389 && x <= 394 && y >= 210 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // N - diagonal (approximated as thick top bar)
                else if (x >= 358 && x <= 389 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
            
                // S - top bar
                else if (x >= 406 && x <= 438 && y >= 210 && y <= 215)
                    rgb_reg <= 12'b111111111111;
                // S - mid bar
                else if (x >= 406 && x <= 438 && y >= 237 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // S - bot bar
                else if (x >= 406 && x <= 438 && y >= 265 && y <= 270)
                    rgb_reg <= 12'b111111111111;
                // S - top-left stroke
                else if (x >= 406 && x <= 411 && y >= 210 && y <= 242)
                    rgb_reg <= 12'b111111111111;
                // S - bot-right stroke
                else if (x >= 433 && x <= 438 && y >= 237 && y <= 270)
                    rgb_reg <= 12'b111111111111;
            
                // green background everywhere else
                else if (x >= 0 && x <= 640 && y >= 0 && y <= 480)
                    rgb_reg <= 12'b000011110000;
                else
                    rgb_reg <= 12'b000000000000;
            end
            
            else if (state == P1_WIN || state == P2_WIN) begin
                if (x >= 0 && x <= 640 && y >=0 && y <= 480)    
                    rgb_reg <= 12'b000011110000;       
                else
                    rgb_reg <= 12'b000000000000;
            end
            
            else if (state == BOTH_LOST) begin 
                if (x >= 0 && x <= 640 && y >=0 && y <= 480)    
                    rgb_reg <= 12'b111100000000;       
                else
                    rgb_reg <= 12'b000000000000;
            end

            else begin
            
                // boxes/playing area
                if (x >= BOX_ONE_L_BORDER && x <= BOX_ONE_R_BORDER && y >= BOX_ONE_T_BORDER && y <= BOX_ONE_B_BORDER && output_pattern[0])
                    rgb_reg <= 12'b111101000000;
                else if (x >= BOX_TWO_L_BORDER && x <= BOX_TWO_R_BORDER && y >= BOX_TWO_T_BORDER && y <= BOX_TWO_B_BORDER && output_pattern[1])
                    rgb_reg <= 12'b111100001111;
                else if (x >= BOX_THREE_L_BORDER && x <= BOX_THREE_R_BORDER && y >= BOX_THREE_T_BORDER && y <= BOX_THREE_B_BORDER && output_pattern[2])
                    rgb_reg <= 12'b000000001111;
                else if (x >= BOX_FOUR_L_BORDER && x <= BOX_FOUR_R_BORDER && y >= BOX_FOUR_T_BORDER && y <= BOX_FOUR_B_BORDER && output_pattern[3])
                    rgb_reg <= 12'b111111110000;
                else if (x <= counter_bar && y >= 441 && y <= 480 && state == PLAY)
                        rgb_reg <= 12'b111100000000;
//                else if (x  >= 0 && x <= ((counter * 640) / (40 * PERIOD)) && y >= 441 && y <= 480) 
//                    rgb_reg <= 12'b111100000000;
                else
                    rgb_reg <=  12'b100010001000;
            end
        end
    end
         
    //end
    
    // Output
    assign rgb = (video_on) ? rgb_reg : 12'b0; // Output only during active video region
endmodule