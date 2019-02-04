module regFile (instruction,writedata,regwrite,clk,pc,readdata1,readdata2, signextend);
reg [127:0] IDEX;
reg[31:0]RF[0:31];
reg[4:0] writereg,rs,rt,rd;
reg[5:0] op;
//////////////////
input [31:0] instruction;
input [31:0] writedata;
input regwrite,clk;
output reg[31:0] pc;
output reg[31:0]readdata1;
output reg[31:0]readdata2;
output reg[31:0]signextend;

//////////////


assign readata1=RF[rs];
////////////
initial
begin
op=instruction[31:26];
rs=instruction[25:21];
rt=instruction[20:16];
rd=instruction[15:11];
  if (op==6'b000000)
  begin
  readdata2=RF[rt];/////rt
  writereg=rd;/////rd
  end
  else 
  begin
  readdata2=32'hxxxxxxxx;
  writereg=rt;////rt
  signextend={{16{instruction[15]}},instruction[15:0]};
  end
IDEX={pc,readdata1,readdata2,signextend};

end
////////
always @(posedge clk)
begin
 if(regwrite==1'b1)
 RF[writereg]<= writedata;
end 
endmodule 
//////////////////////////////////////////////////
module tb20();
reg [31:0] instruction;
reg [31:0] writedata;
reg regwrite,clk;
wire [31:0] pc;
wire [31:0]readdata1;
wire [31:0]readdata2;
wire [31:0]signextend;
////////////
regFile myrf(instruction,writedata,regwrite,clk,pc,readdata1,readdata2,signextend);

initial
begin
$monitor("%b,%b,%b,%b,%b,%b,%b",clk,instruction,writedata,regwrite,readdata1,readdata2,signextend);
instruction=32'b1111_1111_1111_1111;
clk=0;
regwrite=0;
writedata=32'b0000_0000_0000_00000;
#3
instruction=32'b0000_1111_1111_0000;
regwrite=1;
writedata=32'h11110000;
end
//////////
always
#5 clk=~clk;
///////////
endmodule

