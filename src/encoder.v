module hamming_encoder(
    input [3:0] in_data,
    output [6:0] encoded_data
);

wire p1, p2, p4;

// Parity bits calculation
assign p1 = in_data[0] ^ in_data[1] ^ in_data[3];
assign p2 = in_data[0] ^ in_data[2] ^ in_data[3];
assign p4 = in_data[1] ^ in_data[2] ^ in_data[3];

// Encoded data output
assign encoded_data[0] = p1;
assign encoded_data[1] = p2;
assign encoded_data[2] = in_data[0];
assign encoded_data[3] = p4;
assign encoded_data[4] = in_data[1];
assign encoded_data[5] = in_data[2];
assign encoded_data[6] = in_data[3];

endmodule
