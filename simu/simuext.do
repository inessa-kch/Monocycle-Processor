puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/Extension.vhd
vcom -93 tb_Extension.vhd

vsim -novopt tb_Extension


add wave -radix hexadecimal tb_E
add wave -radix hexadecimal tb_S


run -a
wave zoom full