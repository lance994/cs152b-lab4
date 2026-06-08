module random_generator (
    input  wire          clk,
    input  wire          rst,
    input  wire          rst_gen,
    input  wire [7:0]    seed,
    output reg  [167:0]  patterns  // 7 rounds * 6 patterns * 4 bits = 168
);
    reg [3:0] temp_pattern;
    reg [7:0] lfsr;
    reg [5:0] pattern_count;
    reg       generating;

    always @(posedge clk or posedge rst or posedge rst_gen) begin
        if (rst || rst_gen) begin
            lfsr          <= rst ? 8'b0000_0001 : seed;
            patterns      <= 168'b0;
            pattern_count <= 0;
            generating    <= 1;
        end
        else if (generating) begin
            patterns[pattern_count * 4 +: 4] <= 4'b0001 << lfsr[1:0]; 
            lfsr          <= {lfsr[6:0], lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]};
            pattern_count <= pattern_count + 1;

            if (pattern_count == 41) begin  
                generating <= 0;
            end
        end
    end

endmodule
