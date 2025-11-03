module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
     
    parameter wl=0 , wr=1 , fl =2, fr=3, dr=4,dl=5 , splatter=6;
    reg[2:0] state , next_state ;
    reg[6:0] fall_count ;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= wl;
    else 
        state <= next_state ;
    end 
    
    always @(posedge clk or posedge areset ) begin 
        if (areset)
            fall_count <= 5'b0;
        else if (state==fl | state==fr )
            fall_count <= fall_count+1;
        else 
            fall_count <= 5'b0;
    end 
    
    
        

            
    
    always@(*) begin 
        case (state)
            wl : begin 
                if (ground==0) 
                    next_state = fl ;
                else if (dig)
                    next_state = dl ;
                else if (bump_left)
                    next_state = wr ;
                else 
                    next_state = wl ;
                end 
            
            wr : begin if  (ground==0) 
                next_state = fr ;
                else if (dig)
                    next_state = dr;
                else if ( bump_right)
                    next_state = wl ;
                else 
                    next_state = wr ;
            end 
            
            fl : begin if (ground) begin 
                if 
                    (fall_count > 5'd19) 
                    next_state = splatter ;
                else 
                    next_state = wl;
            end 
                else
                    next_state = fl ;
            end 
            
            fr :  begin 
                if (ground )begin 
                    
                    if (fall_count > 5'd19)
                        next_state = splatter;
                    else 
                        next_state = wr;
                end 
                    
                
                else 
                    next_state = fr ;
            end 
            
            dl : 
                begin if (~ground )  
                    next_state = fl ;
                    
                    else 
                        next_state = dl ;
                end 
            
            dr : begin if (~ground)
                next_state = fr ;
                else  
                    next_state = dr;
                    end 
            
            splatter : 
                next_state = splatter;
            
            
            
                    endcase 
    end
                    
                   assign walk_left  = state==wl ;
                   assign walk_right = state == wr ;
                   assign aaah       = state==fl | state==fr ;
                   assign digging    = state == dl | state == dr ;
    
        
                       

    
    
    
endmodule
