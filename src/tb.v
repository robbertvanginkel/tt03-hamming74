`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

module tb (
    // testbench is controlled by test.py
    input [7:0] io_in,
    output [7:0] io_out
   );
   
    // instantiate the DUT
    robbertvanginkel_hamming74 robbertvanginkel_hamming74(
        `ifdef GL_TEST
            .vccd1( 1'b1),
            .vssd1( 1'b0),
        `endif
        .io_in  (io_in),
        .io_out (io_out)
        );

endmodule
