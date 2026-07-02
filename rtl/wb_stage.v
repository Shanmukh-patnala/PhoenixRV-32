module wb_stage(

input [31:0] ALU_Result,
input [31:0] MemoryData,

input MemToReg,

output [31:0] WriteBackData

);

assign WriteBackData =
       (MemToReg) ? MemoryData : ALU_Result;

endmodule

