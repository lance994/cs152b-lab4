module vga_display
    (
        input wire clk, reset,
        input wire [3:0] output_pattern,
        input wire [3:0] state,
//        input wire [5:0] level,
//        input wire [5:0] high_score,
//        input wire [32:0] PERIOD,
        output wire hsync, vsync,
        output wire [11:0] rgb
    );
    
//        wire level_tick = 12*level;
    
        localparam START = 0, DISPLAY_PATTERN = 1, DISPLAY_FLASH = 2, INPUT = 3, CORRECT = 4, PASS = 5, FAIL = 6;

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
            localparam BOX_ONE_B_BORDER    = 240;
        
            localparam BOX_TWO_L_BORDER  = 321;
            localparam BOX_TWO_R_BORDER  = 640;
            localparam BOX_TWO_T_BORDER  = 0;
            localparam BOX_TWO_B_BORDER  = 240;
        
            localparam BOX_THREE_L_BORDER = 0;
            localparam BOX_THREE_R_BORDER = 320;
            localparam BOX_THREE_T_BORDER = 241;
            localparam BOX_THREE_B_BORDER = 480;
        
            localparam BOX_FOUR_L_BORDER   = 321;
            localparam BOX_FOUR_R_BORDER   = 640;
            localparam BOX_FOUR_T_BORDER   = 241;
            localparam BOX_FOUR_B_BORDER   = 480;

    // 25 MHz clock generation
    reg [1:0] clk_divider = 0;
    reg clk_25MHz = 0;

    always @(posedge clk) begin
        clk_divider <= clk_divider + 1;
        if (clk_divider == 2'b11) begin
            clk_25MHz <= ~clk_25MHz;
            clk_divider <= 0;
        end
    end

    // Register for RGB DAC
    reg [11:0] rgb_reg;

    // Video status output from vga_sync to tell when to route out RGB signal to DAC
    wire video_on;
    
    wire [9:0] x, y;

    // Instantiate vga_sync
    vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                            .video_on(video_on), .p_tick(), .x(x), .y(y));

    always @(posedge clk_25MHz or posedge reset) begin
        if (reset)
            rgb_reg <= 12'b000000001111; // Black screen on reset
        else begin
         
//            if (state == PASS) begin
//                if (y >= 475 && y <= 476 && x >= 0 && x <= 12*high_score)
//                     rgb_reg <= 12'b000000000000;
//                else if (y >= 475 && y <= 480 && x >= 12*high_score && x <= 12*high_score + 1)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 477 && y <= 480 && x >= 0 && x <= 12*high_score)
//                    rgb_reg <= 12'b111000000000;
//                else if (y >= 475 && y <= 476 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 470 && y <= 471 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 470 && y <= 476 && x >= 12*level && x <= 12*level + 1)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 472 && y <= 474 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000011100000;
                    
//                else if (y >= 20 && y <= 40 && x >= 600 && x <= 620 && PERIOD <= 100_000_000) //square
//                    rgb_reg <= 12'b111111110000;
//                else if (y >= 20 && y <= 40 && x >= 560 && x <= 580 && PERIOD <= 50_000_000) //square
//                    rgb_reg <= 12'b111111110000;
//                else if (y >= 20 && y <= 40 && x >= 520 && x <= 540 && PERIOD <= 25_000_000) //square
//                    rgb_reg <= 12'b111111110000;
                                            
//                // N
//                else if (y >= 80 && y <= 180 && x >= 90 && x <= 110)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 80 && y <= 180 && x >= 170 && x <= 190)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 100 && y <= 120 && x >= 110 && x <= 130)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 120 && y <= 140 && x >= 130 && x <= 150)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 140 && y <= 160 && x >= 150 && x <= 170) //square
//                    rgb_reg <= 12'b111111111111;
                    
//                // E
//                else if (y >= 80 && y <= 100 && x >= 210 && x <= 310) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 120 && y <= 140 && x >= 210 && x <= 310)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 160 && y <= 180 && x >= 210 && x <= 310)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 80 && y <= 180 && x >= 210 && x <= 230) //vertical line
//                    rgb_reg <= 12'b111111111111;
                    
