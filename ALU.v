module ALU (
    input   [15:0]  inA , inB,
    input   [3:0]   ALU_FUN,
    input           CLK,
    output          Arith_flag, Logic_flag, 
    output          CMP_flag, Shift_flag,
    output reg [15:0]  ALU_OUT
);

always @(posedge CLK) begin
    case (ALU_FUN)
        //Arithmetic
        4'b0000: ALU_OUT <= inA + inB ;
        4'b0001: ALU_OUT <= inA - inB ;
        4'b0010: ALU_OUT <= inA * inB ;
        4'b0011: ALU_OUT <= inA / inB ;
        //Logic
        4'b0100: ALU_OUT <= (inA) & (inB);//AND
        4'b0101: ALU_OUT <= (inA) | (inB);//OR
        4'b0110: ALU_OUT <= ~((inA) & (inB));//NAND
        4'b0111: ALU_OUT <= ~((inA) | (inB));//NOR
        4'b1000: ALU_OUT <= (inA) ^ (inB);//XOR
        4'b1001: ALU_OUT <= ~((inA) ^ (inB));//XNOR
        //CMP
        4'b1010: if (inA == inB) begin
            ALU_OUT <= 1'b1 ;
        end
        else ALU_OUT <= 1'b0;

        4'b1011: if (inA > inB) begin
            ALU_OUT <= 2'b10;
        end
        else ALU_OUT <= 1'b0;

        4'b1100: if (inA < inB) begin
            ALU_OUT <= 2'b11;
        end
        else ALU_OUT<= 1'b0;

        //shift
        4'b1101: ALU_OUT <= inA >> 1'b1;
        4'b1110: ALU_OUT <= inA << 1'b1;

        default: ALU_OUT <= 32'b0 ;
    endcase
    
end

assign Arith_flag = (ALU_FUN <=(4'b0011) && ALU_FUN >=(4'b0000))? 1'b1 : 1'b0;
assign Logic_flag = (ALU_FUN <=(4'b1001) && ALU_FUN >=(4'b0100))? 1'b1 : 1'b0;
assign CMP_flag =   (ALU_FUN <=(4'b1100) && ALU_FUN >=(4'b1010))? 1'b1 : 1'b0;
assign Shift_flag = (ALU_FUN ==(4'b1101) || ALU_FUN ==(4'b1110))? 1'b1 : 1'b0;
    
    
endmodule