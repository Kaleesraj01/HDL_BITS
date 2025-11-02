module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state, next_state;
    parameter A=0 ,B= 1 ;
    
    always @(posedge clk) begin
        if (reset) 
            present_state <= B ;
            else 
                present_state <= next_state ; 
    end 
        
        always @(*) begin 
            case (present_state)
                A:next_state = in ? A:B;
                B:next_state = in ? B:A;
            endcase 
        end 
        
    always @ (*)begin 
            case(present_state)
                A : out = 0 ;
                B : out = 1 ; 
            endcase 
        end  
            
        endmodule  
