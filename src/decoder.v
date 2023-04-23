module hamming_decoder(
    input [6:0] encoded_data,
    output reg [3:0] decoded_data,
    output reg error
);

wire p1, p2, p4;

assign p1 = encoded_data[0] ^ encoded_data[2] ^ encoded_data[4] ^ encoded_data[6];
assign p2 = encoded_data[1] ^ encoded_data[2] ^ encoded_data[5] ^ encoded_data[6];
assign p4 = encoded_data[3] ^ encoded_data[4] ^ encoded_data[5] ^ encoded_data[6];

assign error = (p1 != encoded_data[0]) || (p2 != encoded_data[1]) || (p4 != encoded_data[3]);

always @(*) begin
    if (error) begin
        decoded_data[0] = ~(encoded_data[2] ^ encoded_data[4] ^ encoded_data[6]);
        decoded_data[1] = ~(encoded_data[2] ^ encoded_data[5] ^ encoded_data[6]);
        decoded_data[2] = ~(encoded_data[4] ^ encoded_data[5] ^ encoded_data[6]);
        decoded_data[3] = ~(encoded_data[6]);
    end
    else begin
        decoded_data[0] = encoded_data[2];
        decoded_data[1] = encoded_data[4];
        decoded_data[2] = encoded_data[5];
        decoded_data[3] = encoded_data[6];
    end
end

endmodule
