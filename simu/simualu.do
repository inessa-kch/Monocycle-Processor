puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 tb_ALU.vhd

vsim -novopt tb_ALU

add wave *
run -a