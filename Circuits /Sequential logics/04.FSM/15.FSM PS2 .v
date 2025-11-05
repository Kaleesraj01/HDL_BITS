module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
parameter byte1=0,byte2=1,byte3=2,Done=3;
    reg [1:0] state , next_state ;
    reg [23:0] data;
    
    // State transition logic (combinational)
    always @(*) begin
        case (state )
            byte1: next_state = in[3]?byte2 : byte1;
            byte2: next_state = byte3;
            byte3 : next_state = Done;
            Done : next_state = in[3]? byte2 : byte1;
            default : next_state = byte1;
        endcase 
    end 
    
    always @(posedge clk ) begin
        if(reset)
            state <= byte1;
    else 
        state <= next_state;
            
    end 
    
    // New: Datapath to store incoming bytes.
    always@(posedge clk )begin
        if (reset) 
            data <= 24'b0 ;
        else 
            data <= {out_bytes[15:8], out_bytes[7:0], in };
    end 
    
    assign done = (state == Done) ;
        
     assign out_bytes = Done ? data : 24'b0;
         
    
    

endmodule
