module cmp_unit #(parameter in_width = 16, out_width = 16)
(
    input       [in_width-1:0]  inA, inB,
    input                       clk, rst, cmp_en,
    input       [1:0]           Alu_fun_cmp,
    output  reg [1:0]           cmp_out,
    output  reg                 cmp_flag
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        cmp_out <= 1'b0;
        cmp_flag <= 1'b0;
    end
    else if (cmp_en) begin
        cmp_flag <= 1'b1;
        case (Alu_fun_cmp)
            2'b00: cmp_out <= 1'b0;         //NOP
            2'b01: if (inA == inB) begin    //CMP: A = B
               cmp_out <= 1'b1 ;
            end
            else cmp_out <= 1'b0 ;
            2'b10: if (inA > inB) begin     //CMP: A > B
                cmp_out <= 2'b10 ;
            end
            else cmp_out <= 1'b0;                  
            2'b11: if (inA < inB) begin     //CMP: A < B
                cmp_out <= 2'b11 ;
            end
            else cmp_out <= 1'b0;

        endcase
    end
    else begin
        cmp_out <= 1'b0;
        cmp_flag <= 1'b0;
    end
end

/*always @(Alu_fun_cmp) begin
    cmp_flag <= (Alu_fun_cmp >= (2'b0) && Alu_fun_cmp <= (2'b11)) ? 1'b1 : 1'b0;
end*/
    
endmodule