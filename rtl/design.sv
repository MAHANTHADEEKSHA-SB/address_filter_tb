// Code your design here
//APB for configuring registers ,AHB for ssending data out
`include "defines.sv"
`include "apb_intf.sv"
//`include "ahb_if.sv"
`include "mem_intf.sv"
`include "apb_slave.sv"
`include "ahb_slave.sv"

//********************************************************************//
// TOP MEMORY CONTROLLER                                              //
// AUTHOR : NANDAKUMARI N                                             //
//********************************************************************//
module memory_controller(apb_intf apbif,ahb_interface ahbif, mem_intf memif);
  
  
  logic [`ADDR_WIDTH - 1 : 0 ] start_addr;
  logic [`ADDR_WIDTH - 1 : 0 ] end_addr;
  logic [1:0] ctrl_reg;
  logic config_st;
  
  apb_slave SLV0 (.apbif(apbif),
                  .start_addr(start_addr),
                  .end_addr(end_addr),
                  .ctrl_reg(ctrl_reg),
                  .config_b(config_st));
  
  
  ahb_slave slv1 (.ahbif(ahbif),
                  .mif(memif));
  
  //only unfiltered master transactions triggers the slave
  always@(*) begin
    
    casex(ctrl_reg)
      2'bx0 : ahbif.hsel = 1;
      2'b01 : begin
        if((ahbif.haddr inside {[start_addr : end_addr]}))
          ahbif.hsel = 0;
        else 
          ahbif.hsel = 1;
      end
      2'b11 : begin
        if(ahbif.haddr inside {[start_addr : end_addr]})
          ahbif.hsel = 1;
        else 
          ahbif.hsel = 0;
        end
      default : ahbif.hsel = 0;
    endcase
  end
  
  
endmodule
      