//                // X
//                else if (y >= 80 && y <= 100 && x >= 330 && x <= 350)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 160 && y <= 180 && x >= 330 && x <= 350) //square
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 100 && y <= 120 && x >= 350 && x <= 370)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 140 && y <= 160 && x >= 350 && x <= 370)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 120 && y <= 140 && x >= 370 && x <= 390) //square
//                    rgb_reg <= 12'b111111111111;   
//                else if (y >= 100 && y <= 120 && x >= 390 && x <= 410)
//                    rgb_reg <= 12'b111111111111;        
//                else if (y >= 140 && y <= 160 && x >= 390 && x <= 410)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 80 && y <= 100 && x >= 410 && x <= 430)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 160 && y <= 180 && x >= 410 && x <= 430) //square
//                    rgb_reg <= 12'b111111111111;       
                    
//                // T
//                else if (y >= 80 && y <= 100 && x >= 450 && x <= 550) //horizontal line
//                    rgb_reg <= 12'b111111111111;                          
//                else if (y >= 80 && y <= 180 && x >= 490 && x <= 510) //vertical line
//                    rgb_reg <= 12'b111111111111;    
                    
//                // L
//                else if (y >= 380 && y <= 400 && x >= 30 && x <= 130) //horizontal line
//                    rgb_reg <= 12'b111111111111;                          
//                else if (y >= 300 && y <= 400 && x >= 30 && x <= 50) //vertical line
//                    rgb_reg <= 12'b111111111111;   
                    
//                // E
//                else if (y >= 300 && y <= 320 && x >= 150 && x <= 250) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 340 && y <= 360 && x >= 150 && x <= 250)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 380 && y <= 400 && x >= 150 && x <= 250)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 300 && y <= 400 && x >= 150 && x <= 170) //vertical line
//                    rgb_reg <= 12'b111111111111;
                    
//                // V
//                else if (y >= 300 && y <= 340 && x >= 270 && x <= 290) // rectangle
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 340 && y <= 380 && x >= 290 && x <= 310) // rectangle
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 380 && y <= 400 && x >= 310 && x <= 330) //square
//                    rgb_reg <= 12'b111111111111; 
//                else if (y >= 340 && y <= 380 && x >= 330 && x <= 350) // rectangle
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 300 && y <= 340 && x >= 350 && x <= 370) // rectangle
//                    rgb_reg <= 12'b111111111111;
                    
//                // E
//                else if (y >= 300 && y <= 320 && x >= 390 && x <= 490) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 340 && y <= 360 && x >= 390 && x <= 490)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 380 && y <= 400 && x >= 390 && x <= 490)
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 300 && y <= 400 && x >= 390 && x <= 410) //vertical line
//                    rgb_reg <= 12'b111111111111;
                
//                // L
//                else if (y >= 380 && y <= 400 && x >= 510 && x <= 610) //horizontal line
//                    rgb_reg <= 12'b111111111111;                          
//                else if (y >= 300 && y <= 400 && x >= 510 && x <= 530) //vertical line
//                    rgb_reg <= 12'b111111111111;   
                
//                else if (x >= 0 && x <= 640 && y >=0 && y <= 480)    
//                    rgb_reg <= 12'b100011001000;       
//                else
//                    rgb_reg <= 12'b000000000000;
                    
                    
//            end else if (state == FAIL) begin
//                if (y >= 475 && y <= 476 && x >= 0 && x <= 12*high_score)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 475 && y <= 480 && x >= 12*high_score && x <= 12*high_score + 1)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 477 && y <= 480 && x >= 0 && x <= 12*high_score)
//                    rgb_reg <= 12'b111000000000;
//                else if (y >= 475 && y <= 476 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 470 && y <= 471 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 470 && y <= 476 && x >= 12*level && x <= 12*level + 1)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 472 && y <= 474 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000011100000;
                                    
//                // O
//                else if (y >= 190 && y <= 210 && x >= 30 && x <= 130) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 270 && y <= 290 && x >= 30 && x <= 130) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 190 && y <= 290 && x >= 30 && x <= 50) //vertical line
//                    rgb_reg <= 12'b111111111111;  
//                else if (y >= 190 && y <= 290 && x >= 110 && x <= 130) //vertical line
//                    rgb_reg <= 12'b111111111111; 
                
//                // O
//                else if (y >= 190 && y <= 210 && x >= 150 && x <= 250) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 270 && y <= 290 && x >= 150 && x <= 250) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 190 && y <= 290 && x >= 150 && x <= 170) //vertical line
//                    rgb_reg <= 12'b111111111111;  
//                else if (y >= 190 && y <= 290 && x >= 230 && x <= 250) //vertical line
//                    rgb_reg <= 12'b111111111111;                                         
                                                        
