module simd(A,B,size,op,reset,out);
input [127:0]A,B;
input reset,op;
input [1:0]size; // size 0->8 bit 1->16 2->32
output reg [127:0]out;
integer i; // for FOR loop
function [7: 0] eight;  //func for 8bit
    input [7 : 0] in1,in2;
    input op;
    begin
        if(~op) begin
        if(in1 >8'hFF-in2 ) eight=8'hFF;
        else eight=in1+in2;
        end
        else begin
             if(in1 < in2 ) eight=0;
        else eight=in1-in2;
        end
    end
endfunction
function [15: 0] sixteen;  // func for 16 bit
    input [15 : 0] in1,in2;
    input op;
    begin
        if(~op) begin
        if(in1 >16'hFFFF-in2 ) sixteen=16'hFFFF;
        else sixteen=in1+in2;
        end
        else begin
             if(in1 < in2 ) sixteen=0;
        else sixteen=in1-in2;
        end
    end
endfunction
function [31: 0] thirtyone;   //func for 32 bit
    input [31 : 0] in1,in2;
    input op;
    begin
        if(~op) begin
        if(in1 >32'hFFFFFFFF-in2 ) thirtyone=32'hFFFFFFFF;
        else thirtyone=in1+in2;
        end
        else begin
             if(in1 < in2 ) thirtyone=0;
        else thirtyone=in1-in2;
        end
    end
endfunction
always@(*) begin    // loops and reset case
    if(reset) out=0;
    else begin
    case(size)
    1:begin for(i=0;i<16;i=i+1)begin
        out[(8*(i+1))-1 -:8]= eight(A[(8*(i+1))-1 -:8],B[(8*(i+1))-1 -:8],op); end end
    2:begin for(i=0;i<8;i=i+1)begin
        out[(16*(i+1))-1 -:16]= sixteen(A[(16*(i+1))-1 -:16],B[(16*(i+1))-1 -:16],op);end end
    3:begin for(i=0;i<4;i=i+1)begin
        out[(32*(i+1))-1 -:32]= thirtyone(A[(32*(i+1))-1 -:32],B[(32*(i+1))-1 -:32],op);end end
    default:out=0;
    endcase
end
end
endmodule