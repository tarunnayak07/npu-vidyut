module rra(grant,req,clk,reset);// based on fsm struture
input [3:0]req;
input clk,reset;
output reg [3:0]grant;
reg [3:0]nstate,state;
always@(posedge clk) begin
    if(reset) begin //reset all 0s
        grant<=0;
        state<=0;
    end
    else state<=nstate; //state change if combinationally prepared
end
always@(*) begin // output of each state moore model .case x coresponds to req[x-1]
    case(state)
    0:grant=0; // no grant
    1:grant=1;
    2:grant=2;
    3:grant=4;
    4:grant=8;
    endcase
end
always@(*)begin //next state combinatinal logic explained in pdf
    if(req!=0)begin
    case(state)
    0:begin if(req[3]) nstate=4 ;else if(req[2]) nstate=3; else if(req[1]) nstate=2; else if(req[0]) nstate=1; end
    1:begin if(req[3]) nstate=4 ;else if(req[2]) nstate=3; else if(req[1]) nstate=2; else if(req[0]) nstate=1; end
    2:begin if(req[0]) nstate=1 ;else if(req[3]) nstate=4; else if(req[2]) nstate=3; else if(req[1]) nstate=2; end
    3:begin if(req[1]) nstate=2 ;else if(req[0]) nstate=1; else if(req[3]) nstate=4; else if(req[2]) nstate=3; end
    4:begin if(req[2]) nstate=3 ;else if(req[1]) nstate=2; else if(req[0]) nstate=1; else if(req[3]) nstate=4; end
    default: nstate=0; 
    endcase
    end
    else nstate=0;
end
endmodule
