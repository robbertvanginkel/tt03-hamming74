module hamming_encoder(
    input [3:0] data_in,
    output [6:0] encoded_data
);

wire p1, p2, p4;

// Parity bits calculation
assign p1 = data_in[0] ^ data_in[1] ^ data_in[3];
assign p2 = data_in[0] ^ data_in[2] ^ data_in[3];
assign p4 = data_in[1] ^ data_in[2] ^ data_in[3];

// Encoded data output
assign encoded_data[0] = p1;
assign encoded_data[1] = p2;
assign encoded_data[2] = data_in[0];
assign encoded_data[3] = p4;
assign encoded_data[4] = data_in[1];
assign encoded_data[5] = data_in[2];
assign encoded_data[6] = data_in[3];

endmodule
