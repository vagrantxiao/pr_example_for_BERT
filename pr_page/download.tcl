open_hw
connect_hw_server
open_hw_target
current_hw_device [get_hw_devices xczu9_0]
set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {../F001_overlay/main.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./zculling_bot.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./zculling_top.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./coloringFB_bot_m.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./coloringFB_top_m.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./p2p.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./data_redir_m.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

set_property PROBES.FILE {} [get_hw_devices xczu9_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xczu9_0]
set_property PROGRAM.FILE {./rasterization2_m.bit} [get_hw_devices xczu9_0]
program_hw_devices [get_hw_devices xczu9_0]
refresh_hw_device [lindex [get_hw_devices xczu9_0] 0]

