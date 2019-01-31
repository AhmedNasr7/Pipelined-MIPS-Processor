module mux(in_1,in_2,in_3,out);
input[31:0] in_1,in_2;
input in_3;
output [31:0]out;
assign out=(in_3)?in_2:in_1;
endmodule

module alu(in_1,in_2,out);
input [31:0]in_1;
input [3:0]in_2;
output [31:1]out;
assign out=in_1+in_2;
endmodule

module pc(in_1,out);
input [31:0]in_1;
output [31:0]out;
assign out=in_1;
endmodule

module memory(in_1,out);
input [31:0]in_1;
output [31:0]out;
assign out=in_1;
endmodule

module instruction_memory(in_1,in_2,in_3,clk,sel,out_inst,out_alu);
output reg [31:0]in_1;
input [31:0]in_2;
input sel,clk;
input [3:0]in_3;
output [31:0]out_inst,out_alu;
wire [31:0]out_1,out_2;
mux m1(in_1,in_2,sel,out_1);
pc p1(out_1,out_2);
always @(posedge clk)
begin
in_1<=out_2+in_3;
end
//alu a1(out_2,in_3,in_1);
memory r1(out_2,out_inst);
assign out_alu=in_1;
endmodule

module tb_inst_mem();
wire [31:0]in_1;
reg [31:0]in_2;
reg sel,clk;
reg [3:0]in_3;
wire [31:0]out_inst,out_alu;
reg [31:0]out_1,out_2;
initial begin
clk=0;
//in_1=32'b010101011;
in_2=32'b00110;
sel=1;
in_3=4'b0100;
#10
sel=0;
end
always begin #5 clk=~clk; end
instruction_memory ins1(in_1,in_2,in_3,clk,sel,out_inst,out_alu);
endmodule

/*module tb_mux();
reg [31:0]in_1,in_2;
reg in_3;
wire [31:0]out;
initial
begin
$monitor("%b %b %b &b",in_1,in_2,in_3,out);
in_1=1;
in_2=0;
in_3=1;
#5
in_3=0;
end
mux m1(in_1,in_2,in_3,out);
endmodule
module tb_mux();
reg [31:0]in_1,in_2;
reg in_3;
wire [31:0]out;
initial
begin
$monitor("%b %b %b &b",in_1,in_2,in_3,out);
in_1=1;
in_2=0;
in_3=1;
#5
in_3=0;
end
mux m1(in_1,in_2,in_3,out);
endmodule

module tb_alu();
reg [31:0] in_1;
wire [31:0]out;
reg [3:0]in_2;
reg [3:0]sum;
assign out=in_1+in_2;
initial begin
//$monitor("%b %b",in_1,out);
in_1=10;
in_2=4'b0100;
#5
in_1=20;
end
alu a1(in_1,in_2,out);
endmodule
*/