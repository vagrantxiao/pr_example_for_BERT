# pr_example_for_BERT
## Short Description
This is an example for PRFlow partial reconfiguration. 
./overlay/overlay.dcp is the static DCP file, and the ./overlay/main.bit is the static bitstream.
Two versions of partial bitstreams will be generated. The only difference is the files under ./pr_page/riscv_add_dat and ./pr_page/riscv_mul_dat.
The two picorv_mem.v point to different instruction memories (firmware0-4.hex).

 

