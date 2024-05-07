puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/Mux2v1.vhd
vcom -93 tb_Mux2v1.vhd

vsim -novopt tb_Mux2v1


add wave -radix hexadecimal tb_A
add wave -radix hexadecimal tb_B
add wave -radix hexadecimal tb_S
add wave tb_COM

run -a
wave zoom full


