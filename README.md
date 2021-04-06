# ISA15_Lab4

The aim of this fourth laboratory is to verify different components resorting to the 'Universal Verification Methodology' (UVM).

UVM is a free framework written in SystemVerilog used for the hardware verification, useful for automating the comparison between the DUT and the reference (golden) model.

# Project organization:

The project is organized as follow:

- Assigned_material: it containes the assignement and the zip file with the original SV  models;

- Adder: it is used for the execution of the first task, where we are asked to simulate and test a simple adder;

- MBE_multiplier: for the second point in which we have to verify the behaviour of a MBE-Dadda tree multiplier;

- FP_multiplier: it containes all the files used for the simulation of the floating point multiplier of the Lab2;

- FP_multiplier_constraints: similar to the previous one, but in this case we have some constraints on the input data.

Inside each of these directories we can finde three subdirectories:

- src: it contains the VHDL and verilog files that describe the DUT;

- tb: contains the SystemVerilog files for the correct execution of the simulation;

- sim: used for the initialization of the program and to store some logs.