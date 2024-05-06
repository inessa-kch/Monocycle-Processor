puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 tb_ALU.vhd

vsim -novopt tb_ALU


add wave tb_OP
add wave -radix hexadecimal tb_A
add wave -radix hexadecimal tb_B
add wave -radix hexadecimal tb_S
add wave tb_N
add wave tb_Z
add wave tb_C
add wave tb_V
run -a