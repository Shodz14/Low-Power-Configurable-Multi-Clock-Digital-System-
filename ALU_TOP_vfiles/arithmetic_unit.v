module arithmetic_unit #(parameter in_width = 16, out_width = 16)
(
    input       [in_width-1:0]  inA, inB,
    input                       clk, rst, arith_en,
    input       [1:0]           Alu_fun_Arth,
    output reg  [out_width-1:0] arith_out,
    output reg                  carry_out,
    output reg                  arith_flag
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        {carry_out,arith_out} <= 2'b00;
        arith_flag <= 1'b0;
    end
    else if (arith_en) begin
        arith_flag <= 1'b1;
        case (Alu_fun_Arth)
            2'b00: {carry_out,arith_out} <= inA + inB;  //Addition
            //if we used (out_width = 32)
            //{arith_out[2n-1:n+1],carry_out,arith_out[n-1:0]}
            2'b01: {carry_out,arith_out} <= inA - inB;  //Subtraction
            2'b10: {carry_out,arith_out} <= inA * inB;  //Multiplication
            2'b11: {carry_out,arith_out} <= inA / inB;  //Division
             
        endcase
    end
    else begin
        arith_out <= 16'b00;
        arith_flag <= 1'b0;
    end

end

/*always @(Alu_fun_Arth) begin
    arith_flag <= (Alu_fun_Arth >= (2'b0) && Alu_fun_Arth <= (2'b11)) ? 1'b1 : 1'b0;
end*/

    
endmodule