//                // P
//                else if (y >= 190 && y <= 210 && x >= 270 && x <= 370) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 230 && y <= 250 && x >= 270 && x <= 370) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 190 && y <= 290 && x >= 270 && x <= 290) //vertical line
//                    rgb_reg <= 12'b111111111111;  
//                else if (y >= 190 && y <= 240 && x >= 350 && x <= 370) 
//                    rgb_reg <= 12'b111111111111;  
                    
//                // S
//                else if (y >= 190 && y <= 210 && x >= 390 && x <= 490) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 230 && y <= 250 && x >= 390 && x <= 490) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 270 && y <= 290 && x >= 390 && x <= 490) //horizontal line
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 190 && y <= 250 && x >= 390 && x <= 410) 
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 230 && y <= 290 && x >= 470 && x <= 490) 
//                    rgb_reg <= 12'b111111111111; 
                    
                    
//                // !
//                else if (y >= 270 && y <= 290 && x >= 550 && x <= 570) //square
//                    rgb_reg <= 12'b111111111111;
//                else if (y >= 190 && y <= 250 && x >= 550 && x <= 570) //vertical line
//                    rgb_reg <= 12'b111111111111;  
                                    
//                else if (x >= 0 && x <= 640 && y >=0 && y <= 480)    
//                    rgb_reg <= 12'b110010001000;       
//                else
//                    rgb_reg <= 12'b000000000000;
                
//            end else begin
//                if (y >= 475 && y <= 476 && x >= 0 && x <= 12*high_score)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 475 && y <= 480 && x >= 12*high_score && x <= 12*high_score + 1)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 477 && y <= 480 && x >= 0 && x <= 12*high_score)
//                    rgb_reg <= 12'b111000000000;
//                else if (y >= 475 && y <= 476 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 470 && y <= 471 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 470 && y <= 476 && x >= 12*level && x <= 12*level + 1)
//                    rgb_reg <= 12'b000000000000;
//                else if (y >= 472 && y <= 474 && x >= 0 && x <= 12*level)
//                    rgb_reg <= 12'b000011100000;
               
//                else if (y >= 20 && y <= 40 && x >= 600 && x <= 620 && PERIOD <= 100_000_000) //square
//                    rgb_reg <= 12'b111111110000;
//                else if (y >= 20 && y <= 40 && x >= 560 && x <= 580 && PERIOD <= 50_000_000) //square
//                    rgb_reg <= 12'b111111110000;
//                else if (y >= 20 && y <= 40 && x >= 520 && x <= 540 && PERIOD <= 25_000_000) //square
//                    rgb_reg <= 12'b111111110000;
                    
//                else if (x >= 216 && x <= 423 && y >= 156 && y <= 157 && output_pattern == 5'b00001 && state == CORRECT) // bottom outline
//                    rgb_reg <= 12'b111100000000;
//                else if (x >= 216 && x <= 423 && y >= 6 && y <= 7 && output_pattern == 5'b00001 && state == CORRECT)     // top outline
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 216 && x <= 217 && y >= 6 && y <= 157 && output_pattern == 5'b00001 && state == CORRECT)   // left outline
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 422 && x <= 423 && y >= 6 && y <= 157 && output_pattern == 5'b00001 && state == CORRECT)   // right outline
//                    rgb_reg <= 12'b111100000000;                                             
                    
//                else if (x >= 429 && x <= 634 && y >= 316 && y <= 317 && output_pattern == 5'b00010 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;
//                else if (x >= 429 && x <= 634 && y >= 163 && y <= 164 && output_pattern == 5'b00010 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 429 && x <= 430 && y >= 163 && y <= 317 && output_pattern == 5'b00010 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 633 && x <= 634 && y >= 163 && y <= 317 && output_pattern == 5'b00010 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;       
                    
//                else if (x >= 216 && x <= 423 && y >= 323 && y <= 324 && output_pattern == 5'b00100 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;
//                else if (x >= 216 && x <= 423 && y >= 473 && y <= 474 && output_pattern == 5'b00100 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 216 && x <= 217 && y >= 323 && y <= 474 && output_pattern == 5'b00100 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 422 && x <= 423 && y >= 323 && y <= 474 && output_pattern == 5'b00100 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;     
                    
