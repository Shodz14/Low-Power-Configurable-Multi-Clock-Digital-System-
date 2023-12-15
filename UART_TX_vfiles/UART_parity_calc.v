module UART_parity_calc 
(
    input           DATA_VALID,
    input  [7:0]    P_DATA,
    input           PAR_TYP,
    input           busy,
    input           CLK, RST,
    output  reg     par_bit
);
reg     [7:0]   p_data;

always @(posedge CLK, negedge RST) begin
    if (!RST) begin
        p_data <= 0;
        par_bit <= 0; 

    end
    else if (DATA_VALID && !busy) begin
        p_data <= P_DATA;

        case (PAR_TYP)
        1'b0: begin
            
            par_bit <= (^p_data) ;
        end
        1'b1: begin
            
            par_bit <= ~(^p_data) ;
        end
        //default: 
        endcase
    end
    
    /*
    if ( DATA_VALID && (PAR_TYP && (^p_data) | !PAR_TYP && !(^p_data) )) begin      // PAR_TYP 1: odd parity and there is odd no of 1's
        par_bit = 1'b1;
    end
    else if ( DATA_VALID && ( (PAR_TYP && !(^p_data)) | (!PAR_TYP && ((^p_data))) ) ) begin
        par_bit = 1'b0;
    end
    */
end
    
endmodule