/*
 * Program:

 *   This program is a C++ driver for using one DMA in ZCU102 board.
 *
 * History:
 *   2020/5/14     Yuanlong Xiao   First Release
*/

#include "xparameters.h"	/* SDK generated parameters */

#include "typedefs.h"
#include "config.h"
#include "sleep.h"

#include "stdio.h"
#define SLV_REG6 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+24

int main(void)
{
	//unsigned int data1, data2;

	init_regs();
	//xil_printf("BFT initialization DONE\n");
	//Xil_Out32(SLV_REG6, 1);


	printf("DONE\n");
	return XST_SUCCESS;
}

