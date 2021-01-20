ifndef XILINX_VIVADO
    XILINX_VIVADO=/opt/Xilinx/Vivado/2018.3
endif


VIVADO_PATH=$(XILINX_VIVADO)/settings64.sh

all:
	echo "make add: risc-v with addition functionality"
	echo "make mul: risc-v with multiplication functionality"

add: pr_page/add.bit 
	cd pr_page && ./qsub_download_add.sh $(VIVADO_PATH)

mul: pr_page/mul.bit 
	cd pr_page && ./qsub_download_mul.sh $(VIVADO_PATH)

pr_page/add.bit: pr_page/page_add_netlist.dcp
	cd pr_page && ./qsub_impl_add.sh $(VIVADO_PATH)

pr_page/page_add_netlist.dcp:
	cp ./pr_page/riscv_add_dat/* ./pr_page
	cd pr_page && ./qsub_syn_add.sh $(VIVADO_PATH)

pr_page/mul.bit: pr_page/page_mul_netlist.dcp
	cd pr_page && ./qsub_impl_mul.sh $(VIVADO_PATH)

pr_page/page_mul_netlist.dcp:
	cp ./pr_page/riscv_mul_dat/* ./pr_page
	cd pr_page && ./qsub_syn_mul.sh $(VIVADO_PATH)



clean:
	mv ./pr_page/page_add_netlist.dcp ./pr_page/page_add_netlist.dcpx
	mv ./pr_page/page_mul_netlist.dcp ./pr_page/page_mul_netlist.dcpx
	rm -rf ./pr_page/*.dcp ./pr_page/*.html ./pr_page/*.bit
	rm -rf ./pr_page/hd* ./pr_page/*.xml ./pr_page/*.bit
	rm -rf ./pr_page/*.log ./pr_page/*.rpt ./pr_page/*.jou
	rm -rf ./pr_page/.Xil ./pr_page/*.rpt ./pr_page/*.jou
	mv ./pr_page/page_add_netlist.dcpx ./pr_page/page_add_netlist.dcp
	mv ./pr_page/page_mul_netlist.dcpx ./pr_page/page_mul_netlist.dcp


clean_all:
	rm -rf ./pr_page/*.dcp ./pr_page/*.html ./pr_page/*.bit
	rm -rf ./pr_page/hd* ./pr_page/*.xml ./pr_page/*.bit
	rm -rf ./pr_page/*.log ./pr_page/*.rpt ./pr_page/*.jou
	rm -rf ./pr_page/.Xil ./pr_page/*.rpt ./pr_page/*.jou
