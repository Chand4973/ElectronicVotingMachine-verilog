`include "EVM.v"

module tb;
reg clk, mode;
reg button1, button2, button3, button4;
wire [1:4]led;
wire [1:4][31:0]votes;

voting_machine M1(clk, mode, button1, button2, button3, button4, led, votes);

initial begin
  clk = 1'b0;
  forever #5 clk = ~clk;
end

initial begin
$dumpfile("tb.vcd");
$dumpvars(0,tb);
$monitor($time, " mode=%b, button[1]=%b, button[2]=%b, button[3]=%b, button[4]=%b, votes[1]=%d, votes[2]=%d, votes[3]=%d, votes[4]=%d", mode, button1, button2, button3, button4, votes[1], votes[2], votes[3], votes[4]);

#2 mode=2'b01;
#10 button1=1;
#40 button1=0;
#10 button1=1;
#40 button1=0;
#20 button2=1;
#40 button2=0;
#20 button2=1;
#40 button2=0;
#20 button2=1;
#40 button2=0;
#20 button2=1;
#40 button2=0;
#20 button3=1;
#40 button3=0;
#20 button3=1;
#40 button3=0;
#20 button3=1;
#40 button3=0;
#20 button3=1;
#40 button3=0;
#20 button3=1;
#40 button3=0;
#20 button3=1;
#40 button3=0;
#20 button3=1;
#40 button3=0;
#20 button4=1;
#40 button4=0;
#20 button4=1;
#40 button4=0;
#20 button4=1;
#40 button4=0;
#20 button2=1;
#40 button2=0;
#20 button1=1;
#40 button1=0;
#20 button3=1;
#40 button3=0;
#20 button2=1;
#40 button2=0;
#20 button4=1;
#40 button4=0;

#10 mode=2'b00;
#10 $finish;
end

endmodule
