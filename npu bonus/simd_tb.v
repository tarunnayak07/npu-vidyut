module simd_tb;
reg [127:0]A,B;
reg reset,op;
reg [1:0]size;
wire  [127:0]out;
simd uut(.A(A),.B(B),.out(out),.reset(reset),.op(op),.size(size));
initial begin
     $dumpfile("bonus.vcd"); 
        $dumpvars(0, simd_tb);
    reset=1;
  
    A=128'hFFFDEFFF_F356FFFF_FFABFFFF_FFFF345F;
    B=128'h0659800F_000675FF_0000FFFF_12345678;
      #1 ;reset=0;
    op=1;   
    size=2'd1;  
    #10; size = 2'd2;  
    #10; size = 2'd3;
    #10 op=0;   
        size=2'd1;  
    #10; size = 2'd2;  
    #10; size = 2'd3;
   
    #10$finish;
end endmodule
