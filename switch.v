`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2026 10:22:36 AM
// Design Name: 
// Module Name: switch
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


module switch(
    input clk,
    input rst,
    input btnL,
    input p1_switch, p1_btn1, p1_btn2, p1_btn3, p1_btn4,
    input p2_switch, p2_btn1, p2_btn2, p2_btn3, p2_btn4,
    output hsync,
    output vsync,
    output [11:0] rgb
    );
    
    // States
    localparam START = 0, DISPLAY_PATTERN = 1, DISPLAY_FLASH = 2, PLAY = 3, TEST = 4, P1_WIN = 5, P2_WIN = 6;//, CORRECT = 4, PASS = 5, FAIL = 6;
    
    // Registered Variables
    reg [3:0] state, next_state;
    reg [7:0] seed, next_seed;
    reg [3:0] round, next_round;
    reg [3:0] patterns_shown, next_patterns_shown;
    
    reg [23:0] p1_input, next_p1_input;
    reg [3:0] p1_submitted, next_p1_submitted;
    wire p1_btn1_db, p1_btn2_db, p1_btn3_db, p1_btn4_db;
    reg p1_btn1_prev, p1_btn2_prev, p1_btn3_prev, p1_btn4_prev;
    reg [3:0] p1_score, next_p1_score;
   
    reg [23:0] p2_input, next_p2_input;
    reg [3:0] p2_submitted, next_p2_submitted;
    wire p2_btn1_db, p2_btn2_db, p2_btn3_db, p2_btn4_db;
    reg p2_btn1_prev, p2_btn2_prev, p2_btn3_prev, p2_btn4_prev;
    reg [3:0] p2_score, next_p2_score;
    
    // Variables
    reg [3:0] output_pattern;
    
    reg [32:0] PERIOD;
    reg [32:0] counter;
    reg enable_counter;
    
    reg rst_gen;    
    wire [167:0] patterns;
    
    
    vga_display vga_dis_inst (.clk(clk), .reset(rst), .output_pattern(output_pattern), .state(state),
//            .level(level),
//            .high_score(next_high_score),
//            .PERIOD(PERIOD),
        .hsync(hsync), .vsync(vsync), .rgb(rgb) );
        
    //random_generator random_gen_inst (.clk(clk), .rst(rst), .rst_gen(rst_gen), .seed(seed), .patterns(patterns) );

    debouncer p11_debouncer (.clk(clk), .rst(rst), .btn(p1_btn1), .btn_db(p1_btn1_db) );
    debouncer p12_debouncer (.clk(clk), .rst(rst), .btn(p1_btn2), .btn_db(p1_btn2_db) );
    debouncer p13_debouncer (.clk(clk), .rst(rst), .btn(p1_btn3), .btn_db(p1_btn3_db) );
    debouncer p14_debouncer (.clk(clk), .rst(rst), .btn(p1_btn4), .btn_db(p1_btn4_db) );
   
    debouncer p21_debouncer (.clk(clk), .rst(rst), .btn(p2_btn1), .btn_db(p2_btn1_db) );
    debouncer p22_debouncer (.clk(clk), .rst(rst), .btn(p2_btn2), .btn_db(p2_btn2_db) );
    debouncer p23_debouncer (.clk(clk), .rst(rst), .btn(p2_btn3), .btn_db(p2_btn3_db) );
    debouncer p24_debouncer (.clk(clk), .rst(rst), .btn(p2_btn4), .btn_db(p2_btn4_db) );
        
    // Counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
        end
        else begin
            if (enable_counter) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 0;
            end
        end
    end
    
    // Initial Block
    initial begin
        state <= START;
        seed <= 8'b00000001;
        
        enable_counter <= 0;
                    
        round <= 1;
        patterns_shown <= 0;
        
        p1_input <= 24'b0;
        p1_submitted <= 0;
        p1_btn1_prev <= 0;
        p1_btn2_prev <= 0;
        p1_btn3_prev <= 0;
        p1_btn4_prev <= 0;
        p1_score <= 0;
        
        p2_input <= 24'b0;
        p2_submitted <= 0;
        p2_btn1_prev <= 0;
        p2_btn2_prev <= 0;
        p2_btn3_prev <= 0;
        p2_btn4_prev <= 0;    
        p2_score <= 0;   
    end
    
    // Sequential Block
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= START;
            seed <= 8'b00000001;
                       
            round <= 1;
            patterns_shown <= 0;
            
            p1_input <= 24'b0;
            p1_submitted <= 0;
            p1_btn1_prev <= 0;
            p1_btn2_prev <= 0;
            p1_btn3_prev <= 0;
            p1_btn4_prev <= 0;
            p1_score <= 0;
            
            p2_input <= 24'b0;
            p2_submitted <= 0;
            p2_btn1_prev <= 0;
            p2_btn2_prev <= 0;
            p2_btn3_prev <= 0;
            p2_btn4_prev <= 0;      
            p2_score <= 0;     
        end
        else begin
            state <= next_state;
            seed <= next_seed;

            round <= next_round;            
            patterns_shown <= next_patterns_shown;
           
            p1_input <= next_p1_input;
            p1_submitted <= next_p1_submitted;
            p1_btn1_prev <= p1_btn1_db;
            p1_btn2_prev <= p1_btn2_db;
            p1_btn3_prev <= p1_btn3_db;
            p1_btn4_prev <= p1_btn4_db;
            p1_score <= next_p1_score;
            
            p2_input <= next_p2_input;
            p2_submitted <= next_p2_submitted;
            p2_btn1_prev <= p2_btn1_db;
            p2_btn2_prev <= p2_btn2_db;
            p2_btn3_prev <= p2_btn3_db;
            p2_btn4_prev <= p2_btn4_db;
            p2_score <= next_p2_score;
        end
    end
    
    
    
    assign patterns = 168'b1000_0100_0010_0010_0001_0001_1000_0100_0010_1000_0010_0001;
    
    // FSM
    always @(*) begin
        next_state <= state;
        next_seed <= seed;
        rst_gen <= 0;
        
        enable_counter <= 0;
        
        next_round <= round;
        next_patterns_shown <= patterns_shown;
        
        next_p1_input <= p1_input;
        next_p1_submitted <= p1_submitted;
        next_p1_score <= p1_score;
        
        next_p2_input <= p2_input;
        next_p2_submitted <= p2_submitted;
        next_p2_score <= p2_score;
        
        if (state == START) begin
            output_pattern <= 4'b1111;
            PERIOD <= 25_000_000; //13
            if (btnL) begin
                next_patterns_shown <= 0;
                next_state <= DISPLAY_PATTERN;
                
                next_p1_submitted <= 0;
                next_p2_submitted <= 0;
            end   
        end
        
        else if (state == DISPLAY_PATTERN) begin
            output_pattern <= patterns[(round-1)*24 + patterns_shown*4 +: 4];
            enable_counter <= 1;
            if (counter >= 2*PERIOD) begin
                enable_counter <= 0;
                next_patterns_shown <= patterns_shown + 1;
                next_state <= DISPLAY_FLASH;
            end
        end
        
        else if (state == DISPLAY_FLASH) begin
            output_pattern <= 4'b0000;
            enable_counter <= 1;
            if (counter >= PERIOD) begin
                enable_counter <= 0;
                if (patterns_shown < 6) begin
                    next_state <= DISPLAY_PATTERN;
                end
                else begin
                    next_state <= PLAY;
                    next_patterns_shown <= 0;
                end
            end
        end
        
        else if (state == PLAY) begin
            output_pattern <= 4'b1111;
            if (p1_switch) begin
                if (p1_input == patterns[(round-1)*24 +: 24]) begin                    
                    next_state <= P1_WIN;
                end
            end
            else if (p1_submitted < 6) begin
                if (p1_btn1_db && !p1_btn1_prev) begin
                    next_p1_input[p1_submitted*4 +: 4] <= 4'b0001;
                    next_p1_submitted <= p1_submitted + 1;
                end
                else if (p1_btn2_db && !p1_btn2_prev) begin
                    next_p1_input[p1_submitted*4 +: 4] <= 4'b0010;
                    next_p1_submitted <= p1_submitted + 1;
                end
                else if (p1_btn3_db && !p1_btn3_prev) begin
                    next_p1_input[p1_submitted*4 +: 4] <= 4'b0100;
                    next_p1_submitted <= p1_submitted + 1;
                end
                else if (p1_btn4_db && !p1_btn4_prev) begin
                    next_p1_input[p1_submitted*4 +: 4] <= 4'b1000;
                    next_p1_submitted <= p1_submitted + 1;
                end
            end
            
            if (p2_switch) begin
                if (p2_input == patterns[(round-1)*24 +: 24]) begin                    
                    next_state <= P2_WIN;
                end
            end
            else if (p2_submitted < 6) begin
                if (p2_btn1_db && !p2_btn1_prev) begin
                    next_p2_input[p2_submitted*4 +: 4] <= 4'b0001;
                    next_p2_submitted <= p2_submitted + 1;
                end
                else if (p2_btn2_db && !p2_btn2_prev) begin
                    next_p2_input[p2_submitted*4 +: 4] <= 4'b0010;
                    next_p2_submitted <= p2_submitted + 1;
                end
                else if (p2_btn3_db && !p2_btn3_prev) begin
                    next_p2_input[p2_submitted*4 +: 4] <= 4'b0100;
                    next_p2_submitted <= p2_submitted + 1;
                end
                else if (p2_btn4_db && !p2_btn4_prev) begin
                    next_p2_input[p2_submitted*4 +: 4] <= 4'b1000;
                    next_p2_submitted <= p2_submitted + 1;
                end
            end
        end
        
        else if (state == P1_WIN) begin
            output_pattern <= 4'b0001;
            enable_counter <= 1;
            if (counter >= 2*PERIOD) begin
                enable_counter <= 0;
                next_p1_score <= p1_score + 1;
                next_round <= round + 1;
                next_state <= START;
            end
        end
        
        else if (state == P2_WIN) begin
            output_pattern <= 4'b0010;
            enable_counter <= 1;
            if (counter >= 2*PERIOD) begin
                enable_counter <= 0;
                next_p2_score <= p2_score + 1;
                next_round <= round + 1;
                next_state <= START;
            end
        end

    end

        
endmodule