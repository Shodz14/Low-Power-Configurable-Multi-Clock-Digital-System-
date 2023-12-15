module UART_FSM 
(
    input               CLK, RST,
    input               DATA_VALID, PAR_EN,
    input               ser_done,
    output  reg [1:0]   mux_sel, 
    output  reg         busy, ser_en
);
reg     [1:0]   current_state, next_state;

parameter idle = 3'b000;
parameter start = 3'b001  , ser = 3'b010 , parity = 3'b011 , stop = 3'b100;

/////////////// FSM Module
always @(posedge CLK, negedge RST) begin // FSM Sequential logic
    if (!RST) begin
        current_state <= idle;
        busy <= 1'b0;                   // low during idle
    end
    else current_state <= next_state;
 end


always @(*)      // FSM function,  we have 5 states: idle , processing , start stop parity
 begin
    case (current_state)
        idle: begin
            busy = 1'b0;
            ser_en = 1'b0;
            //ser_done= 0;
            //&& (!ser_done) | stp_flag
            if (DATA_VALID  )    // a flag indicating stop is done
             begin
              busy = 1'b1;                       // busy high during transmission
              mux_sel = start;
              next_state = start;
             end
            else next_state = idle;
        end 

        start: begin
            busy = 1'b1;                       // busy high during transmission
            mux_sel = start;
            next_state = ser;
            ser_en = 1'b1;
        end

        ser: begin
            busy = 1'b1;                       // busy high during transmission
            mux_sel = ser;
            if (ser_done && PAR_EN) begin
                ser_en = 1'b0;
                next_state = parity;
             end
            else if (ser_done && !(PAR_EN)) begin
                ser_en = 1'b0;
                next_state = stop;
             end
            else next_state = ser;    
        end
        
        parity: begin
            busy = 1'b1;                       // busy high during transmission
            mux_sel = parity;
            next_state = stop;
        end

        stop: begin
            busy = 1'b1;                       // busy high during transmission
            mux_sel = stop;
            if (DATA_VALID) begin
                next_state = start ;   // check this line ASAP
            end
            else next_state = idle ;   // check this line ASAP
        end

        default: next_state = idle ;
    endcase
    
 end


endmodule