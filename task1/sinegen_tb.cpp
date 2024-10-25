#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    Vsinegen* top = new Vsinegen; //instantiates device under test

    Verilated::traceEverOn(true);

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp,99);
    tfp->open("sinegen.vcd");


    //init vbuddy
    if(vbdOpen() != 1) return(-1);
    vbdHeader("Lab-2:Sine generator");

    //initialize simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 1;
    top->incr = 1;


    for(i = 0; i < 1000000; i++){ //number of simulation cycles increased

        //dumps variables into VCD file
        for(clk = 0; clk < 2; clk++){
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval();
        }

        vbdPlot(int(top->dout),0,255);
        vbdCycle(i);

        top->rst = (i<2);
        top->en = vbdFlag();
        top->incr = vbdValue();
        if(Verilated::gotFinish() || (vbdGetkey() == 'q')) exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}