module mux(in_1,in_2,in_3,out);
input [31:0] in_1,in_2;
input in_3;
output [31:0]out;
assign out=(in_3)?in_2:in_1;
endmodule

module pc(in_1,out);
input [31:0]in_1;
output [31:0]out;
assign out=in_1;
endmodule

module Instr(instruction, address);
input [31:0] address;
output [31:0] instruction;
reg [31:0]instrmem[31:0];
reg [31:0] temp;

buf #1000
   buf0(instruction[0],temp[0]),
   buf1(instruction[1],temp[1]),
   buf2(instruction[2],temp[2]),
   buf3(instruction[3],temp[3]),
   buf4(instruction[4],temp[4]),
   buf5(instruction[5],temp[5]),
   buf6(instruction[6],temp[6]),
   buf7(instruction[7],temp[7]),
   buf8(instruction[8],temp[8]),
   buf9(instruction[9],temp[9]),
   buf10(instruction[10],temp[10]),
   buf11(instruction[11],temp[11]),
   buf12(instruction[12],temp[12]),
   buf13(instruction[13],temp[13]),
   buf14(instruction[14],temp[14]),
   buf15(instruction[15],temp[15]),
   buf16(instruction[16],temp[16]),
   buf17(instruction[17],temp[17]),
   buf18(instruction[18],temp[18]),
   buf19(instruction[19],temp[19]),
   buf20(instruction[20],temp[20]),
   buf21(instruction[21],temp[21]),
   buf22(instruction[22],temp[22]),
   buf23(instruction[23],temp[23]),
   buf24(instruction[24],temp[24]),
   buf25(instruction[25],temp[25]),
   buf26(instruction[26],temp[26]),
   buf27(instruction[27],temp[27]),
   buf28(instruction[28],temp[28]),
   buf29(instruction[29],temp[29]),
   buf30(instruction[30],temp[30]),
   buf31(instruction[31],temp[31]);

always @(address)
begin
 temp=instrmem[address/4];
end
initial
begin
$readmemb("D:\modelsim/instr.txt", instrmem);
end
endmodule

module instruction_memory(in1_mux,in2_mux,in_3,clk,sel,out_inst,out_alu);
input [31:0]in1_mux;
input [31:0]in2_mux;
input sel,clk;
input [3:0]in_3;
output reg[31:0]out_inst;
output reg[31:0] out_alu;
wire [31:0]out_mux;
wire [31:0]out_2;
reg [31:0] sel2;
mux m1(in1_mux,in2_mux,sel,out_mux);
pc p1(out_mux,out_2);
Instr in1(out_2, out_inst);
always @(posedge clk)
begin
out_alu<=out_2+in_3;
out_alu <= in1_mux ;
end
//alu a1(out_2,in_3,clk,out_alu);
//assign out_alu = in1_mux || 1;
//memory r1(out_2,out_inst);

endmodule

module tb_inst_mem();
reg [31:0]in_1;
reg [31:0]in_2;
reg sel,clk;
reg [3:0]in_3;
wire [31:0]out_inst,out_alu;
wire [31:0]out_mux;
reg [31:0] out_2;
assign out_mux=(sel)?in_2:in_1;
initial begin
clk=0;
in_1=32'b010101011;
in_2=32'b00110;
//sel=1;
in_3=4'b0100;
#10
sel=0;

#10 sel=1;
out_2=32'd0;
#10 out_2=32'd4;
#10 out_2=32'd8;
#10 out_2=32'd12;
end
always begin #5 clk=~clk; end
instruction_memory ins1(in_1,in_2,in_3,clk,sel,out_inst,out_alu);
endmodule

