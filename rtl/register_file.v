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

// Initialize Registers

integer i;

initial begin
    for(i = 0; i < 32; i = i + 1)
        registers[i] = 32'd0;

    // Sample values for testing
    registers[0] = 32'd0;
    registers[1] = 32'd10;
    registers[2] = 32'd20;
end

// Read Ports

assign read_data1 = (rs1 == 0) ? 32'd0 : registers[rs1];
assign read_data2 = (rs2 == 0) ? 32'd0 : registers[rs2];

// Write Port

always @(posedge clk)
begin
    if(write_enable && rd != 0)
        registers[rd] <= write_data;
end

endmodule