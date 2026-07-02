module decoder(

    input  [31:0] instruction,

    output [6:0] opcode,
    output [4:0] rd,
    output [2:0] funct3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [6:0] funct7

);

assign opcode = instruction[6:0];
assign rd      = instruction[11:7];
assign funct3  = instruction[14:12];
assign rs1     = instruction[19:15];
assign rs2     = instruction[24:20];
assign funct7  = instruction[31:25];

endmodule

//------------------------------------------------------------
// register file
//------------------------------------------------------------

module register_file(

    input clk,
    input write_enable,

    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,

    input [31:0] write_data,

    output [31:0] read_data1,
    output [31:0] read_data2

);

reg [31:0] registers [0:31];
