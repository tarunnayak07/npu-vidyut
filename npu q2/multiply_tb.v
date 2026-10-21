`timescale 1ns / 1ps
module multiply_tb;
reg [3:0]q,m;
wire [3:0]A;
reg clk,reset;
wire [7:0]out;
wire flag;
multiply uut(.A(A),.q(q),.m(m),.reset(reset),.clk(clk),.out(out),.flag(flag));
 always #5 clk=~clk;
initial begin
    $dumpfile("ans.vcd"); 
    $dumpvars(0, multiply_tb);
    clk=0;
    reset=1;
    m=13;
    q=11;
    #1 ;reset=0; //
    #1;reset=1;
    #60 ;reset=0;m=6;q=9; // new set
    #1; reset=1;
    #50;$finish;
end
endmodule

