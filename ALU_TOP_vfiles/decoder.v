module decoder (
    input   [1:0]   Alu_fun_Dec,
    //input         clk,rst,
    output  reg     Arith_en, Logic_en, CMP_en, Shift_en
);
   
    always @(*) begin
      case (Alu_fun_Dec)

        2'b00:  {Arith_en, Logic_en, CMP_en, Shift_en} = 4'b1000;
        2'b01:  {Arith_en, Logic_en, CMP_en, Shift_en} = 4'b0100;
        2'b10:  {Arith_en, Logic_en, CMP_en, Shift_en} = 4'b0010;
        2'b11:  {Arith_en, Logic_en, CMP_en, Shift_en} = 4'b0001;
        
      endcase
        
    end
  
endmodule