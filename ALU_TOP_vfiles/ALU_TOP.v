module ALU_TOP #(parameter in_width = 16, out_width = 16)
(
    input        [in_width-1:0]  A, B,
    input                        CLK, RST,
    input        [3:0]           ALU_FUN,
    output  wire [out_width-1:0] Arith_OUT, SHIFT_OUT,
    output  wire                 Carry_OUT,
    output  wire [out_width:0]   Logic_OUT,
    output  wire [1:0]           CMP_OUT,
    output  wire                 Arith_Flag, Logic_Flag, CMP_Flag, SHIFT_Flag
);
    wire en_arith, en_logic, en_cmp, en_shft;

    decoder U_Decoder (
        .Alu_fun_Dec(ALU_FUN[3:2]),
        .Arith_en(en_arith),
        .Logic_en(en_logic),
        .CMP_en(en_cmp),
        .Shift_en(en_shft)
    );
    arithmetic_unit U_ari (
        .inA(A),
        .inB(B),
        .clk(CLK),
        .rst(RST),
        .arith_en(en_arith),
        .Alu_fun_Arth(ALU_FUN[1:0]),
        .arith_out(Arith_OUT),
        .carry_out(Carry_OUT),
        .arith_flag(Arith_Flag)
    );
    logic_unit U_logic (
        .inA(A),
        .inB(B),
        .clk(CLK),
        .rst(RST),
        .logic_en(en_logic),
        .Alu_fun_Logic(ALU_FUN[1:0]),
        .logic_out(Logic_OUT),
        .logic_flag(Logic_Flag)
    );
    cmp_unit U_CMP (
        .inA(A),
        .inB(B),
        .clk(CLK),
        .rst(RST),
        .cmp_en(en_cmp),
        .Alu_fun_cmp(ALU_FUN[1:0]),
        .cmp_out(CMP_OUT),
        .cmp_flag(CMP_Flag)
    );
    shift_unit U_shift (
        .inA(A),
        .inB(B),
        .clk(CLK),
        .rst(RST),
        .shift_en(en_shft),
        .Alu_fun_shift(ALU_FUN[1:0]),
        .shift_out(SHIFT_OUT),
        .shift_flag(SHIFT_Flag)
    );
/*assign Arith_Flag = (ALU_FUN <=(4'b0011) && ALU_FUN >=(4'b0000) && RST)? 1'b1 : 1'b0;
assign Logic_Flag = (ALU_FUN <=(4'b0111) && ALU_FUN >=(4'b0100) && RST)? 1'b1 : 1'b0;
assign CMP_Flag =   (ALU_FUN <=(4'b1011) && ALU_FUN >=(4'b1000) && RST)? 1'b1 : 1'b0;
assign Shift_Flag = (ALU_FUN <=(4'b1111) || ALU_FUN ==(4'b1100) && RST)? 1'b1 : 1'b0;
*/
    

endmodule