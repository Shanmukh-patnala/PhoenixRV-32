module alu(

input [31:0] A,
input [31:0] B,
input [3:0] ALU_Control,

output reg [31:0] Result,
output Zero

);

always @(*)
begin

case(ALU_Control)

4'b0000:
Result = A & B;

4'b0001:
Result = A | B;

4'b0010:
Result = A + B;

4'b0110:
Result = A - B;

4'b0111:
Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;

4'b1100:
Result = A ^ B;

default:
Result = 32'd0;

endcase

end

assign Zero = (Result==0);

endmodule


