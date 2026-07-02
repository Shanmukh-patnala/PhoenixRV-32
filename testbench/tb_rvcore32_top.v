`timescale 1ns/1ps

module tb_rvcore32_top;

reg clk;
reg rst;

rvcore32_top DUT(

.clk(clk),
.rst(rst)

);

// Clock Generation
always #5 clk = ~clk;

//------------------------------------------------------------
// Simulation Control
//------------------------------------------------------------

initial begin

    // Generate waveform
    $dumpfile("rvcore32.vcd");
    $dumpvars(0, tb_rvcore32_top);

    // Initialize signals
    clk = 0;
    rst = 1;

    // Release reset
    #10;
    rst = 0;

    // Run simulation
    #80;

    $finish;

end

//------------------------------------------------------------
// Monitor
//------------------------------------------------------------

initial begin

$display("==============================================================================================================================");
$display("Time\tPC\t\tInstruction\tRD\tRD1\tRD2\tALURes\tMemData\tWBData\tRegWrite");
$display("==============================================================================================================================");

$monitor("%0t\t%h\t%h\tx%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%b",

    $time,
    DUT.pc,
    DUT.instruction,

    DUT.rd,

    DUT.read_data1,
    DUT.read_data2,

    DUT.ALU_Result,

    DUT.MemoryData,

    DUT.WriteBackData,

    DUT.RegWrite

);

end

endmodule