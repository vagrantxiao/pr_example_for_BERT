
#include "typedefs.h"
#include "firmware.h"




// filter hidden pixels
void zculling_bot (
		hls::stream<ap_uint<32> > & Input_1,
		hls::stream<ap_uint<32> > & Input_2,
		hls::stream<ap_uint<32> > & Output_1
	  )
{
	unsigned out = 0;
	unsigned in1 = 0;
	unsigned in2 = 0;


	in1 = Input_1.read();
	in2 = Input_2.read();
	out = in1 * in2;
	Output_1.write(out);
}
