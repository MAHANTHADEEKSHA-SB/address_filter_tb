`include "defines.sv"

//********************************************************************//
// AHB SLAVE RTL                                                      //
// AUTHOR : NANDAKUMARI N                                             //
//********************************************************************//
/*class mem_pkt;
  
  bit [`ADDR_WIDTH - 1 : 0] addr;
  bit [`DATA_WIDTH - 1 : 0] wr_data;
  bit [`DATA_WIDTH - 1 : 0] rd_data;
  bit rd_en,wr_en;
endclass*/

module ahb_slave (ahb_interface ahbif,mem_intf mif);
  
  //to support pipelining
  logic [`ADDR_WIDTH - 1 : 0] haddr1;
  logic [2:0] hsize1;
  logic [1:0] htrans1;
  logic hwrite1,rd_valid;
  logic [31:0] hrdata;
  
  
  always@(posedge ahbif.hclk or negedge ahbif.hresetn) begin
    if(!ahbif.hresetn) begin
      haddr1 <= 'b0;
      hsize1 <= 'b0;
      mif.rd_en <= 0;
      mif.wr_en <= 0;
      htrans1 <= 'b0;
      ahbif.hresp <= 'b0;
      ahbif.hrdata <= 'b0;
      ahbif.hready <= 'b1;
      hwrite1 <= 0;
      rd_valid <= 0;
      
    end
    else begin 
      if(ahbif.hsel) begin
        
        htrans1 <= ahbif.htrans; 
        haddr1 <= ahbif.haddr;
        hsize1 <= ahbif.hsize;
        hwrite1 <= ahbif.hwrite;            
        if(htrans1 == 2'b00 || htrans1 == 2'b01) begin
          ahbif.hresp <= 1'b0; //okay
          ahbif.hready <= 1'b1;
        end    
        else if(htrans1 == 2'b10 || htrans1 == 2'b11) begin //if htrans is nonseq or seq     
          ahbif.hresp <= 1'b0; //okay
          ahbif.hready <= 1'b1;   
          if(hwrite1) begin
            mif.wr_en <= 1;
            mif.addr <= haddr1;
            mif.wr_data <= ahbif.hwdata;
           end
           else begin
             mif.rd_en <= 1;
             mif.addr <= haddr1;   
           end
          end
      end
      else begin
         mif.rd_en <= 1'b0;
         mif.wr_en <= 1'b0;
      end
    end //else
  end //always

 
endmodule

