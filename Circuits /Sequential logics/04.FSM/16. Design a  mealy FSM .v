module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    parameter a=2'b00 ,b=2'b01,c=2'b10;
    reg [1:0] state , next_state;
    
    always @(posedge clk or negedge aresetn) begin
        if ( ~aresetn)
            state <= a;
    else state <= next_state;
    
    end 
    
    always @(*) begin 
        z=1'b0;
        case (state )
            
            a:next_state = x?b:a;
            b:next_state = x?b:c;
            c:begin 
                if (x) begin
                z= 1'b1;
                next_state=b;
            end
                else begin 
                    z=1'b0; 
                next_state = a;end
            end 
            default :next_state = a;
            
        endcase
    end 
   
endmodule
