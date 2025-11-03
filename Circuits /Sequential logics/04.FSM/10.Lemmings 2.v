module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter wl=0 , wr = 1, fl=2 , fr=3 ;
    reg[1:0] state , next_state;
    
    
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= wl ;
    else 
        state <= next_state ;
    end 
    
    
    always @(*) begin
        case (state)
            wl: begin if (ground==0)
                next_state = fl ;
                else if (bump_left)
                    next_state = wr;
                else 
                    next_state = wl ;
                
            end 
            
            wr : begin if (ground == 0 )
                next_state = fr;
                else if (bump_right)
                    next_state = wl ;
                else 
                    next_state =  wr;
            end 
            
            fl : begin if (ground)
                next_state = wl ;
                else 
                    next_state = fl;
            end
                
            fr: begin if (ground)
                next_state = wr ;
                else 
                    next_state = fr ;
            end 
            
        endcase 

    end 
    
    assign walk_left  = state == wl ;
    assign walk_right  = state == wr ;
    
    assign aaah = (state == fr)| ( state == fl );
                                  
        

endmodule
