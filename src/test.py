import cocotb
from cocotb.triggers import Timer

test_encode = {
    0b0000: 0b0000000,
    0b0001: 0b0000111,
    0b0010: 0b0011001,
    0b0011: 0b0011110,
    0b0100: 0b0101010,
    0b0101: 0b0101101,
    0b0110: 0b0110011,
    0b0111: 0b0110100,
    0b1000: 0b1001011,
    0b1001: 0b1001100,
    0b1010: 0b1010010,
    0b1011: 0b1010101,
    0b1100: 0b1100001,
    0b1101: 0b1100110,
    0b1110: 0b1111000,
    0b1111: 0b1111111, 
}

@cocotb.test()
async def test_hamming74_encode(dut):
    # dut._log.info("start")
    for word, codeword in test_encode.items():
        dut.io_in.value = word
        await Timer(1, units="step")
        dut._log.info("in: %s, out: %s", "{0:08b}".format(word), dut.io_out.value)
        assert int(dut.io_out.value) == int(codeword)


@cocotb.test()
async def test_hamming74_decode(dut):
    for word, codeword in test_encode.items():
        dut.io_in.value = 0b10000000 | codeword
        await Timer(1, units="step")
        dut._log.info("in: %s, out: %s, expect: %s", dut.io_in.value, dut.io_out.value, "{0:08b}".format(word))
        assert dut.io_out.value.binstr ==  "{0:08b}".format(word)
        await Timer(1, units="step")


@cocotb.test()
async def test_hamming74_manual(dut):
    dut.io_in.value = 0b10000000 | 0b01110000
    await Timer(1, units="step")
    dut._log.info("in: %s, out: %s", dut.io_in.value, dut.io_out.value)