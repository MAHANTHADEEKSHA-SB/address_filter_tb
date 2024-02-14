class reg2bus_adapter extends uvm_reg_adapter;
  
  `uvm_object_utils(reg2bus_adapter)

  function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    
    apb_transfer item ;
    item = apb_transfer::type_id::create("item");
    item.pwrite = pwrite_e'((rw.kind == UVM_READ)? 0 : 1);
    item.paddr = rw.addr;
    item.pwdata = rw.data;
    
    return item;
  endfunction
    
  function void bus2reg(uvm_sequence_item bus_item ,ref uvm_reg_bus_op rw);
    
    apb_transfer item;
    if(!cast(item,bus_item))
      `uvm_fatal(get_type_name(),"provided bus_item is not of correct type")
    rw.kind = item.pwrite ? UVM_WRITE:UVM_READ;
    rw.addr = item.paddr;
    rw.data = item.pwdata;
    rw.status = UVM_IS_OK;
    
  endfunction
  
  
endclass:reg2bus_adapter
