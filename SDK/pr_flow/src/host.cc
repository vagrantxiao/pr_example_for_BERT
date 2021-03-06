/*
 * Program:

 *   This program is a C++ driver for using one DMA in ZCU102 board.
 *
 * History:
 *   2020/5/14     Yuanlong Xiao   First Release
*/

#include "xparameters.h"	/* SDK generated parameters */

#include "stream.h"
#include "typedefs.h"
#include "config.h"
#include "sleep.h"
#include "stdio.h"
#define SLV_REG6 XPAR_AXI_LEAF_AXILITE2BFT_V2_0_0_BASEADDR+24

int main(void)
{
	unsigned int data1, data2;

	init_regs();
	xil_printf("BFT initialization DONE\n");
	Xil_Out32(SLV_REG6, 1);
	stream_inst stream(0, 0);
	for(int i=0; i<100; i++){
		stream.stream1_write(i);
		printf("write 1\n");
		stream.stream2_write(i+1);
		printf("write 2\n");
		while(stream.stream1_read(&data1) == 0);
		printf("%d op %d = %d\n", i, i+1,  data1);
	}


	printf("DONE\n");
	return XST_SUCCESS;
}


