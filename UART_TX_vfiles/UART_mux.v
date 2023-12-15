module UART_mux 
(
    input           CLK, RST,
    input   [2:0]   mux_sel,
    input           ser_data, par_bit,
    output  reg     mux_out
);

parameter idle = 3'b000;
parameter start = 3'b001  , ser = 3'b010 , parity = 3'b011 , stop = 3'b100;
parameter start_bit = 1'b0, stop_bit = 1'b1;
reg             stp_flag;

/*typedef enum{
          idle,
          start,
          ser,
          parity,
          stop
} state_;
state_ mux_sel; */
/////////////// MUX Module
always @(*) begin            // MUX Function
         case (mux_sel)
             start: mux_out <= start_bit;             
             
             stop:  
              begin  
                mux_out <= stop_bit; 
                stp_flag <= 1'b1;
              end
             
             ser:   mux_out <= ser_data;
             
             parity: 
              begin
                mux_out <= par_bit;
              end 
             idle: 
             begin
                mux_out <= 1'b1;
             end
             default: mux_out <= 1'b1;      // is high in the IDLE case (No transmission).
         endcase

    
 end
    
endmodule