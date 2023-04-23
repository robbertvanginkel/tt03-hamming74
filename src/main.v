module robbertvanginkel_hamming74 (
    input [7:0] io_in,
    output [7:0] io_out
);

wire [6:0] encoder_out_data;
wire [6:0] decoder_out_data;

hamming_encoder hamming_encoder(
    .in_data(io_in[4:1]),
    .out_data(encoder_out_data)
);

hamming_decoder hamming_decoder(
    .in_data(io_in[6:1]),
    .out_data(decoder_out_data)
);

always @(*) begin
    if (io_in[0] == 1'b0) begin
        io_out[6:0] = encoder_out_data;
    end
    else begin
        io_out[6:0] = decoder_out_data;
    end
end

endmodule
