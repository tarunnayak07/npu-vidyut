`timescale 1ns / 1ps
module rra_tb;
reg [3:0]req;
reg clk,reset;
wire [3:0]grant;
rra uut(.req(req),.clk(clk),.reset(reset),.grant(grant));
always #5 clk=~clk;
initial begin
    $dumpfile("yes.vcd"); 
        $dumpvars(0, rra_tb);
    reset=1;
    clk=0;
    #6 reset=0;req=4'b1001;
    #65 req=4'b1101; // 3 grants per cycle case
    #105 req=4'b0001; // hogging case
    #155 req=4'b0011;
    #205 req<=4'b0000; // idle case
    #255 $finish;
end
endmodule

