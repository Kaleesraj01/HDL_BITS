module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
  parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5;
    reg[2:0]ps,ns;
    always@(posedge clk)begin
        if(reset)
            ps<=s0;
        else
            ps<=ns;
    end
    always@(*)begin
        case(ps)
            s0:ns=w?s0:s1;
            s1:ns=w?s3:s2;
            s2:ns=w?s3:s4;
            s3:ns=w?s0:s5;
            s4:ns=w?s3:s4;
            s5:ns=w?s3:s2;
        endcase
    end
    assign z=(ps==s4)||(ps==s5);
endmodule

