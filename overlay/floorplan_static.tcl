
################################################################
# This is a generated script based on design: floorplan_static
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source floorplan_static_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, leaf_empty, AxiLite2Bft_v2_0, InterfaceWrapper1, InterfaceWrapper7, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, axi2stream_v1_0, dma_converter, leaf, leaf, leaf, leaf, leaf, leaf, leaf, leaf, leaf, leaf, leaf, leaf, leaf, pi_cluster_0, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, pipe_ff_1, subtree_212_wrapper, subtree_212_wrapper, subtree_212_wrapper, subtree_212_wrapper, t_cluster_0, t_cluster_0

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu9eg-ffvb1156-2-e
   set_property BOARD_PART xilinx.com:zcu102:part0:3.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name floorplan_static

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:zynq_ultra_ps_e:3.2\
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
leaf_empty\
AxiLite2Bft_v2_0\
InterfaceWrapper1\
InterfaceWrapper7\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
axi2stream_v1_0\
dma_converter\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
leaf\
pi_cluster_0\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
pipe_ff_1\
subtree_212_wrapper\
subtree_212_wrapper\
subtree_212_wrapper\
subtree_212_wrapper\
t_cluster_0\
t_cluster_0\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: axi_leaf
proc create_hier_cell_axi_leaf { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_axi_leaf() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI1
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  # Create pins
  create_bd_pin -dir I -type rst axi_resetn
  create_bd_pin -dir I clk_bft
  create_bd_pin -dir O -from 0 -to 0 dout
  create_bd_pin -dir O -from 0 -to 0 dout1
  create_bd_pin -dir O -from 0 -to 0 dout2
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir I -from 48 -to 0 leaf_0_in
  create_bd_pin -dir I -from 48 -to 0 leaf_0_in2
  create_bd_pin -dir O -from 48 -to 0 leaf_0_out
  create_bd_pin -dir O -from 48 -to 0 leaf_0_out2
  create_bd_pin -dir I -from 48 -to 0 leaf_1_in
  create_bd_pin -dir I -from 48 -to 0 leaf_1_in2
  create_bd_pin -dir O -from 48 -to 0 leaf_1_out
  create_bd_pin -dir O -from 48 -to 0 leaf_1_out2
  create_bd_pin -dir I -from 48 -to 0 leaf_2_in
  create_bd_pin -dir I -from 48 -to 0 leaf_2_in3
  create_bd_pin -dir O -from 48 -to 0 leaf_2_out
  create_bd_pin -dir O -from 48 -to 0 leaf_2_out3
  create_bd_pin -dir I -from 48 -to 0 leaf_3_in
  create_bd_pin -dir I -from 48 -to 0 leaf_3_in3
  create_bd_pin -dir O -from 48 -to 0 leaf_3_out
  create_bd_pin -dir O -from 48 -to 0 leaf_3_out3
  create_bd_pin -dir I -from 48 -to 0 leaf_4_in
  create_bd_pin -dir I -from 48 -to 0 leaf_4_in3
  create_bd_pin -dir O -from 48 -to 0 leaf_4_out
  create_bd_pin -dir O -from 48 -to 0 leaf_4_out3
  create_bd_pin -dir I -from 48 -to 0 leaf_5_in
  create_bd_pin -dir I -from 48 -to 0 leaf_5_in3
  create_bd_pin -dir O -from 48 -to 0 leaf_5_out
  create_bd_pin -dir O -from 48 -to 0 leaf_5_out3
  create_bd_pin -dir I -from 48 -to 0 leaf_6_in
  create_bd_pin -dir I -from 48 -to 0 leaf_6_in3
  create_bd_pin -dir O -from 48 -to 0 leaf_6_out
  create_bd_pin -dir O -from 48 -to 0 leaf_6_out3
  create_bd_pin -dir I -from 48 -to 0 leaf_7_in
  create_bd_pin -dir I -from 48 -to 0 leaf_7_in3
  create_bd_pin -dir O -from 48 -to 0 leaf_7_out
  create_bd_pin -dir O -from 48 -to 0 leaf_7_out3
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_reset
  create_bd_pin -dir O resend_0
  create_bd_pin -dir O resend_1
  create_bd_pin -dir O resend_2
  create_bd_pin -dir O resend_3
  create_bd_pin -dir O resend_4
  create_bd_pin -dir O resend_5
  create_bd_pin -dir O resend_6
  create_bd_pin -dir O resend_7
  create_bd_pin -dir O resend_22
  create_bd_pin -dir O resend_23
  create_bd_pin -dir O resend_24
  create_bd_pin -dir O resend_25
  create_bd_pin -dir O resend_26
  create_bd_pin -dir O resend_27
  create_bd_pin -dir O resend_28
  create_bd_pin -dir O resend_29
  create_bd_pin -dir I -type rst reset1
  create_bd_pin -dir I -type rst reset_bft
  create_bd_pin -dir I -type rst reset_bft1
  create_bd_pin -dir I -type rst reset_bft2
  create_bd_pin -dir I -type rst reset_bft3
  create_bd_pin -dir I -type clk s00_axi_aclk

  # Create instance: AxiLite2Bft_v2_0_0, and set properties
  set block_name AxiLite2Bft_v2_0
  set block_cell_name AxiLite2Bft_v2_0_0
  if { [catch {set AxiLite2Bft_v2_0_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AxiLite2Bft_v2_0_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: InterfaceWrapper1_0, and set properties
  set block_name InterfaceWrapper1
  set block_cell_name InterfaceWrapper1_0
  if { [catch {set InterfaceWrapper1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $InterfaceWrapper1_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: InterfaceWrapper7_0, and set properties
  set block_name InterfaceWrapper7
  set block_cell_name InterfaceWrapper7_0
  if { [catch {set InterfaceWrapper7_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $InterfaceWrapper7_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ap_start_source, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_source
  if { [catch {set ap_start_source [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_source eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_source

  # Create instance: ap_start_top, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top
  if { [catch {set ap_start_top [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top

  # Create instance: ap_start_top01, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top01
  if { [catch {set ap_start_top01 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top01 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top01

  # Create instance: ap_start_top02, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top02
  if { [catch {set ap_start_top02 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top02 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top02

  # Create instance: ap_start_top03, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top03
  if { [catch {set ap_start_top03 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top03 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top03

  # Create instance: ap_start_top3, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top3
  if { [catch {set ap_start_top3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top3 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top3

  # Create instance: ap_start_top11, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top11
  if { [catch {set ap_start_top11 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top11 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top11

  # Create instance: ap_start_top12, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top12
  if { [catch {set ap_start_top12 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top12 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top12

  # Create instance: ap_start_top13, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top13
  if { [catch {set ap_start_top13 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top13 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top13

  # Create instance: ap_start_top21, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top21
  if { [catch {set ap_start_top21 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top21 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top21

  # Create instance: ap_start_top22, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top22
  if { [catch {set ap_start_top22 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top22 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top22

  # Create instance: ap_start_top23, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top23
  if { [catch {set ap_start_top23 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top23 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top23

  # Create instance: ap_start_top31, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top31
  if { [catch {set ap_start_top31 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top31 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top31

  # Create instance: ap_start_top32, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top32
  if { [catch {set ap_start_top32 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top32 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top32

  # Create instance: ap_start_top33, and set properties
  set block_name pipe_ff_1
  set block_cell_name ap_start_top33
  if { [catch {set ap_start_top33 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ap_start_top33 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {1} \
 ] $ap_start_top33

  # Create instance: axi2stream_v1_0_0, and set properties
  set block_name axi2stream_v1_0
  set block_cell_name axi2stream_v1_0_0
  if { [catch {set axi2stream_v1_0_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $axi2stream_v1_0_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_mm2s_burst_size {256} \
   CONFIG.c_s2mm_burst_size {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
 ] $axi_dma_0

  # Create instance: axi_smc_2, and set properties
  set axi_smc_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc_2 ]
  set_property -dict [ list \
   CONFIG.NUM_SI {3} \
 ] $axi_smc_2

  # Create instance: dma_converter_0, and set properties
  set block_name dma_converter
  set block_cell_name dma_converter_0
  if { [catch {set dma_converter_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dma_converter_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_19, and set properties
  set block_name leaf
  set block_cell_name leaf_19
  if { [catch {set leaf_19 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_19 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_20, and set properties
  set block_name leaf
  set block_cell_name leaf_20
  if { [catch {set leaf_20 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_20 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_21, and set properties
  set block_name leaf
  set block_cell_name leaf_21
  if { [catch {set leaf_21 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_21 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_22, and set properties
  set block_name leaf
  set block_cell_name leaf_22
  if { [catch {set leaf_22 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_22 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_23, and set properties
  set block_name leaf
  set block_cell_name leaf_23
  if { [catch {set leaf_23 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_23 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_24, and set properties
  set block_name leaf
  set block_cell_name leaf_24
  if { [catch {set leaf_24 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_24 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_25, and set properties
  set block_name leaf
  set block_cell_name leaf_25
  if { [catch {set leaf_25 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_25 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_26, and set properties
  set block_name leaf
  set block_cell_name leaf_26
  if { [catch {set leaf_26 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_26 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_27, and set properties
  set block_name leaf
  set block_cell_name leaf_27
  if { [catch {set leaf_27 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_27 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_28, and set properties
  set block_name leaf
  set block_cell_name leaf_28
  if { [catch {set leaf_28 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_28 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_29, and set properties
  set block_name leaf
  set block_cell_name leaf_29
  if { [catch {set leaf_29 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_29 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_30, and set properties
  set block_name leaf
  set block_cell_name leaf_30
  if { [catch {set leaf_30 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_30 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_31, and set properties
  set block_name leaf
  set block_cell_name leaf_31
  if { [catch {set leaf_31 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_31 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: pi_cluster_0_0, and set properties
  set block_name pi_cluster_0
  set block_cell_name pi_cluster_0_0
  if { [catch {set pi_cluster_0_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pi_cluster_0_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.level {0} \
   CONFIG.num_leaves {32} \
   CONFIG.num_switches {4} \
   CONFIG.p_sz {49} \
   CONFIG.payload_sz {43} \
 ] $pi_cluster_0_0

  # Create instance: pipe_ff_1_0, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_0
  if { [catch {set pipe_ff_1_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_0

  # Create instance: pipe_ff_1_1, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_1
  if { [catch {set pipe_ff_1_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_1

  # Create instance: pipe_ff_1_2, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_2
  if { [catch {set pipe_ff_1_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_2 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_2

  # Create instance: pipe_ff_1_3, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_3
  if { [catch {set pipe_ff_1_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_3 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_3

  # Create instance: pipe_ff_1_4, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_4
  if { [catch {set pipe_ff_1_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_4 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_4

  # Create instance: pipe_ff_1_5, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_5
  if { [catch {set pipe_ff_1_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_5 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_5

  # Create instance: pipe_ff_1_6, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_6
  if { [catch {set pipe_ff_1_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_6 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_6

  # Create instance: pipe_ff_1_7, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_7
  if { [catch {set pipe_ff_1_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_7 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_7

  # Create instance: pipe_ff_1_8, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_8
  if { [catch {set pipe_ff_1_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_8 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_8

  # Create instance: pipe_ff_1_9, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_9
  if { [catch {set pipe_ff_1_9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_9 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_9

  # Create instance: pipe_ff_1_10, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_10
  if { [catch {set pipe_ff_1_10 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_10 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_10

  # Create instance: pipe_ff_1_11, and set properties
  set block_name pipe_ff_1
  set block_cell_name pipe_ff_1_11
  if { [catch {set pipe_ff_1_11 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $pipe_ff_1_11 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.data_width {196} \
 ] $pipe_ff_1_11

  # Create instance: ps8_0_axi_periph, and set properties
  set ps8_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps8_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {2} \
 ] $ps8_0_axi_periph

  # Create instance: rst_ps8_0_99M, and set properties
  set rst_ps8_0_99M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M ]

  # Create instance: subtree_212_wrapper_0, and set properties
  set block_name subtree_212_wrapper
  set block_cell_name subtree_212_wrapper_0
  if { [catch {set subtree_212_wrapper_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $subtree_212_wrapper_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: subtree_212_wrapper_1, and set properties
  set block_name subtree_212_wrapper
  set block_cell_name subtree_212_wrapper_1
  if { [catch {set subtree_212_wrapper_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $subtree_212_wrapper_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.addr {"01"} \
 ] $subtree_212_wrapper_1

  # Create instance: subtree_212_wrapper_2, and set properties
  set block_name subtree_212_wrapper
  set block_cell_name subtree_212_wrapper_2
  if { [catch {set subtree_212_wrapper_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $subtree_212_wrapper_2 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.addr {"10"} \
 ] $subtree_212_wrapper_2

  # Create instance: subtree_212_wrapper_3, and set properties
  set block_name subtree_212_wrapper
  set block_cell_name subtree_212_wrapper_3
  if { [catch {set subtree_212_wrapper_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $subtree_212_wrapper_3 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.addr {"11"} \
 ] $subtree_212_wrapper_3

  # Create instance: t_cluster_0_0, and set properties
  set block_name t_cluster_0
  set block_cell_name t_cluster_0_0
  if { [catch {set t_cluster_0_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $t_cluster_0_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.level {1} \
   CONFIG.num_leaves {32} \
   CONFIG.num_switches {4} \
   CONFIG.p_sz {49} \
   CONFIG.payload_sz {43} \
 ] $t_cluster_0_0

  # Create instance: t_cluster_0_1, and set properties
  set block_name t_cluster_0
  set block_cell_name t_cluster_0_1
  if { [catch {set t_cluster_0_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $t_cluster_0_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.addr {"1"} \
   CONFIG.level {1} \
   CONFIG.num_leaves {32} \
   CONFIG.num_switches {4} \
   CONFIG.p_sz {49} \
   CONFIG.payload_sz {43} \
 ] $t_cluster_0_1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {392} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_smc_2/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_smc_2/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_SG [get_bd_intf_pins axi_dma_0/M_AXI_SG] [get_bd_intf_pins axi_smc_2/S00_AXI]
  connect_bd_intf_net -intf_net axi_smc_2_M00_AXI [get_bd_intf_pins M00_AXI1] [get_bd_intf_pins axi_smc_2/M00_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M00_AXI [get_bd_intf_pins AxiLite2Bft_v2_0_0/s00_axi] [get_bd_intf_pins ps8_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M01_AXI [get_bd_intf_pins axi_dma_0/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M02_AXI [get_bd_intf_pins axi2stream_v1_0_0/s00_axi] [get_bd_intf_pins ps8_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins S00_AXI] [get_bd_intf_pins ps8_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM1_FPD [get_bd_intf_pins S01_AXI] [get_bd_intf_pins ps8_0_axi_periph/S01_AXI]

  # Create port connections
  connect_bd_net -net AxiLite2Bft_v2_0_0_ap_start [get_bd_pins AxiLite2Bft_v2_0_0/ap_start] [get_bd_pins ap_start_source/din]
  connect_bd_net -net AxiLite2Bft_v2_0_0_host_interface2bft [get_bd_pins AxiLite2Bft_v2_0_0/host_interface2bft] [get_bd_pins subtree_212_wrapper_0/leaf_0_in]
  connect_bd_net -net InterfaceWrapper1_0_Input_1_V_V_ap_ack [get_bd_pins InterfaceWrapper1_0/Input_1_V_V_ap_ack] [get_bd_pins axi_dma_0/m_axis_mm2s_tready]
  connect_bd_net -net InterfaceWrapper1_0_dout_leaf_interface2bft [get_bd_pins InterfaceWrapper1_0/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_0/leaf_1_in]
  connect_bd_net -net InterfaceWrapper7_0_Input_1_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_1_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward1]
  connect_bd_net -net InterfaceWrapper7_0_Input_2_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_2_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward2]
  connect_bd_net -net InterfaceWrapper7_0_Input_3_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_3_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward3]
  connect_bd_net -net InterfaceWrapper7_0_Input_4_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_4_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward4]
  connect_bd_net -net InterfaceWrapper7_0_Input_5_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_5_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward5]
  connect_bd_net -net InterfaceWrapper7_0_Input_6_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_6_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward6]
  connect_bd_net -net InterfaceWrapper7_0_Input_7_V_V_ap_ack [get_bd_pins InterfaceWrapper7_0/Input_7_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_downward7]
  connect_bd_net -net InterfaceWrapper7_0_Output_1_V_V [get_bd_pins InterfaceWrapper7_0/Output_1_V_V] [get_bd_pins axi2stream_v1_0_0/din1]
  connect_bd_net -net InterfaceWrapper7_0_Output_1_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_1_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in1]
  connect_bd_net -net InterfaceWrapper7_0_Output_2_V_V [get_bd_pins InterfaceWrapper7_0/Output_2_V_V] [get_bd_pins axi2stream_v1_0_0/din2]
  connect_bd_net -net InterfaceWrapper7_0_Output_2_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_2_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in2]
  connect_bd_net -net InterfaceWrapper7_0_Output_3_V_V [get_bd_pins InterfaceWrapper7_0/Output_3_V_V] [get_bd_pins axi2stream_v1_0_0/din3]
  connect_bd_net -net InterfaceWrapper7_0_Output_3_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_3_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in3]
  connect_bd_net -net InterfaceWrapper7_0_Output_4_V_V [get_bd_pins InterfaceWrapper7_0/Output_4_V_V] [get_bd_pins axi2stream_v1_0_0/din4]
  connect_bd_net -net InterfaceWrapper7_0_Output_4_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_4_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in4]
  connect_bd_net -net InterfaceWrapper7_0_Output_5_V_V [get_bd_pins InterfaceWrapper7_0/Output_5_V_V] [get_bd_pins axi2stream_v1_0_0/din5]
  connect_bd_net -net InterfaceWrapper7_0_Output_5_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_5_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in5]
  connect_bd_net -net InterfaceWrapper7_0_Output_6_V_V [get_bd_pins InterfaceWrapper7_0/Output_6_V_V] [get_bd_pins axi2stream_v1_0_0/din6]
  connect_bd_net -net InterfaceWrapper7_0_Output_6_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_6_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in6]
  connect_bd_net -net InterfaceWrapper7_0_Output_7_V_V [get_bd_pins InterfaceWrapper7_0/Output_7_V_V] [get_bd_pins axi2stream_v1_0_0/din7]
  connect_bd_net -net InterfaceWrapper7_0_Output_7_V_V_ap_vld [get_bd_pins InterfaceWrapper7_0/Output_7_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_in7]
  connect_bd_net -net InterfaceWrapper7_0_dout_leaf_interface2bft [get_bd_pins InterfaceWrapper7_0/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_0/leaf_2_in]
  connect_bd_net -net ap_start_source_dout [get_bd_pins ap_start_source/dout] [get_bd_pins ap_start_top/din] [get_bd_pins ap_start_top3/din]
  connect_bd_net -net ap_start_top01_dout [get_bd_pins ap_start_top01/dout] [get_bd_pins ap_start_top02/din]
  connect_bd_net -net ap_start_top02_dout [get_bd_pins ap_start_top02/dout] [get_bd_pins ap_start_top03/din]
  connect_bd_net -net ap_start_top03_dout [get_bd_pins dout] [get_bd_pins ap_start_top03/dout]
  connect_bd_net -net ap_start_top11_dout [get_bd_pins ap_start_top11/dout] [get_bd_pins ap_start_top12/din]
  connect_bd_net -net ap_start_top12_dout [get_bd_pins ap_start_top12/dout] [get_bd_pins ap_start_top13/din]
  connect_bd_net -net ap_start_top21_dout [get_bd_pins ap_start_top21/dout] [get_bd_pins ap_start_top22/din]
  connect_bd_net -net ap_start_top22_dout [get_bd_pins ap_start_top22/dout] [get_bd_pins ap_start_top23/din]
  connect_bd_net -net ap_start_top31_dout [get_bd_pins ap_start_top31/dout] [get_bd_pins ap_start_top32/din]
  connect_bd_net -net ap_start_top32_dout [get_bd_pins ap_start_top32/dout] [get_bd_pins ap_start_top33/din]
  connect_bd_net -net ap_start_top3_dout [get_bd_pins ap_start_top01/din] [get_bd_pins ap_start_top3/dout]
  connect_bd_net -net axi2stream_v1_0_0_dout1 [get_bd_pins InterfaceWrapper7_0/Input_1_V_V] [get_bd_pins axi2stream_v1_0_0/dout1]
  connect_bd_net -net axi2stream_v1_0_0_dout2 [get_bd_pins InterfaceWrapper7_0/Input_2_V_V] [get_bd_pins axi2stream_v1_0_0/dout2]
  connect_bd_net -net axi2stream_v1_0_0_dout3 [get_bd_pins InterfaceWrapper7_0/Input_3_V_V] [get_bd_pins axi2stream_v1_0_0/dout3]
  connect_bd_net -net axi2stream_v1_0_0_dout4 [get_bd_pins InterfaceWrapper7_0/Input_4_V_V] [get_bd_pins axi2stream_v1_0_0/dout4]
  connect_bd_net -net axi2stream_v1_0_0_dout5 [get_bd_pins InterfaceWrapper7_0/Input_5_V_V] [get_bd_pins axi2stream_v1_0_0/dout5]
  connect_bd_net -net axi2stream_v1_0_0_dout6 [get_bd_pins InterfaceWrapper7_0/Input_6_V_V] [get_bd_pins axi2stream_v1_0_0/dout6]
  connect_bd_net -net axi2stream_v1_0_0_dout7 [get_bd_pins InterfaceWrapper7_0/Input_7_V_V] [get_bd_pins axi2stream_v1_0_0/dout7]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward1 [get_bd_pins InterfaceWrapper7_0/Output_1_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward1]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward2 [get_bd_pins InterfaceWrapper7_0/Output_2_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward2]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward3 [get_bd_pins InterfaceWrapper7_0/Output_3_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward3]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward4 [get_bd_pins InterfaceWrapper7_0/Output_4_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward4]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward5 [get_bd_pins InterfaceWrapper7_0/Output_5_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward5]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward6 [get_bd_pins InterfaceWrapper7_0/Output_6_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward6]
  connect_bd_net -net axi2stream_v1_0_0_ready_upward7 [get_bd_pins InterfaceWrapper7_0/Output_7_V_V_ap_ack] [get_bd_pins axi2stream_v1_0_0/ready_upward7]
  connect_bd_net -net axi2stream_v1_0_0_val_out1 [get_bd_pins InterfaceWrapper7_0/Input_1_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out1]
  connect_bd_net -net axi2stream_v1_0_0_val_out2 [get_bd_pins InterfaceWrapper7_0/Input_2_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out2]
  connect_bd_net -net axi2stream_v1_0_0_val_out3 [get_bd_pins InterfaceWrapper7_0/Input_3_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out3]
  connect_bd_net -net axi2stream_v1_0_0_val_out4 [get_bd_pins InterfaceWrapper7_0/Input_4_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out4]
  connect_bd_net -net axi2stream_v1_0_0_val_out5 [get_bd_pins InterfaceWrapper7_0/Input_5_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out5]
  connect_bd_net -net axi2stream_v1_0_0_val_out6 [get_bd_pins InterfaceWrapper7_0/Input_6_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out6]
  connect_bd_net -net axi2stream_v1_0_0_val_out7 [get_bd_pins InterfaceWrapper7_0/Input_7_V_V_ap_vld] [get_bd_pins axi2stream_v1_0_0/val_out7]
  connect_bd_net -net axi_dma_0_m_axis_mm2s_tdata [get_bd_pins InterfaceWrapper1_0/Input_1_V_V] [get_bd_pins axi_dma_0/m_axis_mm2s_tdata]
  connect_bd_net -net axi_dma_0_m_axis_mm2s_tvalid [get_bd_pins InterfaceWrapper1_0/Input_1_V_V_ap_vld] [get_bd_pins axi_dma_0/m_axis_mm2s_tvalid]
  connect_bd_net -net axi_dma_1_s_axis_s2mm_tready [get_bd_pins InterfaceWrapper1_0/Output_1_V_V_ap_ack] [get_bd_pins axi_dma_0/s_axis_s2mm_tready] [get_bd_pins dma_converter_0/ready]
  connect_bd_net -net bft_01_bus_o [get_bd_pins pipe_ff_1_6/din] [get_bd_pins subtree_212_wrapper_1/bus_o]
  connect_bd_net -net bft_01_dout [get_bd_pins dout1] [get_bd_pins ap_start_top13/dout]
  connect_bd_net -net bft_01_leaf_0_out [get_bd_pins leaf_0_out2] [get_bd_pins subtree_212_wrapper_1/leaf_0_out]
  connect_bd_net -net bft_01_leaf_1_out [get_bd_pins leaf_1_out2] [get_bd_pins subtree_212_wrapper_1/leaf_1_out]
  connect_bd_net -net bft_01_leaf_2_out [get_bd_pins leaf_2_out3] [get_bd_pins subtree_212_wrapper_1/leaf_2_out]
  connect_bd_net -net bft_01_leaf_3_out [get_bd_pins leaf_3_out3] [get_bd_pins subtree_212_wrapper_1/leaf_3_out]
  connect_bd_net -net bft_01_leaf_4_out [get_bd_pins leaf_4_out3] [get_bd_pins subtree_212_wrapper_1/leaf_4_out]
  connect_bd_net -net bft_01_leaf_5_out [get_bd_pins leaf_5_out3] [get_bd_pins subtree_212_wrapper_1/leaf_5_out]
  connect_bd_net -net bft_01_leaf_6_out [get_bd_pins leaf_6_out3] [get_bd_pins subtree_212_wrapper_1/leaf_6_out]
  connect_bd_net -net bft_01_leaf_7_out [get_bd_pins leaf_7_out3] [get_bd_pins subtree_212_wrapper_1/leaf_7_out]
  connect_bd_net -net bft_01_resend_0 [get_bd_pins resend_22] [get_bd_pins subtree_212_wrapper_1/resend_0]
  connect_bd_net -net bft_01_resend_1 [get_bd_pins resend_23] [get_bd_pins subtree_212_wrapper_1/resend_1]
  connect_bd_net -net bft_01_resend_2 [get_bd_pins resend_24] [get_bd_pins subtree_212_wrapper_1/resend_2]
  connect_bd_net -net bft_01_resend_3 [get_bd_pins resend_25] [get_bd_pins subtree_212_wrapper_1/resend_3]
  connect_bd_net -net bft_01_resend_4 [get_bd_pins resend_26] [get_bd_pins subtree_212_wrapper_1/resend_4]
  connect_bd_net -net bft_01_resend_5 [get_bd_pins resend_29] [get_bd_pins subtree_212_wrapper_1/resend_5]
  connect_bd_net -net bft_01_resend_6 [get_bd_pins resend_28] [get_bd_pins subtree_212_wrapper_1/resend_6]
  connect_bd_net -net bft_01_resend_7 [get_bd_pins resend_27] [get_bd_pins subtree_212_wrapper_1/resend_7]
  connect_bd_net -net bft_10_bus_o [get_bd_pins pipe_ff_1_8/din] [get_bd_pins subtree_212_wrapper_2/bus_o]
  connect_bd_net -net bft_10_dout [get_bd_pins dout2] [get_bd_pins ap_start_top23/dout] [get_bd_pins leaf_19/ap_start] [get_bd_pins leaf_20/ap_start] [get_bd_pins leaf_21/ap_start] [get_bd_pins leaf_22/ap_start] [get_bd_pins leaf_23/ap_start]
  connect_bd_net -net bft_10_leaf_0_out [get_bd_pins leaf_0_out] [get_bd_pins subtree_212_wrapper_2/leaf_0_out]
  connect_bd_net -net bft_10_leaf_1_out [get_bd_pins leaf_1_out] [get_bd_pins subtree_212_wrapper_2/leaf_1_out]
  connect_bd_net -net bft_10_leaf_3_out [get_bd_pins leaf_19/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_2/leaf_3_out]
  connect_bd_net -net bft_10_leaf_4_out [get_bd_pins leaf_20/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_2/leaf_4_out]
  connect_bd_net -net bft_10_leaf_5_out [get_bd_pins leaf_21/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_2/leaf_5_out]
  connect_bd_net -net bft_10_leaf_6_out [get_bd_pins leaf_22/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_2/leaf_6_out]
  connect_bd_net -net bft_10_leaf_7_out [get_bd_pins leaf_23/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_2/leaf_7_out]
  connect_bd_net -net bft_10_resend_0 [get_bd_pins resend_0] [get_bd_pins subtree_212_wrapper_2/resend_0]
  connect_bd_net -net bft_10_resend_1 [get_bd_pins resend_1] [get_bd_pins subtree_212_wrapper_2/resend_1]
  connect_bd_net -net bft_10_resend_3 [get_bd_pins leaf_19/resend] [get_bd_pins subtree_212_wrapper_2/resend_3]
  connect_bd_net -net bft_10_resend_4 [get_bd_pins leaf_20/resend] [get_bd_pins subtree_212_wrapper_2/resend_4]
  connect_bd_net -net bft_10_resend_5 [get_bd_pins leaf_21/resend] [get_bd_pins subtree_212_wrapper_2/resend_5]
  connect_bd_net -net bft_10_resend_6 [get_bd_pins leaf_22/resend] [get_bd_pins subtree_212_wrapper_2/resend_6]
  connect_bd_net -net bft_10_resend_7 [get_bd_pins leaf_23/resend] [get_bd_pins subtree_212_wrapper_2/resend_7]
  connect_bd_net -net bft_11_bus_o [get_bd_pins pipe_ff_1_10/din] [get_bd_pins subtree_212_wrapper_3/bus_o]
  connect_bd_net -net bft_11_dout [get_bd_pins ap_start_top33/dout] [get_bd_pins leaf_24/ap_start] [get_bd_pins leaf_25/ap_start] [get_bd_pins leaf_26/ap_start] [get_bd_pins leaf_27/ap_start] [get_bd_pins leaf_28/ap_start] [get_bd_pins leaf_29/ap_start] [get_bd_pins leaf_30/ap_start] [get_bd_pins leaf_31/ap_start]
  connect_bd_net -net bft_11_leaf_0_out [get_bd_pins leaf_24/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_0_out]
  connect_bd_net -net bft_11_leaf_1_out [get_bd_pins leaf_25/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_1_out]
  connect_bd_net -net bft_11_leaf_2_out [get_bd_pins leaf_26/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_2_out]
  connect_bd_net -net bft_11_leaf_3_out [get_bd_pins leaf_27/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_3_out]
  connect_bd_net -net bft_11_leaf_4_out [get_bd_pins leaf_28/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_4_out]
  connect_bd_net -net bft_11_leaf_5_out [get_bd_pins leaf_29/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_5_out]
  connect_bd_net -net bft_11_leaf_6_out [get_bd_pins leaf_30/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_6_out]
  connect_bd_net -net bft_11_leaf_7_out [get_bd_pins leaf_31/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_3/leaf_7_out]
  connect_bd_net -net bft_11_resend_0 [get_bd_pins leaf_24/resend] [get_bd_pins subtree_212_wrapper_3/resend_0]
  connect_bd_net -net bft_11_resend_1 [get_bd_pins leaf_25/resend] [get_bd_pins subtree_212_wrapper_3/resend_1]
  connect_bd_net -net bft_11_resend_2 [get_bd_pins leaf_26/resend] [get_bd_pins subtree_212_wrapper_3/resend_2]
  connect_bd_net -net bft_11_resend_3 [get_bd_pins leaf_27/resend] [get_bd_pins subtree_212_wrapper_3/resend_3]
  connect_bd_net -net bft_11_resend_4 [get_bd_pins leaf_28/resend] [get_bd_pins subtree_212_wrapper_3/resend_4]
  connect_bd_net -net bft_11_resend_5 [get_bd_pins leaf_29/resend] [get_bd_pins subtree_212_wrapper_3/resend_5]
  connect_bd_net -net bft_11_resend_6 [get_bd_pins leaf_30/resend] [get_bd_pins subtree_212_wrapper_3/resend_6]
  connect_bd_net -net bft_11_resend_7 [get_bd_pins leaf_31/resend] [get_bd_pins subtree_212_wrapper_3/resend_7]
  connect_bd_net -net bft_center_dout1 [get_bd_pins ap_start_top/dout] [get_bd_pins ap_start_top11/din] [get_bd_pins ap_start_top21/din] [get_bd_pins ap_start_top31/din]
  connect_bd_net -net dma_converter_0_keep [get_bd_pins axi_dma_0/s_axis_s2mm_tkeep] [get_bd_pins dma_converter_0/keep]
  connect_bd_net -net dma_converter_0_last [get_bd_pins axi_dma_0/s_axis_s2mm_tlast] [get_bd_pins dma_converter_0/last]
  connect_bd_net -net ext_reset_in_1 [get_bd_pins ext_reset_in] [get_bd_pins rst_ps8_0_99M/ext_reset_in]
  connect_bd_net -net leaf_0_in_1 [get_bd_pins leaf_0_in] [get_bd_pins subtree_212_wrapper_2/leaf_0_in]
  connect_bd_net -net leaf_0_in_2 [get_bd_pins leaf_24/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_0_in]
  connect_bd_net -net leaf_0_in_3 [get_bd_pins leaf_0_in2] [get_bd_pins subtree_212_wrapper_1/leaf_0_in]
  connect_bd_net -net leaf_1_in_1 [get_bd_pins leaf_1_in] [get_bd_pins subtree_212_wrapper_2/leaf_1_in]
  connect_bd_net -net leaf_1_in_2 [get_bd_pins leaf_25/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_1_in]
  connect_bd_net -net leaf_1_in_3 [get_bd_pins leaf_1_in2] [get_bd_pins subtree_212_wrapper_1/leaf_1_in]
  connect_bd_net -net leaf_2_in_1 [get_bd_pins leaf_2_in] [get_bd_pins subtree_212_wrapper_2/leaf_2_in]
  connect_bd_net -net leaf_2_in_2 [get_bd_pins leaf_26/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_2_in]
  connect_bd_net -net leaf_2_in_4 [get_bd_pins leaf_2_in3] [get_bd_pins subtree_212_wrapper_1/leaf_2_in]
  connect_bd_net -net leaf_3_in_1 [get_bd_pins leaf_27/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_3_in]
  connect_bd_net -net leaf_3_in_2 [get_bd_pins leaf_19/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_2/leaf_3_in]
  connect_bd_net -net leaf_3_in_3 [get_bd_pins leaf_3_in3] [get_bd_pins subtree_212_wrapper_1/leaf_3_in]
  connect_bd_net -net leaf_3_in_4 [get_bd_pins leaf_3_in] [get_bd_pins subtree_212_wrapper_0/leaf_3_in]
  connect_bd_net -net leaf_4_in_1 [get_bd_pins leaf_28/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_4_in]
  connect_bd_net -net leaf_4_in_2 [get_bd_pins leaf_20/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_2/leaf_4_in]
  connect_bd_net -net leaf_4_in_3 [get_bd_pins leaf_4_in3] [get_bd_pins subtree_212_wrapper_1/leaf_4_in]
  connect_bd_net -net leaf_4_in_4 [get_bd_pins leaf_4_in] [get_bd_pins subtree_212_wrapper_0/leaf_4_in]
  connect_bd_net -net leaf_5_in_1 [get_bd_pins leaf_29/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_5_in]
  connect_bd_net -net leaf_5_in_2 [get_bd_pins leaf_21/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_2/leaf_5_in]
  connect_bd_net -net leaf_5_in_3 [get_bd_pins leaf_5_in3] [get_bd_pins subtree_212_wrapper_1/leaf_5_in]
  connect_bd_net -net leaf_5_in_4 [get_bd_pins leaf_5_in] [get_bd_pins subtree_212_wrapper_0/leaf_5_in]
  connect_bd_net -net leaf_6_in_1 [get_bd_pins leaf_30/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_6_in]
  connect_bd_net -net leaf_6_in_2 [get_bd_pins leaf_22/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_2/leaf_6_in]
  connect_bd_net -net leaf_6_in_3 [get_bd_pins leaf_6_in3] [get_bd_pins subtree_212_wrapper_1/leaf_6_in]
  connect_bd_net -net leaf_6_in_4 [get_bd_pins leaf_6_in] [get_bd_pins subtree_212_wrapper_0/leaf_6_in]
  connect_bd_net -net leaf_7_in_1 [get_bd_pins leaf_31/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_3/leaf_7_in]
  connect_bd_net -net leaf_7_in_2 [get_bd_pins leaf_23/dout_leaf_interface2bft] [get_bd_pins subtree_212_wrapper_2/leaf_7_in]
  connect_bd_net -net leaf_7_in_3 [get_bd_pins leaf_7_in3] [get_bd_pins subtree_212_wrapper_1/leaf_7_in]
  connect_bd_net -net leaf_7_in_4 [get_bd_pins leaf_7_in] [get_bd_pins subtree_212_wrapper_0/leaf_7_in]
  connect_bd_net -net leaf_interface_1_dout_leaf_interface2user [get_bd_pins InterfaceWrapper1_0/Output_1_V_V] [get_bd_pins axi_dma_0/s_axis_s2mm_tdata] [get_bd_pins dma_converter_0/dout]
  connect_bd_net -net leaf_interface_1_vld_interface2user [get_bd_pins InterfaceWrapper1_0/Output_1_V_V_ap_vld] [get_bd_pins axi_dma_0/s_axis_s2mm_tvalid] [get_bd_pins dma_converter_0/valid]
  connect_bd_net -net pi_cluster_0_0_l_bus_o [get_bd_pins pi_cluster_0_0/l_bus_o] [get_bd_pins pipe_ff_1_1/din]
  connect_bd_net -net pi_cluster_0_0_r_bus_o [get_bd_pins pi_cluster_0_0/r_bus_o] [get_bd_pins pipe_ff_1_3/din]
  connect_bd_net -net pipe_ff_1_0_dout [get_bd_pins pi_cluster_0_0/l_bus_i] [get_bd_pins pipe_ff_1_0/dout]
  connect_bd_net -net pipe_ff_1_10_dout [get_bd_pins pipe_ff_1_10/dout] [get_bd_pins t_cluster_0_1/r_bus_i]
  connect_bd_net -net pipe_ff_1_11_dout [get_bd_pins pipe_ff_1_11/dout] [get_bd_pins subtree_212_wrapper_3/bus_i]
  connect_bd_net -net pipe_ff_1_1_dout [get_bd_pins pipe_ff_1_1/dout] [get_bd_pins t_cluster_0_0/u_bus_i]
  connect_bd_net -net pipe_ff_1_2_dout [get_bd_pins pi_cluster_0_0/r_bus_i] [get_bd_pins pipe_ff_1_2/dout]
  connect_bd_net -net pipe_ff_1_3_dout [get_bd_pins pipe_ff_1_3/dout] [get_bd_pins t_cluster_0_1/u_bus_i]
  connect_bd_net -net pipe_ff_1_4_dout [get_bd_pins pipe_ff_1_4/dout] [get_bd_pins t_cluster_0_0/l_bus_i]
  connect_bd_net -net pipe_ff_1_5_dout [get_bd_pins pipe_ff_1_5/dout] [get_bd_pins subtree_212_wrapper_0/bus_i]
  connect_bd_net -net pipe_ff_1_6_dout [get_bd_pins pipe_ff_1_6/dout] [get_bd_pins t_cluster_0_0/r_bus_i]
  connect_bd_net -net pipe_ff_1_7_dout [get_bd_pins pipe_ff_1_7/dout] [get_bd_pins subtree_212_wrapper_1/bus_i]
  connect_bd_net -net pipe_ff_1_8_dout [get_bd_pins pipe_ff_1_8/dout] [get_bd_pins t_cluster_0_1/l_bus_i]
  connect_bd_net -net pipe_ff_1_9_dout [get_bd_pins pipe_ff_1_9/dout] [get_bd_pins subtree_212_wrapper_2/bus_i]
  connect_bd_net -net reset_bft2_1 [get_bd_pins reset_bft2] [get_bd_pins leaf_19/reset_bft] [get_bd_pins leaf_20/reset_bft] [get_bd_pins leaf_21/reset_bft] [get_bd_pins leaf_22/reset_bft] [get_bd_pins leaf_23/reset_bft]
  connect_bd_net -net reset_bft3_1 [get_bd_pins reset_bft3] [get_bd_pins leaf_24/reset_bft] [get_bd_pins leaf_25/reset_bft] [get_bd_pins leaf_26/reset_bft] [get_bd_pins leaf_27/reset_bft] [get_bd_pins leaf_28/reset_bft] [get_bd_pins leaf_29/reset_bft] [get_bd_pins leaf_30/reset_bft] [get_bd_pins leaf_31/reset_bft]
  connect_bd_net -net reset_bft_1 [get_bd_pins reset_bft] [get_bd_pins InterfaceWrapper1_0/reset_bft] [get_bd_pins InterfaceWrapper7_0/reset_bft]
  connect_bd_net -net rst_ps8_0_299M_peripheral_aresetn [get_bd_pins axi_resetn] [get_bd_pins axi2stream_v1_0_0/s00_axi_aresetn] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_smc_2/aresetn] [get_bd_pins ps8_0_axi_periph/ARESETN] [get_bd_pins ps8_0_axi_periph/M00_ARESETN] [get_bd_pins ps8_0_axi_periph/M01_ARESETN] [get_bd_pins ps8_0_axi_periph/S00_ARESETN] [get_bd_pins ps8_0_axi_periph/S01_ARESETN]
  connect_bd_net -net rst_ps8_0_99M2_peripheral_reset [get_bd_pins reset_bft1] [get_bd_pins AxiLite2Bft_v2_0_0/reset_bft]
  connect_bd_net -net rst_ps8_0_99M3_peripheral_reset [get_bd_pins reset1] [get_bd_pins pi_cluster_0_0/reset] [get_bd_pins pipe_ff_1_0/reset] [get_bd_pins pipe_ff_1_1/reset] [get_bd_pins pipe_ff_1_10/reset] [get_bd_pins pipe_ff_1_11/reset] [get_bd_pins pipe_ff_1_2/reset] [get_bd_pins pipe_ff_1_3/reset] [get_bd_pins pipe_ff_1_4/reset] [get_bd_pins pipe_ff_1_5/reset] [get_bd_pins pipe_ff_1_6/reset] [get_bd_pins pipe_ff_1_7/reset] [get_bd_pins pipe_ff_1_8/reset] [get_bd_pins pipe_ff_1_9/reset] [get_bd_pins subtree_212_wrapper_0/reset] [get_bd_pins subtree_212_wrapper_1/reset] [get_bd_pins subtree_212_wrapper_2/reset] [get_bd_pins subtree_212_wrapper_3/reset] [get_bd_pins t_cluster_0_0/reset] [get_bd_pins t_cluster_0_1/reset]
  connect_bd_net -net rst_ps8_0_99M_peripheral_aresetn [get_bd_pins AxiLite2Bft_v2_0_0/s00_axi_aresetn] [get_bd_pins ps8_0_axi_periph/M02_ARESETN] [get_bd_pins rst_ps8_0_99M/peripheral_aresetn]
  connect_bd_net -net rst_ps8_0_99M_peripheral_reset [get_bd_pins peripheral_reset] [get_bd_pins InterfaceWrapper1_0/reset] [get_bd_pins InterfaceWrapper7_0/reset] [get_bd_pins ap_start_source/reset] [get_bd_pins ap_start_top/reset] [get_bd_pins ap_start_top01/reset] [get_bd_pins ap_start_top02/reset] [get_bd_pins ap_start_top03/reset] [get_bd_pins ap_start_top11/reset] [get_bd_pins ap_start_top12/reset] [get_bd_pins ap_start_top13/reset] [get_bd_pins ap_start_top21/reset] [get_bd_pins ap_start_top22/reset] [get_bd_pins ap_start_top23/reset] [get_bd_pins ap_start_top3/reset] [get_bd_pins ap_start_top31/reset] [get_bd_pins ap_start_top32/reset] [get_bd_pins ap_start_top33/reset] [get_bd_pins dma_converter_0/reset] [get_bd_pins leaf_19/reset] [get_bd_pins leaf_20/reset] [get_bd_pins leaf_21/reset] [get_bd_pins leaf_22/reset] [get_bd_pins leaf_23/reset] [get_bd_pins leaf_24/reset] [get_bd_pins leaf_25/reset] [get_bd_pins leaf_26/reset] [get_bd_pins leaf_27/reset] [get_bd_pins leaf_28/reset] [get_bd_pins leaf_29/reset] [get_bd_pins leaf_30/reset] [get_bd_pins leaf_31/reset] [get_bd_pins rst_ps8_0_99M/peripheral_reset]
  connect_bd_net -net subtree_212_wrapper_0_bus_o [get_bd_pins pipe_ff_1_4/din] [get_bd_pins subtree_212_wrapper_0/bus_o]
  connect_bd_net -net subtree_212_wrapper_0_leaf_0_out [get_bd_pins AxiLite2Bft_v2_0_0/host_bft2interface] [get_bd_pins subtree_212_wrapper_0/leaf_0_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_1_out [get_bd_pins InterfaceWrapper1_0/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_0/leaf_1_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_2_out [get_bd_pins InterfaceWrapper7_0/din_leaf_bft2interface] [get_bd_pins subtree_212_wrapper_0/leaf_2_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_3_out [get_bd_pins leaf_3_out] [get_bd_pins subtree_212_wrapper_0/leaf_3_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_4_out [get_bd_pins leaf_4_out] [get_bd_pins subtree_212_wrapper_0/leaf_4_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_5_out [get_bd_pins leaf_5_out] [get_bd_pins subtree_212_wrapper_0/leaf_5_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_6_out [get_bd_pins leaf_6_out] [get_bd_pins subtree_212_wrapper_0/leaf_6_out]
  connect_bd_net -net subtree_212_wrapper_0_leaf_7_out [get_bd_pins leaf_7_out] [get_bd_pins subtree_212_wrapper_0/leaf_7_out]
  connect_bd_net -net subtree_212_wrapper_0_resend_0 [get_bd_pins AxiLite2Bft_v2_0_0/resend] [get_bd_pins subtree_212_wrapper_0/resend_0]
  connect_bd_net -net subtree_212_wrapper_0_resend_1 [get_bd_pins InterfaceWrapper1_0/resend] [get_bd_pins subtree_212_wrapper_0/resend_1]
  connect_bd_net -net subtree_212_wrapper_0_resend_2 [get_bd_pins InterfaceWrapper7_0/resend] [get_bd_pins subtree_212_wrapper_0/resend_2]
  connect_bd_net -net subtree_212_wrapper_0_resend_3 [get_bd_pins resend_3] [get_bd_pins subtree_212_wrapper_0/resend_3]
  connect_bd_net -net subtree_212_wrapper_0_resend_4 [get_bd_pins resend_4] [get_bd_pins subtree_212_wrapper_0/resend_4]
  connect_bd_net -net subtree_212_wrapper_0_resend_5 [get_bd_pins resend_5] [get_bd_pins subtree_212_wrapper_0/resend_5]
  connect_bd_net -net subtree_212_wrapper_0_resend_6 [get_bd_pins resend_6] [get_bd_pins subtree_212_wrapper_0/resend_6]
  connect_bd_net -net subtree_212_wrapper_0_resend_7 [get_bd_pins resend_7] [get_bd_pins subtree_212_wrapper_0/resend_7]
  connect_bd_net -net subtree_212_wrapper_2_leaf_2_out [get_bd_pins leaf_2_out] [get_bd_pins subtree_212_wrapper_2/leaf_2_out]
  connect_bd_net -net subtree_212_wrapper_2_resend_2 [get_bd_pins resend_2] [get_bd_pins subtree_212_wrapper_2/resend_2]
  connect_bd_net -net t_cluster_0_0_l_bus_o [get_bd_pins pipe_ff_1_5/din] [get_bd_pins t_cluster_0_0/l_bus_o]
  connect_bd_net -net t_cluster_0_0_r_bus_o [get_bd_pins pipe_ff_1_7/din] [get_bd_pins t_cluster_0_0/r_bus_o]
  connect_bd_net -net t_cluster_0_0_u_bus_o [get_bd_pins pipe_ff_1_0/din] [get_bd_pins t_cluster_0_0/u_bus_o]
  connect_bd_net -net t_cluster_0_1_l_bus_o [get_bd_pins pipe_ff_1_9/din] [get_bd_pins t_cluster_0_1/l_bus_o]
  connect_bd_net -net t_cluster_0_1_r_bus_o [get_bd_pins pipe_ff_1_11/din] [get_bd_pins t_cluster_0_1/r_bus_o]
  connect_bd_net -net t_cluster_0_1_u_bus_o [get_bd_pins pipe_ff_1_2/din] [get_bd_pins t_cluster_0_1/u_bus_o]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins pi_cluster_0_0/u_bus_i] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk1 [get_bd_pins s00_axi_aclk] [get_bd_pins AxiLite2Bft_v2_0_0/s00_axi_aclk] [get_bd_pins InterfaceWrapper1_0/clk_user] [get_bd_pins InterfaceWrapper7_0/clk_user] [get_bd_pins ap_start_source/clk] [get_bd_pins ap_start_top/clk] [get_bd_pins ap_start_top01/clk] [get_bd_pins ap_start_top02/clk] [get_bd_pins ap_start_top03/clk] [get_bd_pins ap_start_top11/clk] [get_bd_pins ap_start_top12/clk] [get_bd_pins ap_start_top13/clk] [get_bd_pins ap_start_top21/clk] [get_bd_pins ap_start_top22/clk] [get_bd_pins ap_start_top23/clk] [get_bd_pins ap_start_top3/clk] [get_bd_pins ap_start_top31/clk] [get_bd_pins ap_start_top32/clk] [get_bd_pins ap_start_top33/clk] [get_bd_pins axi2stream_v1_0_0/s00_axi_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_0/m_axi_sg_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_smc_2/aclk] [get_bd_pins dma_converter_0/clk] [get_bd_pins leaf_19/clk_user] [get_bd_pins leaf_20/clk_user] [get_bd_pins leaf_21/clk_user] [get_bd_pins leaf_22/clk_user] [get_bd_pins leaf_23/clk_user] [get_bd_pins leaf_24/clk_user] [get_bd_pins leaf_25/clk_user] [get_bd_pins leaf_26/clk_user] [get_bd_pins leaf_27/clk_user] [get_bd_pins leaf_28/clk_user] [get_bd_pins leaf_29/clk_user] [get_bd_pins leaf_30/clk_user] [get_bd_pins leaf_31/clk_user] [get_bd_pins ps8_0_axi_periph/ACLK] [get_bd_pins ps8_0_axi_periph/M00_ACLK] [get_bd_pins ps8_0_axi_periph/M01_ACLK] [get_bd_pins ps8_0_axi_periph/M02_ACLK] [get_bd_pins ps8_0_axi_periph/S00_ACLK] [get_bd_pins ps8_0_axi_periph/S01_ACLK] [get_bd_pins rst_ps8_0_99M/slowest_sync_clk]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk2 [get_bd_pins clk_bft] [get_bd_pins AxiLite2Bft_v2_0_0/clk_bft] [get_bd_pins InterfaceWrapper1_0/clk_bft] [get_bd_pins InterfaceWrapper7_0/clk_bft] [get_bd_pins leaf_19/clk_bft] [get_bd_pins leaf_20/clk_bft] [get_bd_pins leaf_21/clk_bft] [get_bd_pins leaf_22/clk_bft] [get_bd_pins leaf_23/clk_bft] [get_bd_pins leaf_24/clk_bft] [get_bd_pins leaf_25/clk_bft] [get_bd_pins leaf_26/clk_bft] [get_bd_pins leaf_27/clk_bft] [get_bd_pins leaf_28/clk_bft] [get_bd_pins leaf_29/clk_bft] [get_bd_pins leaf_30/clk_bft] [get_bd_pins leaf_31/clk_bft] [get_bd_pins pi_cluster_0_0/clk] [get_bd_pins pipe_ff_1_0/clk] [get_bd_pins pipe_ff_1_1/clk] [get_bd_pins pipe_ff_1_10/clk] [get_bd_pins pipe_ff_1_11/clk] [get_bd_pins pipe_ff_1_2/clk] [get_bd_pins pipe_ff_1_3/clk] [get_bd_pins pipe_ff_1_4/clk] [get_bd_pins pipe_ff_1_5/clk] [get_bd_pins pipe_ff_1_6/clk] [get_bd_pins pipe_ff_1_7/clk] [get_bd_pins pipe_ff_1_8/clk] [get_bd_pins pipe_ff_1_9/clk] [get_bd_pins subtree_212_wrapper_0/clk] [get_bd_pins subtree_212_wrapper_1/clk] [get_bd_pins subtree_212_wrapper_2/clk] [get_bd_pins subtree_212_wrapper_3/clk] [get_bd_pins t_cluster_0_0/clk] [get_bd_pins t_cluster_0_1/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports

  # Create instance: axi_leaf
  create_hier_cell_axi_leaf [current_bd_instance .] axi_leaf

  # Create instance: leaf_empty_3, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_3
  if { [catch {set leaf_empty_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_3 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_4, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_4
  if { [catch {set leaf_empty_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_4 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_5, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_5
  if { [catch {set leaf_empty_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_5 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_6, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_6
  if { [catch {set leaf_empty_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_6 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_7, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_7
  if { [catch {set leaf_empty_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_7 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_8, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_8
  if { [catch {set leaf_empty_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_8 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_9, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_9
  if { [catch {set leaf_empty_9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_9 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_10, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_10
  if { [catch {set leaf_empty_10 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_10 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_11, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_11
  if { [catch {set leaf_empty_11 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_11 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_12, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_12
  if { [catch {set leaf_empty_12 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_12 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_13, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_13
  if { [catch {set leaf_empty_13 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_13 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_14, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_14
  if { [catch {set leaf_empty_14 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_14 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_15, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_15
  if { [catch {set leaf_empty_15 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_15 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_16, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_16
  if { [catch {set leaf_empty_16 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_16 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_17, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_17
  if { [catch {set leaf_empty_17 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_17 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: leaf_empty_18, and set properties
  set block_name leaf_empty
  set block_cell_name leaf_empty_18
  if { [catch {set leaf_empty_18 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $leaf_empty_18 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: rst_ps8_0_299M, and set properties
  set rst_ps8_0_299M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_299M ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_ps8_0_299M

  # Create instance: rst_ps8_0_99M1, and set properties
  set rst_ps8_0_99M1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M1 ]

  # Create instance: rst_ps8_0_99M2, and set properties
  set rst_ps8_0_99M2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M2 ]

  # Create instance: rst_ps8_0_99M3, and set properties
  set rst_ps8_0_99M3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M3 ]

  # Create instance: rst_ps8_0_99M4, and set properties
  set rst_ps8_0_99M4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M4 ]

  # Create instance: rst_ps8_0_99M5, and set properties
  set rst_ps8_0_99M5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M5 ]

  # Create instance: rst_ps8_0_99M6, and set properties
  set rst_ps8_0_99M6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M6 ]

  # Create instance: rst_ps8_0_99M7, and set properties
  set rst_ps8_0_99M7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M7 ]

  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.2 zynq_ultra_ps_e_0 ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_3_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_18_DIRECTION {in} \
   CONFIG.PSU_MIO_18_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_18_SLEW {slow} \
   CONFIG.PSU_MIO_19_DIRECTION {out} \
   CONFIG.PSU_MIO_19_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_20_DIRECTION {out} \
   CONFIG.PSU_MIO_20_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_21_DIRECTION {in} \
   CONFIG.PSU_MIO_21_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_21_SLEW {slow} \
   CONFIG.PSU_MIO_22_DIRECTION {inout} \
   CONFIG.PSU_MIO_23_DIRECTION {inout} \
   CONFIG.PSU_MIO_24_DIRECTION {out} \
   CONFIG.PSU_MIO_24_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_25_DIRECTION {in} \
   CONFIG.PSU_MIO_25_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_25_SLEW {slow} \
   CONFIG.PSU_MIO_26_DIRECTION {inout} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_28_DIRECTION {in} \
   CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_28_SLEW {slow} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_30_DIRECTION {in} \
   CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_30_SLEW {slow} \
   CONFIG.PSU_MIO_31_DIRECTION {out} \
   CONFIG.PSU_MIO_31_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_32_DIRECTION {out} \
   CONFIG.PSU_MIO_32_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_33_DIRECTION {out} \
   CONFIG.PSU_MIO_33_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_34_DIRECTION {out} \
   CONFIG.PSU_MIO_34_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_35_DIRECTION {out} \
   CONFIG.PSU_MIO_35_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_36_DIRECTION {out} \
   CONFIG.PSU_MIO_36_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_37_DIRECTION {out} \
   CONFIG.PSU_MIO_37_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_38_DIRECTION {inout} \
   CONFIG.PSU_MIO_39_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_40_DIRECTION {inout} \
   CONFIG.PSU_MIO_41_DIRECTION {inout} \
   CONFIG.PSU_MIO_42_DIRECTION {inout} \
   CONFIG.PSU_MIO_43_DIRECTION {inout} \
   CONFIG.PSU_MIO_44_DIRECTION {in} \
   CONFIG.PSU_MIO_44_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_44_SLEW {slow} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_SLEW {slow} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_52_DIRECTION {in} \
   CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_52_SLEW {slow} \
   CONFIG.PSU_MIO_53_DIRECTION {in} \
   CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_53_SLEW {slow} \
   CONFIG.PSU_MIO_54_DIRECTION {inout} \
   CONFIG.PSU_MIO_55_DIRECTION {in} \
   CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_55_SLEW {slow} \
   CONFIG.PSU_MIO_56_DIRECTION {inout} \
   CONFIG.PSU_MIO_57_DIRECTION {inout} \
   CONFIG.PSU_MIO_58_DIRECTION {out} \
   CONFIG.PSU_MIO_58_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_59_DIRECTION {inout} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_60_DIRECTION {inout} \
   CONFIG.PSU_MIO_61_DIRECTION {inout} \
   CONFIG.PSU_MIO_62_DIRECTION {inout} \
   CONFIG.PSU_MIO_63_DIRECTION {inout} \
   CONFIG.PSU_MIO_64_DIRECTION {out} \
   CONFIG.PSU_MIO_64_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_65_DIRECTION {out} \
   CONFIG.PSU_MIO_65_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_66_DIRECTION {out} \
   CONFIG.PSU_MIO_66_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_67_DIRECTION {out} \
   CONFIG.PSU_MIO_67_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_68_DIRECTION {out} \
   CONFIG.PSU_MIO_68_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_69_DIRECTION {out} \
   CONFIG.PSU_MIO_69_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_6_DIRECTION {out} \
   CONFIG.PSU_MIO_6_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_70_DIRECTION {in} \
   CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_70_SLEW {slow} \
   CONFIG.PSU_MIO_71_DIRECTION {in} \
   CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_71_SLEW {slow} \
   CONFIG.PSU_MIO_72_DIRECTION {in} \
   CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_72_SLEW {slow} \
   CONFIG.PSU_MIO_73_DIRECTION {in} \
   CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_73_SLEW {slow} \
   CONFIG.PSU_MIO_74_DIRECTION {in} \
   CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_74_SLEW {slow} \
   CONFIG.PSU_MIO_75_DIRECTION {in} \
   CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_75_SLEW {slow} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {schmitt} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO0 MIO#I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#UART 1#UART 1#GPIO0 MIO#GPIO0 MIO#CAN 1#CAN 1#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#PCIE#PMU GPO 0#PMU GPO 1#PMU GPO 2#PMU GPO 3#PMU GPO 4#PMU GPO 5#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#gpio0[13]#scl_out#sda_out#scl_out#sda_out#rxd#txd#txd#rxd#gpio0[22]#gpio0[23]#phy_tx#phy_rx#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#reset_n#gpo[0]#gpo[1]#gpo[2]#gpo[3]#gpo[4]#gpo[5]#gpio1[38]#sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#gpio1[43]#sdio1_wp#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.560059} \
   CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__CAN1__PERIPHERAL__IO {MIO 24 .. 25} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.880000} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.280000} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.940000} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {64} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.997500} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.783036} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {14} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.970000} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.940000} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {499.950000} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.280000} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.950000} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.995000} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.950000} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.850000} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.987500} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.950000} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.481250} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {187.481250} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {188} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {187.481250} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {188} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.987500} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {45} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.481250} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.990000} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.975000} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.998000} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
   CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
   CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
   CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
   CONFIG.PSU__DDRC__CL {15} \
   CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
   CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
   CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
   CONFIG.PSU__DDRC__CWL {14} \
   CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
   CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
   CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
   CONFIG.PSU__DDRC__DEEP_PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
   CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
   CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
   CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
   CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
   CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
   CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
   CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
   CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
   CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
   CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
   CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
   CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
   CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
   CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
   CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
   CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
   CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
   CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {8 Bits} \
   CONFIG.PSU__DDRC__ECC {Disabled} \
   CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_SLOWBOOT {0} \
   CONFIG.PSU__DDRC__FGRM {1X} \
   CONFIG.PSU__DDRC__LP_ASR {manual normal} \
   CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
   CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
   CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
   CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
   CONFIG.PSU__DDRC__SB_TARGET {15-15-15} \
   CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
   CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
   CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
   CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
   CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
   CONFIG.PSU__DDRC__T_FAW {30.0} \
   CONFIG.PSU__DDRC__T_RAS_MIN {33} \
   CONFIG.PSU__DDRC__T_RC {47.06} \
   CONFIG.PSU__DDRC__T_RCD {15} \
   CONFIG.PSU__DDRC__T_RP {15} \
   CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
   CONFIG.PSU__DDRC__VREF {1} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
   CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {0} \
   CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
   CONFIG.PSU__DP__LANE_SEL {Single Lower} \
   CONFIG.PSU__DP__REF_CLK_FREQ {27} \
   CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \
   CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__ENET3__PTP__ENABLE {0} \
   CONFIG.PSU__ENET3__TSU__ENABLE {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.989998} \
   CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {99.989998} \
   CONFIG.PSU__FPD_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__FPGA_PL0_ENABLE {1} \
   CONFIG.PSU__FPGA_PL1_ENABLE {1} \
   CONFIG.PSU__GEM3_COHERENCY {0} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
   CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
   CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GT__LINK_SPEED {HBR} \
   CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
   CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.989998} \
   CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {99.989998} \
   CONFIG.PSU__IOU_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100.000000} \
   CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PCIE__BAR0_64BIT {0} \
   CONFIG.PSU__PCIE__BAR0_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR0_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR0_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR1_64BIT {0} \
   CONFIG.PSU__PCIE__BAR1_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR1_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR1_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR2_64BIT {0} \
   CONFIG.PSU__PCIE__BAR2_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR2_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR2_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR3_64BIT {0} \
   CONFIG.PSU__PCIE__BAR3_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR3_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR3_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR4_64BIT {0} \
   CONFIG.PSU__PCIE__BAR4_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR4_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR4_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR5_64BIT {0} \
   CONFIG.PSU__PCIE__BAR5_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR5_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR5_VAL {0x0} \
   CONFIG.PSU__PCIE__CLASS_CODE_BASE {0x06} \
   CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {0x0} \
   CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x4} \
   CONFIG.PSU__PCIE__CLASS_CODE_VALUE {0x60400} \
   CONFIG.PSU__PCIE__CRS_SW_VISIBILITY {1} \
   CONFIG.PSU__PCIE__DEVICE_ID {0xD021} \
   CONFIG.PSU__PCIE__DEVICE_PORT_TYPE {Root Port} \
   CONFIG.PSU__PCIE__EROM_ENABLE {0} \
   CONFIG.PSU__PCIE__EROM_VAL {0x0} \
   CONFIG.PSU__PCIE__LANE0__ENABLE {1} \
   CONFIG.PSU__PCIE__LANE0__IO {GT Lane0} \
   CONFIG.PSU__PCIE__LANE1__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE2__ENABLE {0} \
   CONFIG.PSU__PCIE__LANE3__ENABLE {0} \
   CONFIG.PSU__PCIE__LINK_SPEED {5.0 Gb/s} \
   CONFIG.PSU__PCIE__MAXIMUM_LINK_WIDTH {x1} \
   CONFIG.PSU__PCIE__MAX_PAYLOAD_SIZE {256 bytes} \
   CONFIG.PSU__PCIE__MSIX_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
   CONFIG.PSU__PCIE__MSIX_PBA_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_PBA_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_SIZE {0} \
   CONFIG.PSU__PCIE__MSI_64BIT_ADDR_CAPABLE {0} \
   CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_IO {MIO 31} \
   CONFIG.PSU__PCIE__REF_CLK_FREQ {100} \
   CONFIG.PSU__PCIE__REF_CLK_SEL {Ref Clk0} \
   CONFIG.PSU__PCIE__RESET__POLARITY {Active Low} \
   CONFIG.PSU__PCIE__REVISION_ID {0x0} \
   CONFIG.PSU__PCIE__SUBSYSTEM_ID {0x7} \
   CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {0x10EE} \
   CONFIG.PSU__PCIE__VENDOR_ID {0x10EE} \
   CONFIG.PSU__PL_CLK0_BUF {TRUE} \
   CONFIG.PSU__PL_CLK1_BUF {TRUE} \
   CONFIG.PSU__PMU_COHERENCY {0} \
   CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
   CONFIG.PSU__PMU__GPI0__ENABLE {0} \
   CONFIG.PSU__PMU__GPI1__ENABLE {0} \
   CONFIG.PSU__PMU__GPI2__ENABLE {0} \
   CONFIG.PSU__PMU__GPI3__ENABLE {0} \
   CONFIG.PSU__PMU__GPI4__ENABLE {0} \
   CONFIG.PSU__PMU__GPI5__ENABLE {0} \
   CONFIG.PSU__PMU__GPO0__ENABLE {1} \
   CONFIG.PSU__PMU__GPO0__IO {MIO 32} \
   CONFIG.PSU__PMU__GPO1__ENABLE {1} \
   CONFIG.PSU__PMU__GPO1__IO {MIO 33} \
   CONFIG.PSU__PMU__GPO2__ENABLE {1} \
   CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
   CONFIG.PSU__PMU__GPO2__POLARITY {high} \
   CONFIG.PSU__PMU__GPO3__ENABLE {1} \
   CONFIG.PSU__PMU__GPO3__IO {MIO 35} \
   CONFIG.PSU__PMU__GPO3__POLARITY {low} \
   CONFIG.PSU__PMU__GPO4__ENABLE {1} \
   CONFIG.PSU__PMU__GPO4__IO {MIO 36} \
   CONFIG.PSU__PMU__GPO4__POLARITY {low} \
   CONFIG.PSU__PMU__GPO5__ENABLE {1} \
   CONFIG.PSU__PMU__GPO5__IO {MIO 37} \
   CONFIG.PSU__PMU__GPO5__POLARITY {low} \
   CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
   CONFIG.PSU__PRESET_APPLIED {1} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;1|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;0|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;1|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|FPD;RCPU_GIC;F9000000;F900FFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;1|FPD;PCIE_LOW;E0000000;EFFFFFFF;1|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;1|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;1|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;1|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;1|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_GPV;FD700000;FD7FFFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;0|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|FPD;CCI_GPV;FD6E0000;FD6EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;1|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9000000;F907FFFF;1} \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.330} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
   CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SATA__LANE0__ENABLE {0} \
   CONFIG.PSU__SATA__LANE1__ENABLE {1} \
   CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
   CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
   CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP4__DATA_WIDTH {128} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
   CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
   CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
   CONFIG.PSU__UART1__BAUD_RATE {115200} \
   CONFIG.PSU__UART1__MODEM__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 20 .. 21} \
   CONFIG.PSU__USB0_COHERENCY {0} \
   CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
   CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
   CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.PSU__USE__M_AXI_GP0 {1} \
   CONFIG.PSU__USE__M_AXI_GP1 {1} \
   CONFIG.PSU__USE__M_AXI_GP2 {0} \
   CONFIG.PSU__USE__S_AXI_ACP {0} \
   CONFIG.PSU__USE__S_AXI_GP2 {0} \
   CONFIG.PSU__USE__S_AXI_GP3 {0} \
   CONFIG.PSU__USE__S_AXI_GP4 {1} \
   CONFIG.SUBPRESET1 {Custom} \
 ] $zynq_ultra_ps_e_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_smc_2_M00_AXI [get_bd_intf_pins axi_leaf/M00_AXI1] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins axi_leaf/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM1_FPD [get_bd_intf_pins axi_leaf/S01_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM1_FPD]

  # Create port connections
  connect_bd_net -net ap_start_0_dout [get_bd_pins axi_leaf/dout] [get_bd_pins leaf_empty_3/ap_start] [get_bd_pins leaf_empty_4/ap_start] [get_bd_pins leaf_empty_5/ap_start] [get_bd_pins leaf_empty_6/ap_start] [get_bd_pins leaf_empty_7/ap_start]
  connect_bd_net -net ap_start_1_dout [get_bd_pins axi_leaf/dout1] [get_bd_pins leaf_empty_10/ap_start] [get_bd_pins leaf_empty_11/ap_start] [get_bd_pins leaf_empty_12/ap_start] [get_bd_pins leaf_empty_13/ap_start] [get_bd_pins leaf_empty_14/ap_start] [get_bd_pins leaf_empty_15/ap_start] [get_bd_pins leaf_empty_8/ap_start] [get_bd_pins leaf_empty_9/ap_start]
  connect_bd_net -net ap_start_2_dout [get_bd_pins axi_leaf/dout2] [get_bd_pins leaf_empty_16/ap_start] [get_bd_pins leaf_empty_17/ap_start] [get_bd_pins leaf_empty_18/ap_start]
  connect_bd_net -net axi_leaf_leaf_0_out [get_bd_pins axi_leaf/leaf_0_out] [get_bd_pins leaf_empty_16/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_0_out2 [get_bd_pins axi_leaf/leaf_0_out2] [get_bd_pins leaf_empty_8/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_1_out [get_bd_pins axi_leaf/leaf_1_out] [get_bd_pins leaf_empty_17/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_1_out2 [get_bd_pins axi_leaf/leaf_1_out2] [get_bd_pins leaf_empty_9/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_2_out [get_bd_pins axi_leaf/leaf_2_out] [get_bd_pins leaf_empty_18/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_2_out3 [get_bd_pins axi_leaf/leaf_2_out3] [get_bd_pins leaf_empty_10/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_3_out [get_bd_pins axi_leaf/leaf_3_out] [get_bd_pins leaf_empty_3/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_3_out3 [get_bd_pins axi_leaf/leaf_3_out3] [get_bd_pins leaf_empty_11/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_4_out [get_bd_pins axi_leaf/leaf_4_out] [get_bd_pins leaf_empty_4/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_4_out3 [get_bd_pins axi_leaf/leaf_4_out3] [get_bd_pins leaf_empty_12/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_5_out [get_bd_pins axi_leaf/leaf_5_out] [get_bd_pins leaf_empty_5/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_5_out3 [get_bd_pins axi_leaf/leaf_5_out3] [get_bd_pins leaf_empty_13/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_6_out [get_bd_pins axi_leaf/leaf_6_out] [get_bd_pins leaf_empty_6/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_6_out3 [get_bd_pins axi_leaf/leaf_6_out3] [get_bd_pins leaf_empty_14/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_7_out [get_bd_pins axi_leaf/leaf_7_out] [get_bd_pins leaf_empty_7/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_leaf_7_out3 [get_bd_pins axi_leaf/leaf_7_out3] [get_bd_pins leaf_empty_15/din_leaf_bft2interface]
  connect_bd_net -net axi_leaf_resend_0 [get_bd_pins axi_leaf/resend_0] [get_bd_pins leaf_empty_16/resend]
  connect_bd_net -net axi_leaf_resend_1 [get_bd_pins axi_leaf/resend_1] [get_bd_pins leaf_empty_17/resend]
  connect_bd_net -net axi_leaf_resend_2 [get_bd_pins axi_leaf/resend_2] [get_bd_pins leaf_empty_18/resend]
  connect_bd_net -net axi_leaf_resend_3 [get_bd_pins axi_leaf/resend_3] [get_bd_pins leaf_empty_3/resend]
  connect_bd_net -net axi_leaf_resend_4 [get_bd_pins axi_leaf/resend_4] [get_bd_pins leaf_empty_4/resend]
  connect_bd_net -net axi_leaf_resend_5 [get_bd_pins axi_leaf/resend_5] [get_bd_pins leaf_empty_5/resend]
  connect_bd_net -net axi_leaf_resend_6 [get_bd_pins axi_leaf/resend_6] [get_bd_pins leaf_empty_6/resend]
  connect_bd_net -net axi_leaf_resend_7 [get_bd_pins axi_leaf/resend_7] [get_bd_pins leaf_empty_7/resend]
  connect_bd_net -net axi_leaf_resend_22 [get_bd_pins axi_leaf/resend_22] [get_bd_pins leaf_empty_8/resend]
  connect_bd_net -net axi_leaf_resend_23 [get_bd_pins axi_leaf/resend_23] [get_bd_pins leaf_empty_9/resend]
  connect_bd_net -net axi_leaf_resend_24 [get_bd_pins axi_leaf/resend_24] [get_bd_pins leaf_empty_10/resend]
  connect_bd_net -net axi_leaf_resend_25 [get_bd_pins axi_leaf/resend_25] [get_bd_pins leaf_empty_11/resend]
  connect_bd_net -net axi_leaf_resend_26 [get_bd_pins axi_leaf/resend_26] [get_bd_pins leaf_empty_12/resend]
  connect_bd_net -net axi_leaf_resend_27 [get_bd_pins axi_leaf/resend_27] [get_bd_pins leaf_empty_15/resend]
  connect_bd_net -net axi_leaf_resend_28 [get_bd_pins axi_leaf/resend_28] [get_bd_pins leaf_empty_14/resend]
  connect_bd_net -net axi_leaf_resend_29 [get_bd_pins axi_leaf/resend_29] [get_bd_pins leaf_empty_13/resend]
  connect_bd_net -net inv_0_Res [get_bd_pins axi_leaf/peripheral_reset] [get_bd_pins leaf_empty_10/reset] [get_bd_pins leaf_empty_11/reset] [get_bd_pins leaf_empty_12/reset] [get_bd_pins leaf_empty_13/reset] [get_bd_pins leaf_empty_14/reset] [get_bd_pins leaf_empty_15/reset] [get_bd_pins leaf_empty_16/reset] [get_bd_pins leaf_empty_17/reset] [get_bd_pins leaf_empty_18/reset] [get_bd_pins leaf_empty_3/reset] [get_bd_pins leaf_empty_4/reset] [get_bd_pins leaf_empty_5/reset] [get_bd_pins leaf_empty_6/reset] [get_bd_pins leaf_empty_7/reset] [get_bd_pins leaf_empty_8/reset] [get_bd_pins leaf_empty_9/reset]
  connect_bd_net -net leaf_empty_10_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_2_in3] [get_bd_pins leaf_empty_10/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_11_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_3_in3] [get_bd_pins leaf_empty_11/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_12_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_4_in3] [get_bd_pins leaf_empty_12/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_13_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_5_in3] [get_bd_pins leaf_empty_13/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_14_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_6_in3] [get_bd_pins leaf_empty_14/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_15_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_7_in3] [get_bd_pins leaf_empty_15/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_16_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_0_in] [get_bd_pins leaf_empty_16/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_17_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_1_in] [get_bd_pins leaf_empty_17/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_18_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_2_in] [get_bd_pins leaf_empty_18/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_3_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_3_in] [get_bd_pins leaf_empty_3/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_4_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_4_in] [get_bd_pins leaf_empty_4/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_5_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_5_in] [get_bd_pins leaf_empty_5/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_6_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_6_in] [get_bd_pins leaf_empty_6/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_7_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_7_in] [get_bd_pins leaf_empty_7/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_8_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_0_in2] [get_bd_pins leaf_empty_8/dout_leaf_interface2bft]
  connect_bd_net -net leaf_empty_9_dout_leaf_interface2bft [get_bd_pins axi_leaf/leaf_1_in2] [get_bd_pins leaf_empty_9/dout_leaf_interface2bft]
  connect_bd_net -net rst_ps8_0_299M_peripheral_aresetn [get_bd_pins axi_leaf/axi_resetn] [get_bd_pins rst_ps8_0_299M/peripheral_aresetn]
  connect_bd_net -net rst_ps8_0_99M1_peripheral_reset [get_bd_pins rst_ps8_0_99M1/peripheral_reset] [get_bd_pins rst_ps8_0_99M2/ext_reset_in] [get_bd_pins rst_ps8_0_99M3/ext_reset_in] [get_bd_pins rst_ps8_0_99M4/ext_reset_in] [get_bd_pins rst_ps8_0_99M5/ext_reset_in] [get_bd_pins rst_ps8_0_99M6/ext_reset_in] [get_bd_pins rst_ps8_0_99M7/ext_reset_in]
  connect_bd_net -net rst_ps8_0_99M2_peripheral_reset [get_bd_pins axi_leaf/reset_bft1] [get_bd_pins rst_ps8_0_99M2/peripheral_reset]
  connect_bd_net -net rst_ps8_0_99M3_peripheral_reset [get_bd_pins axi_leaf/reset1] [get_bd_pins rst_ps8_0_99M3/peripheral_reset]
  connect_bd_net -net rst_ps8_0_99M4_peripheral_reset [get_bd_pins axi_leaf/reset_bft] [get_bd_pins leaf_empty_3/reset_bft] [get_bd_pins leaf_empty_4/reset_bft] [get_bd_pins leaf_empty_5/reset_bft] [get_bd_pins leaf_empty_6/reset_bft] [get_bd_pins leaf_empty_7/reset_bft] [get_bd_pins rst_ps8_0_99M4/peripheral_reset]
  connect_bd_net -net rst_ps8_0_99M5_peripheral_reset [get_bd_pins leaf_empty_10/reset_bft] [get_bd_pins leaf_empty_11/reset_bft] [get_bd_pins leaf_empty_12/reset_bft] [get_bd_pins leaf_empty_13/reset_bft] [get_bd_pins leaf_empty_14/reset_bft] [get_bd_pins leaf_empty_15/reset_bft] [get_bd_pins leaf_empty_8/reset_bft] [get_bd_pins leaf_empty_9/reset_bft] [get_bd_pins rst_ps8_0_99M5/peripheral_reset]
  connect_bd_net -net rst_ps8_0_99M6_peripheral_reset [get_bd_pins axi_leaf/reset_bft2] [get_bd_pins leaf_empty_16/reset_bft] [get_bd_pins leaf_empty_17/reset_bft] [get_bd_pins leaf_empty_18/reset_bft] [get_bd_pins rst_ps8_0_99M6/peripheral_reset]
  connect_bd_net -net rst_ps8_0_99M7_peripheral_reset [get_bd_pins axi_leaf/reset_bft3] [get_bd_pins rst_ps8_0_99M7/peripheral_reset]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk1 [get_bd_pins axi_leaf/s00_axi_aclk] [get_bd_pins leaf_empty_10/clk_user] [get_bd_pins leaf_empty_11/clk_user] [get_bd_pins leaf_empty_12/clk_user] [get_bd_pins leaf_empty_13/clk_user] [get_bd_pins leaf_empty_14/clk_user] [get_bd_pins leaf_empty_15/clk_user] [get_bd_pins leaf_empty_16/clk_user] [get_bd_pins leaf_empty_17/clk_user] [get_bd_pins leaf_empty_18/clk_user] [get_bd_pins leaf_empty_3/clk_user] [get_bd_pins leaf_empty_4/clk_user] [get_bd_pins leaf_empty_5/clk_user] [get_bd_pins leaf_empty_6/clk_user] [get_bd_pins leaf_empty_7/clk_user] [get_bd_pins leaf_empty_8/clk_user] [get_bd_pins leaf_empty_9/clk_user] [get_bd_pins rst_ps8_0_299M/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm1_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins zynq_ultra_ps_e_0/saxihp2_fpd_aclk]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk2 [get_bd_pins axi_leaf/clk_bft] [get_bd_pins leaf_empty_10/clk_bft] [get_bd_pins leaf_empty_11/clk_bft] [get_bd_pins leaf_empty_12/clk_bft] [get_bd_pins leaf_empty_13/clk_bft] [get_bd_pins leaf_empty_14/clk_bft] [get_bd_pins leaf_empty_15/clk_bft] [get_bd_pins leaf_empty_16/clk_bft] [get_bd_pins leaf_empty_17/clk_bft] [get_bd_pins leaf_empty_18/clk_bft] [get_bd_pins leaf_empty_3/clk_bft] [get_bd_pins leaf_empty_4/clk_bft] [get_bd_pins leaf_empty_5/clk_bft] [get_bd_pins leaf_empty_6/clk_bft] [get_bd_pins leaf_empty_7/clk_bft] [get_bd_pins leaf_empty_8/clk_bft] [get_bd_pins leaf_empty_9/clk_bft] [get_bd_pins rst_ps8_0_99M1/slowest_sync_clk] [get_bd_pins rst_ps8_0_99M2/slowest_sync_clk] [get_bd_pins rst_ps8_0_99M3/slowest_sync_clk] [get_bd_pins rst_ps8_0_99M4/slowest_sync_clk] [get_bd_pins rst_ps8_0_99M5/slowest_sync_clk] [get_bd_pins rst_ps8_0_99M6/slowest_sync_clk] [get_bd_pins rst_ps8_0_99M7/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk1]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins axi_leaf/ext_reset_in] [get_bd_pins rst_ps8_0_299M/ext_reset_in] [get_bd_pins rst_ps8_0_99M1/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  create_bd_addr_seg -range 0x00001000 -offset 0xA0000000 [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_leaf/AxiLite2Bft_v2_0_0/s00_axi/reg0] SEG_AxiLite2Bft_v2_0_0_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0xA0002000 [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_leaf/axi2stream_v1_0_0/s00_axi/reg0] SEG_axi2stream_v1_0_0_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0xA0001000 [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_leaf/axi_dma_0/S_AXI_LITE/Reg] SEG_axi_dma_0_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_SG] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP2_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP2_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_DDR_LOW] SEG_zynq_ultra_ps_e_0_HP2_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_SG] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM1
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM1
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM1
  create_bd_addr_seg -range 0x10000000 -offset 0xE0000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_SG] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_PCIE_LOW] SEG_zynq_ultra_ps_e_0_HP2_PCIE_LOW
  create_bd_addr_seg -range 0x10000000 -offset 0xE0000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_PCIE_LOW] SEG_zynq_ultra_ps_e_0_HP2_PCIE_LOW
  create_bd_addr_seg -range 0x10000000 -offset 0xE0000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_PCIE_LOW] SEG_zynq_ultra_ps_e_0_HP2_PCIE_LOW
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_SG] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] SEG_zynq_ultra_ps_e_0_HP2_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] SEG_zynq_ultra_ps_e_0_HP2_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_QSPI] SEG_zynq_ultra_ps_e_0_HP2_QSPI

  # Exclude Address Segments
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs axi_leaf/axi_dma_0/Data_MM2S/SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM]

  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs axi_leaf/axi_dma_0/Data_S2MM/SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM]

  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces axi_leaf/axi_dma_0/Data_SG] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM
  exclude_bd_addr_seg [get_bd_addr_segs axi_leaf/axi_dma_0/Data_SG/SEG_zynq_ultra_ps_e_0_HP2_LPS_OCM]



  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


