module alu_control(

input [1:0] ALUOp,
input [2:0] funct3,
input [6:0] funct7,

output reg [3:0] ALU_Control

);

always @(*) begin

    case(ALUOp)

        // LW / SW
        2'b00:
            ALU_Control = 4'b0010;

        // BEQ
        2'b01:
            ALU_Control = 4'b0110;

        // R-Type
        2'b10:
        begin

            case({funct7,funct3})

                {7'b0000000,3'b000}: ALU_Control = 4'b0010; // ADD

                {7'b0100000,3'b000}: ALU_Control = 4'b0110; // SUB

                {7'b0000000,3'b111}: ALU_Control = 4'b0000; // AND

                {7'b0000000,3'b110}: ALU_Control = 4'b0001; // OR

                {7'b0000000,3'b100}: ALU_Control = 4'b1100; // XOR

                {7'b0000000,3'b010}: ALU_Control = 4'b0111; // SLT

                default:
                    ALU_Control = 4'b0000;

            endcase

        end

        default:
            ALU_Control = 4'b0000;

    endcase

end

endmodule
