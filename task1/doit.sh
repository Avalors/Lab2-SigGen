#!/bin/sh

#vbuddy connection established
if ! ~/Documents/iac/lab0-devtools/tools/attach_usb.sh; then
    echo "Error: Failed to attach USB with vbuddy."
    exit 1
fi

#cleanup
rm -rf obj_dir
rm -f sinegen.vcd

#verilator that generates mk file and Vcounter.cpp file 
verilator -Wall --cc --trace sinegen.sv -exe sinegen_tb.cpp

#compiles mk file and cpp file into executable model of digital design
make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

#run executable file
obj_dir/Vsinegen