add_files -norecurse ./riscv_mul_dat/picorv_mem.v

set dir "./src/"
set contents [glob -nocomplain -directory $dir *]
foreach item $contents {
  if { [regexp {.*\.tcl} $item] } {
    source $item
  } else {
    add_files -norecurse $item
  }
}

set_param general.maxThreads  8
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY XPM_FIFO} [current_project]
set logFileId [open ./runLog_zculling_bot.log "w"]
set start_time [clock seconds]
set_param general.maxThreads  8 
synth_design -top leaf -part xczu9eg-ffvb1156-2-e -mode out_of_context
write_checkpoint -force page_mul_netlist.dcp
set end_time [clock seconds]
set total_seconds [expr $end_time - $start_time]
puts $logFileId "syn: $total_seconds seconds"
report_utilization -hierarchical > utilization.rpt
