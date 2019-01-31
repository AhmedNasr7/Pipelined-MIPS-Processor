module control_unit( op_code,control_signal);
input [5:0] op_code; //instruction 
output [11:0] control_signal;// reguired control signal for each operation
reg  [1:0]regdst; 
reg jump;
reg branch;
reg memread;
reg [1:0]memtoreg;
reg [1:0]aluop;
reg memwrite;
reg alusrc;
reg regwrite;
assign control_signal={regdst,jump,branch,memread,memtoreg,aluop,memwrite,alusrc,regwrite};
/**************always block********************/
always @(*)
begin
/***********R functions*******************/
 if(op_code==6'b000000)
    begin
	regdst=2'b01;
   jump=0;
	branch=0;
	memread=0;
	memtoreg=2'b00;
	aluop=2'b10;
	memwrite=0;
	alusrc=0;
	regwrite=1;
    end
/**********************SW function************/
 if(op_code==6'b101011)
    begin
	 regdst=2'b00;
   jump=0;
	branch=0;
	memread=0;
	memtoreg=2'b00;
	aluop=2'b00;
	memwrite=1;
	alusrc=1;
	regwrite=0;
	 end
 /*************lw function*****************/
 if(op_code==6'b100011)
    begin
	regdst=2'b00;
   jump=0;
	branch=0;
	memread=1;
	memtoreg=2'b01;
	aluop=2'b00;
	memwrite=0;
	alusrc=1;
	regwrite=1;
	 end
/***********beq function******************/
  if(op_code==6'b000100)
     begin
   regdst=2'b00;
   jump=0;
	branch=1;
	memread=0;
	memtoreg=2'b00;
	aluop=2'b01;
	memwrite=0;
	alusrc=0;
	regwrite=0;
	  end
/***************jump************/
  if(op_code==6'b000010)
     begin
	regdst=2'b00;
   jump=1;
	branch=0;
	memread=0;  
	memtoreg=2'b00;
	aluop=2'b00;
	memwrite=0;
	alusrc=0;
	regwrite=0;
	  end
/************JAL************/
 if(op_code==6'b000011)
    begin
	regdst=2'b10; // this is $31 of Sra in which the next address will be put
   jump=1;
	branch=0;
	memread=0;  
	memtoreg=2'b10;
	aluop=2'b00;
	memwrite=0;
	alusrc=0;
	regwrite=1;
	 end
/**************addi*****************/
  if(op_code==6'b01000)
  begin
  regdst=2'b00;
   jump=0;
	branch=0;
	memread=0;  
	memtoreg=2'b00;
	aluop=2'b00;
	memwrite=0;
	alusrc=1;
	regwrite=1;
  end
  /*****************ori********************/
  if(op_code==6'b001101)
  begin
  regdst=2'b00;
   jump=0;
	branch=0;
	memread=0;  
	memtoreg=2'b00;
	aluop=2'b00;
	memwrite=0;
	alusrc=1;
	regwrite=1;
  end
  
end

endmodule
