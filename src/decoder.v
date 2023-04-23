module hamming_decoder(
    input [6:0] encoded_data,
    output [3:0] decoded_data,
    output error
);

wire [2:0] syndrome = {
    encoded_data[0] ^ encoded_data[2] ^ encoded_data[4] ^ encoded_data[6],
    encoded_data[1] ^ encoded_data[2] ^ encoded_data[5] ^ encoded_data[6],
    encoded_data[3] ^ encoded_data[4] ^ encoded_data[5] ^ encoded_data[6]
};

assign error = |syndrome;

assign decoded_data = {
    encoded_data[6] ^ (syndrome == 3'b111), 
    encoded_data[5] ^ (syndrome == 3'b011),
    encoded_data[4] ^ (syndrome == 3'b101), 
    encoded_data[2] ^ (syndrome == 3'b110)
};

endmodule