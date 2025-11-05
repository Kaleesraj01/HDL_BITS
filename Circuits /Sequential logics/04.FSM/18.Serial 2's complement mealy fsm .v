module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter s0=2'b01 , s1=2'b10;
    reg[1:0] state , next_state ;
    
    always @(posedge clk or posedge areset )  begin
        if (areset)
            state <= s0;
    else 
        state <= next_state ;
    end 
    
    always @(*) begin
        case(state)
            s0: next_state = x ? s1:s0;
            s1: next_state = s1 ;
        endcase
    end 
    
    assign z = (state == s0) ? x : ~x;


        
        

    
    
endmodule
S
