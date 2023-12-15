module UART_tx
(
    input           CLK, RST,
    input           PAR_EN, PAR_TYP,
    input           DATA_VALID,
    input   [7:0]   P_DATA,
    output  wire    Busy,
    output  wire    TX_OUT  //LSB is first serial outed
);

wire        SER_DATA, SER_EN, SER_DONE;
wire        PAR_BIT; 
wire [2:0]  MUX_SEL;


UART_FSM U_FSM (
    .CLK(CLK),
    .RST(RST),
    .ser_done(SER_DONE),
    .DATA_VALID(DATA_VALID),
    .PAR_EN(PAR_EN),
    .mux_sel(MUX_SEL),
    .busy(Busy),
    .ser_en(SER_EN)
);

UART_mux U_MUX (
    .CLK(CLK),
    .RST(RST),
    .mux_sel(MUX_SEL),
    .ser_data(SER_DATA),
    .par_bit(PAR_BIT),
    .mux_out(TX_OUT)
);

UART_parity_calc U_PAR (
    .CLK(CLK),
    .RST(RST),
    .DATA_VALID(DATA_VALID),
    .P_DATA(P_DATA),
    .PAR_TYP(PAR_TYP),
    .par_bit(PAR_BIT),
    .busy(Busy)
);

UART_ser U_SER (
    .CLK(CLK),
    .RST(RST),
    .P_DATA(P_DATA),
    .ser_en(SER_EN),
    .ser_data(SER_DATA),
    .ser_done(SER_DONE),
    .busy(Busy),
    .DATA_VALID(DATA_VALID)
);

endmodule