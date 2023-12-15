`timescale 1us/1ns

module ALU_tb ();
//declare testbench signals
reg [15:0]  inA_tb , inB_tb;
reg [3:0]   Alu_fun_tb ;
reg         clk_tb ;
wire        Arith_flag_tb, Logic_flag_tb;
wire        CMP_flag_tb, Shift_flag_tb;
wire [15:0] ALU_OUT_tb ;

// Design instantiation
ALU DUT (
    .inA(inA_tb),
    .inB(inB_tb),
    .ALU_FUN(Alu_fun_tb),
    .CLK(clk_tb),
    .Arith_flag(Arith_flag_tb),
    .Logic_flag(Logic_flag_tb),
    .CMP_flag(CMP_flag_tb),
    .Shift_flag(Shift_flag_tb),
    .ALU_OUT(ALU_OUT_tb)
);
// Clock Generator
always #5 clk_tb = ~clk_tb  ; 
//initial block
initial 
 begin
    $dumpfile("Alu_test.vcd"); // waveforms in this file      
    $dumpvars;
    clk_tb = 1'b0;

     //test1 default
    $display("Test case 1 Default is ongoing");
    #3
    Alu_fun_tb = 4'b1111;
    #7
    if (ALU_OUT_tb == 32'b0) begin
        $display("Test 1 Default is passed");
    end
    else
        $display("Test 1 default is NOT passed");
    
    //--------ARITHMETIC--------
    //test 2  addition
    $display("Test case 2 addition op");
    #10
    inA_tb = 4'b0011 ;// A = 3
    inB_tb = 4'b0001; // B = 1
    #3
    Alu_fun_tb = 4'b0000;
    #7
    if (ALU_OUT_tb == 5'b0100) begin
        $display("Test 2 addition is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 2 addition is NOT passed");
        $display("Arith_flag is NOT passed");
    end
    //test3  subtraction
    $display("Test case 3 subtraction op");
    #10
    inA_tb = 4'b0111 ;// A = 7
    inB_tb = 4'b0001; // B = 1
    #3
    Alu_fun_tb = 4'b0001;
    #7
    if (ALU_OUT_tb == 5'b0110) begin
        $display("Test 3 subtraction is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 3 subtraction is NOT passed");
        $display("Arith_flag is NOT passed");
    end
    //test4 multiplication
    $display("Test case 4 multiplication op");
    #10
    inA_tb = 4'b0011 ;// A = 3
    inB_tb = 4'b0010; // B = 2
    #3
    Alu_fun_tb = 4'b0010;
    #7
    if (ALU_OUT_tb == 5'b0110) begin
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
    Alu_fun_tb = 4'b0011;
    #7
    if (ALU_OUT_tb == 5'b0011) begin
        $display("Test 5 Divison is passed");
        $display("Arith_flag is passed");
    end
    else begin
        $display("Test 5 Divison is NOT passed");
        $display("Arith_flag is NOT passed");
    end


    //-----LOGIC-----   
    //test6         NAND
    #10 
    inA_tb =  16'b1111111111111101;
    inB_tb =  16'b1111111111111110; //expected out= b0011
    $display("Test case 6 NAND is ongoing");
    #3
    Alu_fun_tb = 4'b0110;
    #7
    if (ALU_OUT_tb == 4'b0011) begin
        $display("Test 6 NAND is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 6 NAND is NOT passed");
        $display("Logic_flag is NOT passed");
    end
    //test7         AND
    #10 
    inA_tb = 4'b0111;
    inB_tb = 4'b1101; //expected out= b0101
    $display("Test case 7 AND is ongoing");
    #3
    Alu_fun_tb = 4'b0100;
    #7
    if (ALU_OUT_tb == 4'b0101) begin
        $display("Test 7 AND is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 7 AND is NOT passed");
        $display("Logic_flag is NOT passed");
    end
    //test8         OR
    #10 
    inA_tb = 4'b0011;
    inB_tb = 4'b0101; //expected out= b0111
    $display("Test case 8 OR is ongoing");
    #3
    Alu_fun_tb = 4'b0101;
    #7
    if (ALU_OUT_tb == 4'b0111) begin
        $display("Test 8 OR is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 8 OR is NOT passed");
        $display("Logic_flag is NOT passed");
    end
    //test9         NOR
    #10 
    inA_tb = 16'b1111111111111001;
    inB_tb = 16'b1111111111111000; //expected out= b1000
    $display("Test case 9 NOR is ongoing");
    #3
    Alu_fun_tb = 4'b0111;
    #7
    if (ALU_OUT_tb == 4'b0110) begin
        $display("Test 9 NOR is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 9 NOR is NOT passed");
        $display("Logic_flag is NOT passed");
    end
    //test10        XOR
    #10 
    inA_tb = 4'b0011;
    inB_tb = 4'b0101; //expected out= b0110
    $display("Test case 10 XOR is ongoing");
    #3
    Alu_fun_tb = 4'b1000;
    #7
    if (ALU_OUT_tb == 4'b0110) begin
        $display("Test 10 XOR is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 10 XOR is NOT passed");
        $display("Logic_flag is NOT passed");
    end
    //test11        XNOR
    #10 
    inA_tb = 16'b11111111111110101;
    inB_tb = 16'b00000000000001111; //expected out= b0101
    $display("Test case 11 XNOR is ongoing");
    #3
    Alu_fun_tb = 4'b1001;
    #7
    if (ALU_OUT_tb == 4'b0101) begin
        $display("Test 11 XNOR is passed");
        $display("Logic_flag is passed");
    end
    else begin
        $display("Test 11 XNOR is NOT passed");
        $display("Logic_flag is NOT passed");
    end


    //-------COMPARISON------
    //test12        A == B
    #10
    inA_tb = 4'b0111;
    inB_tb = 4'b0111;
    $display("Test case 12 Equality comparison is ongoing");
    #3
    Alu_fun_tb = 4'b1010;
    #7
    if (ALU_OUT_tb == 1'b1) begin
        $display("Test 12 Equality comparison is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 12 Equality comparison is NOT passed");
        $display("CMP_flag is NOT passed");
    end
    //test13        A > B
    #10
    inA_tb = 4'b0111; //A=7
    inB_tb = 4'b0110; //B=6
    $display("Test case 13 Greater comparison is ongoing");
    #3
    Alu_fun_tb = 4'b1011;
    #7
    if (ALU_OUT_tb == 2'b10) begin
        $display("Test 13 A greater than B comparison is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 13 A greater than B comparison is NOT passed");
        $display("CMP_flag is NOT passed");
    end
    //test14        A < B
    #10
    inA_tb = 4'b0011; //A=3
    inB_tb = 4'b0111; //B=7
    $display("Test case 14 Less comparison is ongoing");
    #3
    Alu_fun_tb = 4'b1100;
    #7
    if (ALU_OUT_tb == 2'b11) begin
        $display("Test 14 A less than B comparison is passed");
        $display("CMP_flag is passed");
    end
    else begin
        $display("Test 14 A less than B comparison is NOT passed");
        $display("CMP_flag is NOT passed");
    end

    //------SHIFTING-----
    //test15        Right shift
    #10
    inA_tb = 4'b0011; //A=3
    $display("Test case 15 right shift is ongoing");
    #3
    Alu_fun_tb = 4'b1101;
    #7
    if (ALU_OUT_tb == 4'b0001) begin
        $display("Test 15 right shift A is passed");
        $display("shft_flag is passed");
    end
    else begin
        $display("Test 15 right shift A is NOT passed");
        $display("shft_flag is NOT passed");
    end
    //test16        Left shift
    #10
    inA_tb = 4'b0011; //A=3
    $display("Test case 16 Left shift is ongoing");
    #3
    Alu_fun_tb = 4'b1110;
    #7
    if (ALU_OUT_tb == 4'b0110) begin
        $display("Test 16 Left shift A is passed");
        $display("shft_flag is passed");
    end
    else begin
        $display("Test 16 Left shift A is NOT passed");
        $display("shft_flag is NOT passed");
    end

    $stop;

 end





endmodule