// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// A simple Sieve of Eratosthenes

#include "firmware.h"

#define STREAMOUT1  0x10000008
#define STREAMOUT2  0x10000010
#define STREAMOUT3  0x10000018
#define STREAMOUT4  0x10000020
#define STREAMIN1   0x10000004
#define STREAMIN2   0x1000000c
#define STREAMIN3   0x10000014
#define STREAMIN4   0x1000001c

int main(void)
{
  char const *s = "Hello world!\n";
  print_str(s);
  int i = 0;
  hls::stream<ap_uint<32> > Input_1(STREAMIN1);
  hls::stream<ap_uint<32> > Input_2(STREAMIN2);
  hls::stream<ap_uint<32> > Output_1(STREAMOUT1);
  while(1){
    zculling_bot(Input_1,Input_2,Output_1);
  }
  //stream operator instance;
  return 0;

}  