//                else if (x >= 6 && x <= 210 && y >= 316 && y <= 317 && output_pattern == 5'b01000 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;
//                else if (x >= 6 && x <= 210 && y >= 163 && y <= 164 && output_pattern == 5'b01000 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 6 && x <= 7 && y >= 163 && y <= 317 && output_pattern == 5'b01000 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 209 && x <= 210 && y >= 163 && y <= 317 && output_pattern == 5'b01000 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
                    
//                else if (x >= 216 && x <= 423 && y >= 316 && y <= 317 && output_pattern == 5'b10000 && state == CORRECT)    
//                    rgb_reg <= 12'b111100000000;
//                else if (x >= 216 && x <= 423 && y >= 163 && y <= 164 && output_pattern == 5'b10000 && state == CORRECT)    
//                    rgb_reg <= 12'b111100000000;
//                else if (x >= 216 && x <= 217 && y >= 163 && y <= 317 && output_pattern == 5'b10000 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;    
//                else if (x >= 422 && x <= 423 && y >= 163 && y <= 317 && output_pattern == 5'b10000 && state == CORRECT)
//                    rgb_reg <= 12'b111100000000;  
                                                            
                
//                else if (x >= V_EDGE1_L_BORDER && x <= V_EDGE1_R_BORDER)
//                    rgb_reg <= 12'b110011001100;
//                else if (x >= V_EDGE2_L_BORDER && x <= V_EDGE2_R_BORDER)
//                    rgb_reg <= 12'b110011001100;
//                else if (y >= H_EDGE1_T_BORDER && y <= H_EDGE1_B_BORDER && x >= 0)
//                    rgb_reg <= 12'b110011001100;
//                else if (y >= H_EDGE2_T_BORDER && y <= H_EDGE2_B_BORDER && x >= 0)
//                    rgb_reg <= 12'b110011001100;
//                else if (x >= V_CAP1_L_BORDER && x <= V_CAP1_R_BORDER && y >= V_CAP1_T_BORDER && y <= V_CAP1_B_BORDER)
//                        rgb_reg <= 12'b110011001100;
//                else if (x >= V_CAP2_L_BORDER && x <= V_CAP2_R_BORDER && y >= V_CAP2_T_BORDER && y <= V_CAP2_B_BORDER)
//                        rgb_reg <= 12'b110011001100;
//                else if (x >= H_CAP1_L_BORDER && x <= H_CAP1_R_BORDER && y >= H_CAP1_T_BORDER && y <= H_CAP1_B_BORDER)
//                        rgb_reg <= 12'b110011001100;
//                else if (x >= H_CAP2_L_BORDER && x <= H_CAP2_R_BORDER && y >= H_CAP2_T_BORDER && y <= H_CAP2_B_BORDER)
//                        rgb_reg <= 12'b110011001100;
                if (x >= BOX_ONE_L_BORDER && x <= BOX_ONE_R_BORDER && y >= BOX_ONE_T_BORDER && y <= BOX_ONE_B_BORDER && output_pattern[0])
                    rgb_reg <= 12'b111100000000;
                else if (x >= BOX_TWO_L_BORDER && x <= BOX_TWO_R_BORDER && y >= BOX_TWO_T_BORDER && y <= BOX_TWO_B_BORDER && output_pattern[1])
                    rgb_reg <= 12'b111100001111;
                else if (x >= BOX_THREE_L_BORDER && x <= BOX_THREE_R_BORDER && y >= BOX_THREE_T_BORDER && y <= BOX_THREE_B_BORDER && output_pattern[2])
                    rgb_reg <= 12'b000000001111;
                else if (x >= BOX_FOUR_L_BORDER && x <= BOX_FOUR_R_BORDER && y >= BOX_FOUR_T_BORDER && y <= BOX_FOUR_B_BORDER && output_pattern[3])
                    rgb_reg <= 12'b111111110000;
                else if (x >= 0 && x <= 640 && y >=0 && y <= 480)
                    rgb_reg <= 12'b100010001000;  
                else
                    rgb_reg <= 12'b000000000000;
            end
        end 
    //end
    
    // Output
    assign rgb = (video_on) ? rgb_reg : 12'b0; // Output only during active video region
endmodule