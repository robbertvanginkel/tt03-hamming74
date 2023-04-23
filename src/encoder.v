module hamming_encoder(
    input [3:0] in_data,
    output [6:0] encoded_data
);

assign encoded_data = {
    in_data[3],
    in_data[2],
    in_data[1],
    in_data[1] ^ in_data[2] ^ in_data[3], // p4
    in_data[0],
    in_data[0] ^ in_data[2] ^ in_data[3], // p2
    in_data[0] ^ in_data[1] ^ in_data[3]  // p1
};

endmodule
