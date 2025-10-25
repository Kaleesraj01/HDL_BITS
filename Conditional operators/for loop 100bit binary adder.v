module FA (input a,b ,cin , output sum , cout );
    
assign {cout,sum} = a+b+cin;
endmodule

    module top_module (input[99:0]a,input[99:0] b ,input cin , output[99:0]sum,output [99:0]cout);
        wire [100:0] carry;
assign carry[0]=cin;
 genvar i ;
generate
    for (i=0 ; i<100 ; i=i+1) begin : FA_loop
FA dut (.a(a[i]),.b(b[i]),.cin(carry[i]),.sum(sum[i]), .cout(carry[i+1]));
        assign cout[i]= carry [i+1]; 
    end 
endgenerate

endmodule
