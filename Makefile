VIVADO_PATH=/opt/Xilinx/SDx/2018.2/settings64.sh

all:
	echo "Hello"

add: pr_page/add.bit 
	cd pr_page && ./qsub_download_add.sh $(VIVADO_PATH)

mul: pr_page/mul.bit 
	cd pr_page && ./qsub_download_mul.sh $(VIVADO_PATH)

pr_page/add.bit: pr_page/page_add_netlist.dcp
	cd pr_page && ./qsub_impl_add.sh $(VIVADO_PATH)

pr_page/page_add_netlist.dcp:
	cd pr_page && ./qsub_syn_add.sh $(VIVADO_PATH)

pr_page/mul.bit: pr_page/page_mul_netlist.dcp
	cd pr_page && ./qsub_impl_mul.sh $(VIVADO_PATH)

pr_page/page_mul_netlist.dcp:
	cd pr_page && ./qsub_syn_mul.sh $(VIVADO_PATH)



clean:
	rm -rf ./pr_page/*.dcp ./pr_page/*.html ./pr_page/*.bit
	rm -rf ./pr_page/hd* ./pr_page/*.xml ./pr_page/*.bit
	rm -rf ./pr_page/*.log ./pr_page/*.rpt ./pr_page/*.jou
	rm -rf ./pr_page/.Xil ./pr_page/*.rpt ./pr_page/*.jou


