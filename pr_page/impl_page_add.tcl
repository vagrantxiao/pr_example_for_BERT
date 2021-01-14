set logFileId [open ./runLogImpl_add.log "w"]
set_param general.maxThreads 2 

#####################
## read_checkpoint ##
#####################
set start_time [clock seconds]
open_checkpoint ../overlay/overlay.dcp
update_design -cell u96_pr_i/leaf_empty_0/inst -black_box
read_checkpoint -cell u96_pr_i/leaf_empty_0/inst page_add_netlist.dcp
set end_time [clock seconds]
set total_seconds [expr $end_time - $start_time]
puts $logFileId "read_checkpoint: $total_seconds seconds"


####################
## implementation ##
####################
set start_time [clock seconds]
#reset_timing 
opt_design 
set end_time [clock seconds]
set total_seconds [expr $end_time - $start_time]
puts $logFileId "opt: $total_seconds seconds"
write_checkpoint  -force  add_opt.dcp

set start_time [clock seconds]
if { [catch {place_design} errmsg] } {
  puts $logFileId "place: 99999 failed!"
}
set end_time [clock seconds]
set total_seconds [expr $end_time - $start_time]
puts $logFileId "place: $total_seconds seconds"
write_checkpoint  -force  add_placed.dcp

set start_time [clock seconds]
if { [catch {route_design  } errmsg] } {
  puts $logFileId "routing: 99999 failed!"
}
set end_time [clock seconds]
set total_seconds [expr $end_time - $start_time]
puts $logFileId "route: $total_seconds seconds"
write_checkpoint -force   add_routed.dcp


###############
## bitstream ##
###############
set_param bitstream.enablePR 2341
set start_time [clock seconds]
write_bitstream  -force  -cell u96_pr_i/leaf_empty_0/inst add.bit
set end_time [clock seconds]
set total_seconds [expr $end_time - $start_time]
puts $logFileId "bit_gen: $total_seconds seconds"
report_utilization -pblocks p_5 > impl_utilization_add.rpt
report_timing_summary > timing_add.rpt
