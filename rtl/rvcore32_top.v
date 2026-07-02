module rvcore32_top(
input clk,
input rst
);

//------------------------------------
// Internal Wires
//------------------------------------

wire [31:0] pc;
wire [31:0] instruction;
// Decoder Outputs
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;

// Register File
wire [31:0] read_data1;
wire [31:0] read_data2;

// Immediate
wire [31:0] immediate;

// Control Signals
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire ALUSrc;
wire MemToReg;
wire [1:0] ALUOp;
  
//------------------------------------------------------------
// EX Stage Wires
//------------------------------------------------------------

wire [3:0] ALU_Control;
wire [31:0] ALU_Result;
wire Zero;
wire [31:0] OperandB;

// MEM Stage
wire [31:0] MemoryData; 
wire [31:0] WriteBackData;  
  
//------------------------------------
// Program Counter
//------------------------------------

program_counter PC(

.clk(clk),
.rst(rst),
.pc(pc)

);

//------------------------------------
// Instruction Memory
//------------------------------------

instruction_memory IM(

.address(pc),
.instruction(instruction)

);

//------------------------------------------------------------
// Decoder
//------------------------------------------------------------

decoder DEC(

.instruction(instruction),

.opcode(opcode),
.rd(rd),
.funct3(funct3),
.rs1(rs1),
.rs2(rs2),
.funct7(funct7)

);
//------------------------------------------------------------
// Register File
//------------------------------------------------------------

register_file RF(

.clk(clk),

.write_enable(RegWrite),

.rs1(rs1),
.rs2(rs2),
.rd(rd),

.write_data(WriteBackData),

.read_data1(read_data1),
.read_data2(read_data2)

);
 
//------------------------------------------------------------
// Control Unit
//------------------------------------------------------------

control_unit CU(

.opcode(opcode),

.RegWrite(RegWrite),
.MemRead(MemRead),
.MemWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.MemToReg(MemToReg),
.ALUOp(ALUOp)

);
//------------------------------------------------------------
// Immediate Generator
//------------------------------------------------------------

immediate_generator IG(

.instruction(instruction),

.immediate(immediate)

);  
  
//------------------------------------------------------------
// ALU Operand MUX
//------------------------------------------------------------

assign OperandB = (ALUSrc) ? immediate : read_data2;
  
//------------------------------------------------------------
// ALU Control
//------------------------------------------------------------

alu_control AC(

.ALUOp(ALUOp),
.funct3(funct3),
.funct7(funct7),

.ALU_Control(ALU_Control)

);

//------------------------------------------------------------
// ALU
//------------------------------------------------------------

alu ALU(

.A(read_data1),
.B(OperandB),

.ALU_Control(ALU_Control),

.Result(ALU_Result),
.Zero(Zero)

);
//------------------------------------------------------------
// Data Memory
//------------------------------------------------------------

data_memory DM(

.clk(clk),

.MemRead(MemRead),
.MemWrite(MemWrite),

.Address(ALU_Result),

.WriteData(read_data2),

.ReadData(MemoryData)

);
//------------------------------------------------------------
// Write Back
//------------------------------------------------------------

wb_stage WB(

.ALU_Result(ALU_Result),

.MemoryData(MemoryData),

.MemToReg(MemToReg),

.WriteBackData(WriteBackData)

);  
  
endmodule
