class apb_base_seq extends uvm_sequence#(apb_transfer);
  
  `uvm_object_utils(apb_base_seq)
  
  function new(string name = "apb_base_seq");
    super.new(name);
  endfunction : new
endclass : apb_base_seq
