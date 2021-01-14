#include "xparameters.h"
//#include "xdebug.h"
#include "xil_io.h"
#include "sleep.h"
//width of a packet is 49 bits
//bft2arm_packet = {1'b1, SLV_REG1[15:0], SLV_REG0[31:0]}
//arm2bft_packet = {SLV_REG5[16:0], SLV_REG4[31:0]}
//input fifo empty = SLV_REG3[1]
//output fifo full = SLV_REG3[0]
//input fifo rd_en = SLV_REG7[1]
#define SLV_REG0 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+0
#define SLV_REG1 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+4
#define SLV_REG2 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+8
#define SLV_REG3 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+12
#define SLV_REG4 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+16
#define SLV_REG5 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+20
#define SLV_REG6 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+24
#define SLV_REG7 XPAR_AXILITE2BFT_V2_0_0_BASEADDR+28


#define WRITE_OP 0
#define READ_OP 1
#define CHECK_ACK 2
void read_from_fifo(int * ctrl_reg)
{
   int rev_0, rev_1;

    //check if the input fifo is empty
    while((Xil_In32(SLV_REG3)>>1)&&1);

    //toggle the rd_en bits to start one reading
   *ctrl_reg = (*ctrl_reg) ^ 0x00000002;
    //input fifo rd_en = SLV_REG7[1]
    Xil_Out32(SLV_REG7, *ctrl_reg);

    //bft2arm_packet = {1'b1, SLV_REG1[15:0], SLV_REG0[31:0]}
    rev_0 = Xil_In32(SLV_REG0);
    rev_1 = Xil_In32(SLV_REG1);

   xil_printf( "= %d \n", rev_0);

}


void write_to_fifo(int high_32_bits, int low_32_bits, int * ctrl_reg)
{
    //arm2bft_packet = {SLV_REG5[16:0], SLV_REG4[31:0]}
    Xil_Out32(SLV_REG5, high_32_bits);
    Xil_Out32(SLV_REG4, low_32_bits);
    *ctrl_reg = (*ctrl_reg) ^ 0x00000001;
    Xil_Out32(SLV_REG7, *ctrl_reg);
}


void init_regs()
{
   int i = 0;
   static int ctrl_reg = 0;

  for (i=4; i<8; i++) {Xil_Out32(SLV_REG0+i*4, 0x00000000);}

  //DEBUG.Output_2->add1.Input_2
    write_to_fifo(0x1000, 0xa2980fe0, &ctrl_reg);
    write_to_fifo(0x2880, 0x31500000, &ctrl_reg);
  //add1.Output_1->DEBUG.Input_1
    write_to_fifo(0x2800, 0x91100fe0, &ctrl_reg);
    write_to_fifo(0x1080, 0x22c80000, &ctrl_reg);
  //DEBUG.Output_1->add1.Input_1
    write_to_fifo(0x1000, 0x92900fe0, &ctrl_reg);
    write_to_fifo(0x2880, 0x21480000, &ctrl_reg);
  //packet anchor
    Xil_Out32(SLV_REG6, 1);
    sleep(1);

    for(i=0; i<60; i++){
		xil_printf("%d op ", i);
		write_to_fifo(0x4900+i, i, &ctrl_reg);
		xil_printf("%d ", i+1);
		write_to_fifo(0x4980+i, i+1, &ctrl_reg);
		read_from_fifo(&ctrl_reg);
    }
}