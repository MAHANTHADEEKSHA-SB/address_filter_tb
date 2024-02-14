# ********************************************************************************************
# Organisation : Wafer Space Semiconductor Technologies
# Guide : Sakthivel Veerappalam, Director - Engineering (DV) (mail : sakthivelv@waferspace.com)
# Author : Sagar B C, Design Engineer Trainee (DV) (mail : sagarc@waferspace.com)
#
# Copyright (c) 2023, Wafer Space Semiconductor Technologies
# All rights reserved
# Redistribution and use in source code or binary form is allowed only if the following conditions are met
#  ** To use the code as is, prior intimation is required  
#  ** To use any part of the code proper endorsements and credits must be given to author
# **********************************************************************************************


# ******************************************************************************
# Make file for questasim simulator
# ****************************************************************************** 
# Separate libraries are created for design files and tb
# designlib and tblib
# If files are not modified then are not recompiled
# Note : All the  Environment variables are defined inside ~/.bashrc file


# Override this macro value to "1" to run simulation in GUI mode
#<<<<<<< HEAD
#GUI=0
#TEST=
#DESIGN_LIB=/home/mahanthab/projects/ahb_uvc/design/design_work
#TB_LIB=/home/mahanthab/projects/ahb_uvc/tb/tb_work
#RTL=/home/mahanthab/projects/ahb_uvc/design/
#RTL_COMP_LOG=/home/mahanthab/projects/ahb_uvc/sim/design.log
#TB=/home/mahanthab/projects/ahb_uvc/tb/
#TB_COMP_LOG=/home/mahanthab/projects/ahb_uvc/sim/tb.log
#TB_TOP=/home/mahanthab/projects/ahb_uvc/tb/tb.tops
#WLF=/home/mahanthab/projects/ahb_uvc/sim/vsim.wlf
#SIM_LOG=/home/mahanthab/projects/ahb_uvc/sim/simulation.log
#COVER=/home/mahanthab/projects/ahb_uvc/coverage/
##override EN_COV to 1 to enable coverage collection
#EN_COV=0
#
#
#ifneq ($(GUI),1)
#all : design_compile tb_compile sim  
#else
#all : design_compile tb_compile simgui
#endif  
#
## Design files compilation 
#design_compile : design_library
#	vlog -work $(DESIGN_LIB) -incr -f $(RTL)/design_list.f +cover -l $(RTL_COMP_LOG) +fcover
#
## TB files compilation
#tb_compile : tb_library
#	vlog -work $(TB_LIB) -incr -f $(TB)/tb_list.f -l $(TB_COMP_LOG) -writetoplevels $(TB_TOP) 
#
## Simulation in compiler mode
#sim : 
#	vsim -c -L $(DESIGN_LIB) -lib $(TB_LIB) -f $(TB_TOP) -wlf $(WLF) -l $(SIM_LOG)/$(TEST).log -assertfile assert_log.txt -coverage +UVM_TESTNAME=$(TEST)  -do "coverage save -onexit $(COVER)/$(TEST).ucdb;run -all"
#
## Simulation in GUI mode
#simgui :
#	vsim -L $(DESIGN_LIB) -lib $(TB_LIB) -f $(TB_TOP) -wlf $(WLF) -l $(SIM_LOG) -novopt +UVM_TESTNAME=$(TEST) -do "add wave -r *; run -all; q"
#
## To create separate design and tb library directories
## Libraries are created only once
#design_library : 
#	if [ ! -d $(DESIGN_LIB) ]; then vlib $(DESIGN_LIB); fi
#      
#tb_library :
#	if [ ! -d $(TB_LIB) ]; then vlib $(TB_LIB); fi
#
#
## To clean all the files created during compilation and simulation
#clean:
#	rm -rf $(DESIGN_LIB) $(TB_LIB) $(RTL_COMP_LOG) $(TB_COMP_LOG) $(SIM_LOG) $(WLF) $(TB_TOP)
#=======
# ?= will define the variable if not defined
GUI=0
VERBOSITY ?=UVM_MEDIUM
TEST ?="base_test"
DESIGN_LIB ?="/home/mahanthab/projects/address_filter_tb/rtl"
TB_LIB ?="/home/mahanthab/projects/address_filter_tb/tb"
RTL ?="/home/mahanthab/projects/address_filter_tb/rtl/"
RTL_COMP_LOG ?="/home/mahanthab/projects/address_filter_tb/sim/"
TB ?="/home/mahanthab/projects/address_filter_tb/tb/"
TB_COMP_LOG ?="/home/mahanthab/projects/address_filter_tb/sim/"
TB_TOP ?="/home/mahanthab/projects/address_filter_tb/tb/tb.tops"
WLF ?="/home/mahanthab/projects/address_filter_tb/sim/xmsim.wlf"
SIM_LOG ?="/home/mahanthab/projects/address_filter_tb/sim/"
COVER ?="/home/mahanthab/projects/address_filter_tb/coverage/"

ifeq ($(GUI),1)
all : design_comp tb_comp gui  
else
all : design_comp tb_comp compiler
endif  

design_comp :
	xrun -y $(DESIGN_LIB)/design_lib -compile -uvm -uvmaccess -f $(RTL)design_list.f -perfstat -perflog $(SIM_LOG)perf.log 
tb_comp : 
	xrun -y $(TB_LIB)/tb_lib -compile -uvm -uvmaccess -f $(TB)tb_list.f -perfstat -perflog $(SIM_LOG)perf.log 

elaborate : 
	xrun -y $(TB_LIB)/tb_lib -l$(DESIGN_LIB)/design_lib -work tb_lib -elabonly -Q -uvm -uvmaccess -f $(RTL)design_list.f -f $(TB)tb_list.f -perfstat -perflog $(SIM_LOG)perf.log 
gui :
	xrun -y $(TB_LIB)/tb_lib -work tb_lib -l$(DESIGN_LIB)/design_lib -run -Q -gui -access +rwc -uvm -uvmaccess -f $(RTL)design_list.f -f $(TB)tb_list.f +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=$(VERBOSITY) -l $(SIM_LOG)test.log -history_file $(SIM_LOG)history.log
compiler :
	xrun -y $(TB_LIB)/tb_lib -l$(DESIGN_LIB)/design_lib -work tb_lib -run -Q -access +rwc -uvm -uvmaccess -f $(RTL)design_list.f -f $(TB)tb_list.f +UVM_TESTNAME=$(TEST) +UVM_VERBOSITY=$(VERBOSITY) -l $(SIM_LOG)test.log -history_file $(SIM_LOG)history.log

create_design_lib:
	xrun -xmlibdirpath $(DESIGN_LIB)  -xmlibdirname design_lib -compile -f $(RTL)design_list.f 

create_tb_lib : 
	xrun -xmlibdirpath $(TB_LIB) -xmlibdirname tb_lib -compile -uvm -uvmaccess -sv -f $(TB)tb_list.f

create_both_lib : 
	xrun -xmlibdirpath $(DESIGN_LIB)  -xmlibdirname design_lib -compile -f $(RTL)design_list.f 
	xrun -xmlibdirpath $(TB_LIB) -xmlibdirname tb_lib -compile -uvm -uvmaccess -sv -f $(TB)tb_list.f
clean : 
	xrun -clean
