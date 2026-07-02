module data_memory(

input clk,
input MemRead,
input MemWrite,
input [31:0] Address,
input [31:0] WriteData,
output [31:0] ReadData
);

// 256 × 32-bit Memory
reg [31:0] memory [0:255];


// Initialize Memory
integer i;

initial begin

    for(i = 0; i < 256; i = i + 1)

        memory[i] = 32'd0;



    // Sample data

    memory[27] = 32'd75;   // Address = 108

end

// Write Operation

always @(posedge clk)

begin

    if(MemWrite)

        memory[Address[9:2]] <= WriteData;

end

// Read Operation

assign ReadData = (MemRead) ?

                  memory[Address[9:2]]

                  : 32'd0;

endmodule

