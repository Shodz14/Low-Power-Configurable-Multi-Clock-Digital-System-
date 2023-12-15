module shift_unit #(parameter in_width = 16, out_width = 16)
(
    input       [in_width-1:0]  inA, inB,
    input                       clk, rst, shift_en,
    input       [1:0]           Alu_fun_shift,
    output  reg [out_width-1:0]   shift_out,
    output  reg                 shift_flag
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        shift_out <= 1'b0;
        shift_flag <= 1'b0;
    end
    else if (shift_en) begin
        shift_flag <= 1'b1;
        case (Alu_fun_shift)
            2'b00: shift_out <= inA >> 1'b1 ;   //A >> 1
            2'b01: shift_out <= inA << 1'b1 ;   //A << 1
            2'b10: shift_out <= inB >> 1'b1 ;   //B >> 1
            2'b11: shift_out <= inB << 1'b1 ;   //B << 1
        endcase
        
    end
    else begin
        shift_out <= 1'b0;
        shift_flag <= 1'b0;
    end
end

/*always @(Alu_fun_shift) begin
    shift_flag <= (Alu_fun_shift >= (2'b0) && Alu_fun_shift <= (2'b11)) ? 1'b1 : 1'b0;
end*/

endmodule