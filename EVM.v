module voting_machine(clk, mode, button1, button2, button3, button4, led, votes);
input clk, mode;
input button1, button2, button3, button4;
output [1:4]led;
output [1:4][31:0]votes;

button_control B1(button1, mode, clk, led[1], votes[1]);
button_control B2(button2, mode, clk, led[2], votes[2]);
button_control B3(button3, mode, clk, led[3], votes[3]);
button_control B4(button4, mode, clk, led[4], votes[4]);


integer state;//state description
/*S0:idle
S1:cast your vote
S2:reset the votes
S3:display the votes*/
parameter S0=0, S1=1, S2=2, S3=3;

always @(posedge clk)
begin
  case(state)
  S0: begin
    if(mode==00) state<=S0;
    else if(mode==01) state<=S1;
    else if(mode==10) state<=S2;
    else if(mode==11) state<=S3;
  end
  S1: #60 state<=S0;//selecting mode:01 sends you to voting where you will be having 60 units of time 
  S2: begin//state which resets the values
    for(integer i=0; i<4; i=i+1) begin
    //   votes[i]=32'b0;
    end
    state<=S0;
  end
  S3: begin state<=S0; end//lack of display setup
  default: state<=S0;
  endcase
end

endmodule


//defining module for mechanism of button such that pressed for certain time registers the vote
module button_control(button, mode, clk, led, votes);
input button, mode, clk;
output reg led;
output reg [31:0]votes;

reg [7:0]timer;
initial timer<=0;

initial votes = 0;

always @(posedge clk)
if(mode==2'b01) begin
  if(button & (timer<4)) begin timer <= timer+1; led=1'b1; end
  else if(!button) begin timer<=0; led=1'b0; end
end

always @(posedge clk)
if(mode==2'b01) begin
  if(timer==3) votes = votes + 1;
end

endmodule
