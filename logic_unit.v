module logic_unit #(parameter in_width = 16, out_width = 16)
(
    input       [in_width-1:0]  inA, inB,
    input                       clk, rst, logic_en,
    input       [1:0]           Alu_fun_Logic,
    output  reg [out_width:0]   logic_out,
    output  reg                 logic_flag
);
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        logic_out <= 1'b0;
        logic_flag<= 1'b0;
    end
    else if (logic_en) begin
        logic_flag<= 1'b1;
        case (Alu_fun_Logic)
            2'b00: logic_out <= inA & inB;      //AND
            2'b01: logic_out <= inA | inB;      //OR
            2'b10: logic_out <= ~(inA & inB);   //NAND
            2'b11: logic_out <= ~(inA | inB);   //NOR
             
        endcase
    end
    else begin
        logic_out <= 1'b0;
        logic_flag<= 1'b0;
    end
    
end

/*always @(logic_out) begin   
    logic_flag <= (Alu_fun_Logic >= (2'b0) && Alu_fun_Logic <= (2'b11)) ? 1'b1 : 1'b0;
end*/
    
endmodule