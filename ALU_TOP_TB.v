`timescale 1us/1ns  //100 MHz freq
module ALU_TOP_TB #(parameter in_width = 16, out_width = 16) ();

//declare testbench signals
reg [15:0]              inA_tb,inB_tb;
reg [3:0]               ALU_FUN_tb;
reg                     clk_tb,rst_tb;

wire [out_width-1:0]    arithout_tb, shiftout_tb;
wire [out_width-1:0]    logicout_tb ;
wire                    carryout_tb;
wire [1:0]              cmpout_tb;
wire                    Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, SHIFT_Flag_tb;

// Design instantiation
ALU_TOP DUT (
    .A(inA_tb),
    .B(inB_tb),
    .CLK(clk_tb),
    .RST(rst_tb),
    .ALU_FUN(ALU_FUN_tb),
    .Arith_OUT(arithout_tb),
    .SHIFT_OUT(shiftout_tb),
    .Carry_OUT(carryout_tb),
    .Logic_OUT(logicout_tb),
    .CMP_OUT(cmpout_tb),
    .Arith_Flag(Arith_Flag_tb),
    .Logic_Flag(Logic_Flag_tb),
    .CMP_Flag(CMP_Flag_tb),
    .SHIFT_Flag(SHIFT_Flag_tb)
);

// Clock Generator 40% low , 60% high
always begin
   #4 clk_tb = 1 ; 
   #6 clk_tb = 0 ;
end
//initail block
initial 
 begin
    $dumpfile("AluTOP_test.vcd"); // waveforms in this file      
    $dumpvars;
    clk_tb = 1'b0;
    rst_tb= 1'b1;
    
    //--------ARITHMETIC--------
    //test1 addition
    $display("Test case 1 addition op");
    inA_tb = 4'b0011 ;// A = 3
    inB_tb = 4'b0001; // B = 1
    #3
    ALU_FUN_tb = 4'b0000;
    #7
    if (arithout_tb== 5'b0100 && Arith_Flag_tb== 1'b1) begin
        $display("Test 1 addition is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 1 addition is NOT passed");
        $display("Arith_flag is NOT passed");
    end
    //test2  subtraction
    $display("Test case 2 subtraction op");
    #10
    inA_tb = 4'b0111 ;// A = 7
    inB_tb = 4'b0010; // B = 2
    #3
    ALU_FUN_tb = 4'b0001;
    #7
    if (arithout_tb == 5'b0101 && Arith_Flag_tb== 1'b1) begin
        $display("Test 2 subtraction is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 2 subtraction is NOT passed");
        $display("Arith_flag is NOT passed");
    end
    //test3 reset button
    $display("Test case 3 reset button");
    #3
    rst_tb= 1'b0;
    #3
    rst_tb= 1'b1;
    #6 
    if (arithout_tb == 2'b0 && shiftout_tb == 2'b0 && carryout_tb== 2'b0 && logicout_tb== 2'b0 && cmpout_tb== 2'b0) begin
        $display("Test case 3 reset button is Passed");
    end
    else begin
        $display("Test case 3 reset button is NOT Passed");
    end
    //test4 multiplication
    $display("Test case 4 multiplication op");
    #8                          //why the waveform is 2ns shifted right ??!
    inA_tb = 4'b0011 ;// A = 3
    inB_tb = 4'b0010; // B = 2
    #3
    ALU_FUN_tb = 4'b0010;
    #7
    if (arithout_tb== 5'b0110 && Arith_Flag_tb== 1'b1 ) begin
        $display("Test 4 multiplication is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 4 multiplication is NOT passed");
        $display("Arith_flag is NOT passed");
    end
    //test5 Divison
    $display("Test case 5 Divison op");
    #10
    inA_tb = 4'b0110 ;// A = 6
    inB_tb = 4'b0010; // B = 2
    #3
    ALU_FUN_tb = 4'b0011;
    #7
    if (arithout_tb==5'b0011 && Arith_Flag_tb== 1'b1 ) begin
        $display("Test 5 Divison is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 5 Divison is NOT passed");
        $display("Arith_flag is NOT passed");
    end

    //-------LOGIC-------
    //test6         AND
    #10 
    inA_tb = 4'b0111;
    inB_tb = 4'b1101; //expected out= b0101
    $display("Test case 6 AND is ongoing");
    #3
    ALU_FUN_tb = 4'b0100;
    #7
    if (logicout_tb == 4'b0101 && Logic_Flag_tb== 1'b1) begin
        $display("Test 6 AND is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 6 AND is NOT passed");
        $display("Logic_flag is NOT passed");
    end

    //test7         OR
    #10 
    inA_tb = 4'b0011;
    inB_tb = 4'b0101; //expected out= b0111
    $display("Test case 7 OR is ongoing");
    #3
    ALU_FUN_tb = 4'b0101;
    #7
    if (logicout_tb == 4'b0111 && Logic_Flag_tb== 1'b1) begin
        $display("Test 7 OR is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 7 OR is NOT passed");
        $display("Logic_flag is NOT passed");
    end

    //test8         NAND
    #10 
    inA_tb =  16'b1111111111111101;
    inB_tb =  16'b1111111111111110; //expected out= b0011
    $display("Test case 8 NAND is ongoing");
    #3
    ALU_FUN_tb = 4'b0110;
    #7
    if (logicout_tb == 4'b0011 && Logic_Flag_tb== 1'b1) begin
        $display("Test 8 NAND is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 8 NAND is NOT passed");
        $display("Logic_flag is NOT passed");
    end

    //test9         NOR
    #10 
    inA_tb = 16'b1111111111111001;
    inB_tb = 16'b1111111111111000; //expected out= b1000
    $display("Test case 9 NOR is ongoing");
    #3
    ALU_FUN_tb = 4'b0111;
    #7
    if (logicout_tb == 4'b0110 && Logic_Flag_tb== 1'b1) begin
        $display("Test 9 NOR is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 9 NOR is NOT passed");
        $display("Logic_flag is NOT passed");
    end

    //-------COMPARISON------
    //test10        NOP
    #10
    $display("Test case 10 NOP is ongoing");
    #3
    ALU_FUN_tb = 4'b1000;
    #7
    if (cmpout_tb == 1'b0 && CMP_Flag_tb == 1'b1) begin
        $display("Test 10 NOP is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 10 NOP is NOT passed");
        $display("CMP_flag is NOT passed");
    end
    //test11        A == B
    #10
    inA_tb = 4'b0111;
    inB_tb = 4'b0111;
    $display("Test case 11 Equality comparison is ongoing");
    #3
    ALU_FUN_tb = 4'b1001;
    #7
    if (cmpout_tb == 1'b1 && CMP_Flag_tb == 1'b1) begin
        $display("Test 11 Equality comparison is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 11 Equality comparison is NOT passed");
        $display("CMP_flag is NOT passed");
    end
    //test12        A > B
    #10
    inA_tb = 4'b0111; //A=7
    inB_tb = 4'b0110; //B=6
    $display("Test case 12 Greater comparison is ongoing");
    #3
    ALU_FUN_tb = 4'b1010;
    #7
    if (cmpout_tb == 2'b10 && CMP_Flag_tb == 1'b1) begin
        $display("Test 12 A greater than B comparison is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 12 A greater than B comparison is NOT passed");
        $display("CMP_flag is NOT passed");
    end
    //test13        A < B
    #10
    inA_tb = 4'b0011; //A=3
    inB_tb = 4'b0111; //B=7
    $display("Test case 13 Less comparison is ongoing");
    #3
    ALU_FUN_tb = 4'b1011;
    #7
    if (cmpout_tb == 2'b11 && CMP_Flag_tb == 1'b1) begin
        $display("Test 13 A less than B comparison is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 13 A less than B comparison is NOT passed");
        $display("CMP_flag is NOT passed");
    end

    //------SHIFTING-----
    //test14        Right shift
    #10
    inA_tb = 4'b0011; //A=3
    $display("Test case 14 right shift is ongoing");
    #3
    ALU_FUN_tb = 4'b1100;
    #7
    if (shiftout_tb == 4'b0001 && SHIFT_Flag_tb==1'b1  ) begin
        $display("Test 14 right shift A is passed");
        $display("shft_flag is passed");
    end
    else begin
        $display("Test 14 right shift A is NOT passed");
        $display("shft_flag is NOT passed");
    end
    //test15        Left shift
    #10
    inA_tb = 4'b0011; //A=3
    $display("Test case 15 Left shift is ongoing");
    #3
    ALU_FUN_tb = 4'b1101;
    #7
    if (shiftout_tb == 4'b0110 && SHIFT_Flag_tb==1'b1) begin
        $display("Test 15 Left shift A is passed");
        $display("shft_flag is passed");
    end
    else begin
        $display("Test 15 Left shift A is NOT passed");
        $display("shft_flag is NOT passed");
    end

    //test16        Right shift
    #10
    inB_tb = 4'b0011; //B=3
    $display("Test case 16 right shift is ongoing");
    #3
    ALU_FUN_tb = 4'b1110;
    #7
    if (shiftout_tb == 4'b0001 && SHIFT_Flag_tb==1'b1  ) begin
        $display("Test 16 right shift B is passed");
        $display("shft_flag is passed");
    end
    else begin
        $display("Test 16 right shift B is NOT passed");
        $display("shft_flag is NOT passed");
    end
    //test17        Left shift
    #10
    inB_tb = 4'b0011; //B=3
    $display("Test case 17 Left shift is ongoing");
    #3
    ALU_FUN_tb = 4'b1111;
    #7
    if (shiftout_tb == 4'b0110 && SHIFT_Flag_tb==1'b1) begin
        $display("Test 17 Left shift B is passed");
        $display("shft_flag is passed");
    end
    else begin
        $display("Test 17 Left shift B is NOT passed");
        $display("shft_flag is NOT passed");
    end

    $stop;


 end

endmodule

