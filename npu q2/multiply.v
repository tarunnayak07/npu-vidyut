module multiply(A,q,m,reset,clk,out,flag);
input [3:0]q,m;
output reg [3:0]A;
reg [3:0]Q,M;
input clk,reset;
reg c;
reg [2:0]state;
output reg [7:0]out;
output reg flag;
always@(posedge clk or negedge reset) begin //adding n shifting change happens after posedge of clock
    if(~reset)   begin //loading + initial clear stage
        Q<=q;
        M<=m;
        A=0;
        c=0;
        state=0;
        flag=0;
    end
    else if(state<4) begin // state variable to keep track how many times the process of adding and shifting has taken place 
    {c,A}= Q[0] ?A+M:A+0; // mux + the adding part
    {c,A,Q}={c,A,Q}>>1; // shifting
    state=state+1;
    end
    end
always@(state) begin
    out={A,Q};
if (state==4) flag=1; //extra sign that the multiplication is over
end

endmodule
              