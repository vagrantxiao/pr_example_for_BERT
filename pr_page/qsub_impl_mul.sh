#!/bin/bash -e
source $1 
vivado -mode batch -source impl_page_mul.tcl

