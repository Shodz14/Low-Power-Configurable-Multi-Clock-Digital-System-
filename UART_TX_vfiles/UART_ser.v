module UART_ser 
(
    input   [7:0]   P_DATA,
    input           DATA_VALID,
    input           ser_en, busy,
    input           CLK,RST,
    output  reg     ser_data,
    output  reg     ser_done
);

reg     [7:0]   p_data;
integer         counter1;
/////////////// Serializer Module
always @(posedge CLK, negedge RST) begin
    if (!RST) begin
        counter1 <= 1'b0;
        p_data <= 8'b0;
        //ser_done <= 1'b0;
     end
     else if (counter1 == 4'd8) begin
        counter1 <= 1'b0;
     end
    else if (!ser_en && !busy && DATA_VALID) begin
        p_data <= P_DATA;
        counter1 <= 1'b0;
    end
    else if (ser_en) begin
        ser_data <= p_data[counter1];
        counter1 <= counter1 + 1;
     end
 end

 
always @(*) begin
    if (counter1 == 4'd8) begin
            //counter1 = 1'b0;
            ser_done = 1'b1;
        end
    else ser_done = 1'b0;
 end

endmodule