
//********************************************************************//
// APB SLAVE RTL                                                      //
// AUTHOR : NANDAKUMARI N                                             //
//********************************************************************//

typedef enum bit[1:0] { SETUP,W_ENABLE,R_ENABLE} apb_slave_state_t; 

module apb_slave(apb_intf apbif,
                 output logic [`ADDR_WIDTH - 1 : 0] start_addr,               
                 output logic [`ADDR_WIDTH - 1 : 0] end_addr,
                 output logic [1:0] ctrl_reg, //ctrl_reg[0] = enable //ctrl_reg[1] = xor);
                 output config_b);
  
  // if all registers are written atleast ones this flag is set to one
  reg [2:0] status;
  // once all the registers are configured it is set to 1
  wire config_st; 
  
  apb_slave_state_t apb_st;
 
 
  assign config_b = (status == 3'b111) ? 1 : 0;
  assign apbif.pready = 1;
  
  //to configure 4 registers via apb_bus
  always@(posedge apbif.pclock or negedge apbif.presetn) begin
   
    if(!apbif.presetn) begin
      apb_st <= apb_slave_state_t'(0);
      apbif.pslverr <= 0;
      apbif.prdata <= 0;
      status <= 3'b0;
    end
    else begin
      case (apb_st)
      SETUP : begin
        // clear the prdata
        apbif.prdata <= 0;

        // Move to ENABLE when the psel is asserted
        if (apbif.psel && !apbif.penable) begin
          if (apbif.pwrite) begin
            apb_st <= W_ENABLE;
          end
         
        end
      end

      W_ENABLE : begin
        // write pwdata to memory
        if (apbif.psel && apbif.penable && apbif.pwrite) begin
          apbif.pslverr <= 0;
          case(apbif.paddr) 
            32'h0 :begin 
              
              start_addr <= apbif.pwdata;
              status[0] <= 1;    
              
            end
            32'h4 : begin 
              end_addr   <= apbif.pwdata;
              status[1] <= 1;
            end
            32'h8 : begin
              ctrl_reg   <= apbif.pwdata[1:0];
              status[2] <= 1;
            end
            default : apbif.pslverr <= 1;
            endcase  
        end

        // return to SETUP
        apb_st <= SETUP;
      end

     endcase
    end
  end
      
      
  always@(*) begin
    if(apbif.psel && apbif.penable && !apbif.pwrite) begin
       apbif.pslverr <= 0;
       case(apbif.paddr) 
         32'h0 : apbif.prdata        <= start_addr;
         32'h4 : apbif.prdata        <= end_addr;
         32'h8 : apbif.prdata [1:0] <= ctrl_reg;
         default : apbif.pslverr <= 1;
       endcase  
    end
  end
         
  
endmodule