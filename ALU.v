module ALU (result, zero_flag, source_A, source_B, ALU_ctrl_signal);

output [31: 0] result;
output zero_flag;
input [31: 0] source_A, source_B;
input [3: 0] ALU_ctrl_signal; // the size maybe modified later


/*************** Control signals ******************************/ 

// will be modified later:

parameter add = 2;
parameter sub = 6;
parameter and_op = 0;
parameter or_op = 1;
parameter compare = 7;
parameter xor_op = 4;
parameter nand_op = 5;
parameter xnor_op = 8;


assign zero_flag = (result == 0);

assign result = (ALU_ctrl_signal == 0)? (source_A & source_B) : 32'dz; // and
assign result = (ALU_ctrl_signal == 1)? (source_A | source_B) : 32'dz; // or
assign result = (ALU_ctrl_signal == 2)? (source_A + source_B) : 32'dz; // add 
assign result = (ALU_ctrl_signal == 4)? (source_A ^ source_B) : 32'dz; // xor
assign result = (ALU_ctrl_signal == 5)? (~(source_A & source_B)) : 32'dz; // nand
assign result = (ALU_ctrl_signal == 6)? (source_A - source_B) : 32'dz; // substract 
assign result = (ALU_ctrl_signal == 7)? ((source_A > source_B)? 32'd1 : 32'd0) : 32'dz; // compare
assign result = (ALU_ctrl_signal == 8)? (~(source_A ^ source_B)) : 32'dz; // xnor








//always block design may be needed later

/*
always @ (source_A, source_B, ALU_ctrl_signal) 
begin 
        case (ALU_ctrl_signal)


end

*/






endmodule