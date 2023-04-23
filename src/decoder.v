module hamming_decoder(
  input [6:0] encoded_data,
  output reg [3:0] decoded_data,
  output error
);

reg [2:0] syndrome;

assign error = (syndrome != 0);



always @* begin
  syndrome[2] = encoded_data[0] ^ encoded_data[2] ^ encoded_data[4] ^ encoded_data[6];
  syndrome[1] = encoded_data[1] ^ encoded_data[2] ^ encoded_data[5] ^ encoded_data[6];
  syndrome[0] = encoded_data[3] ^ encoded_data[4] ^ encoded_data[5] ^ encoded_data[6];
end

always @(syndrome) begin
  case (syndrome)
    3'b000: begin decoded_data[0] = encoded_data[2]; decoded_data[1] = encoded_data[4]; decoded_data[2] = encoded_data[5]; decoded_data[3] = encoded_data[6]; end
    3'b001: begin decoded_data[0] = encoded_data[2]; decoded_data[1] = encoded_data[5]; decoded_data[2] = encoded_data[4]; decoded_data[3] = encoded_data[6]; end
    3'b010: begin decoded_data[0] = encoded_data[2]; decoded_data[1] = encoded_data[5]; decoded_data[2] = encoded_data[6]; decoded_data[3] = encoded_data[4]; end
    3'b011: begin decoded_data[0] = encoded_data[4]; decoded_data[1] = encoded_data[5]; decoded_data[2] = encoded_data[6]; decoded_data[3] = encoded_data[1]; end
    3'b100: begin decoded_data[0] = encoded_data[4]; decoded_data[1] = encoded_data[5]; decoded_data[2] = encoded_data[1]; decoded_data[3] = encoded_data[6]; end
    3'b101: begin decoded_data[0] = encoded_data[4]; decoded_data[1] = encoded_data[1]; decoded_data[2] = encoded_data[5]; decoded_data[3] = encoded_data[6]; end
    3'b110: begin decoded_data[0] = encoded_data[5]; decoded_data[1] = encoded_data[4]; decoded_data[2] = encoded_data[6]; decoded_data[3] = encoded_data[2]; end
    3'b111: begin decoded_data[0] = encoded_data[5]; decoded_data[1] = encoded_data[6]; decoded_data[2] = encoded_data[4]; decoded_data[3] = encoded_data[2]; end
  endcase
end

endmodule