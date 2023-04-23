import cocotb
from cocotb.triggers import Timer

# Flags as used by src/{encoder,decoder,main}.v
FLAG_ENCODE = 0b00000000
FLAG_DECODE = 0b10000000
FLAG_ERROR = 0b00010000
MASK_RESULT = 0b00001111

# Exhaustive list of words and their expected codewords
WORD_CODEWORD_MAPPING = {
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
    for word, codeword in WORD_CODEWORD_MAPPING.items():
        dut.io_in.value = FLAG_ENCODE | word
        await Timer(10, units="step")
        dut._log.info(
            f"in: {dut.io_in.value}, out: {dut.io_out.value}, expect: {codeword:08b}"
        )
        assert dut.io_out.value.binstr == f"{codeword:08b}"


@cocotb.test()
async def test_hamming74_decode(dut):
    for word, codeword in WORD_CODEWORD_MAPPING.items():
        # for decode, verify all 1 bit mutations of codeword map to word (with error bit set if necessary)
        for mutation in [0] + [1 << x for x in range(0, 7)]:
            expect = word | FLAG_ERROR if mutation else word
            dut.io_in.value = FLAG_DECODE | (codeword ^ mutation)
            await Timer(10, units="step")
            dut._log.info(
                f"in: {dut.io_in.value}, out: {dut.io_out.value}, expect: {expect:08b}"
            )
            assert dut.io_out.value.binstr == f"{expect:08b}"
