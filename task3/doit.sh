#!/bin/sh

#vbuddy connection established
if ! ~/Documents/iac/lab0-devtools/tools/attach_usb.sh; then
    echo "Error: Failed to attach USB with vbuddy."
    exit 1
fi

#cleanup
rm -rf obj_dir
rm -f sigdelay.vcd

#verilator that generates mk file and Vcounter.cpp file 
verilator -Wall --cc --trace sigdelay.sv -exe sigdelay_tb.cpp

#compiles mk file and cpp file into executable model of digital design
make -j -C obj_dir/ -f Vsigdelay.mk Vsigdelay

#run executable file
obj_dir/Vsigdelay