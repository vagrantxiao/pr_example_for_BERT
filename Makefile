

all:
	echo "Hello"

add: pr_page/add.bit 
	cd pr_page && ./qsub_download_add.sh

mul: pr_page/mul.bit 
	cd pr_page && ./qsub_download_mul.sh

pr_page/add.bit: pr_page/page_add_netlist.dcp
	cd pr_page && ./qsub_impl_add.sh

pr_page/page_add_netlist.dcp:
	cd pr_page && ./qsub_syn_add.sh

pr_page/mul.bit: pr_page/page_mul_netlist.dcp
	cd pr_page && ./qsub_impl_mul.sh

pr_page/page_mul_netlist.dcp:
	cd pr_page && ./qsub_syn_mul.sh


clean:
	rm -rf ./pr_page/*.dcp ./pr_page/*.html ./pr_page/*.bit
	rm -rf ./pr_page/hd* ./pr_page/*.xml ./pr_page/*.bit
	rm -rf ./pr_page/*.log ./pr_page/*.rpt ./pr_page/*.jou


