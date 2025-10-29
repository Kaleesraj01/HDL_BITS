module mux_256_1 (input [255:0] in , input [7:0] sel ,
                   output outp);
assign outp = in[sel];
endmodule 
