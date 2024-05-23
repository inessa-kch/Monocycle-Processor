puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/Banc_Registres.vhd
vcom -93 ../src/ALU.vhd


vcom -93 tb_Banc_Registres_ALU.vhd

vsim -novopt tb_Banc_Registres_ALU



add wave tb_CLK
add wave tb_Reset
add wave -radix hexadecimal tb_RA
add wave -radix hexadecimal tb_RB
add wave -radix hexadecimal tb_RW
add wave -radix hexadecimal tb_A
add wave -radix hexadecimal tb_B
add wave -radix hexadecimal tb_W
add wave tb_WE
add wave tb_OP
add wave tb_N
add wave tb_Z
add wave tb_C
add wave tb_V




run -a
wave zoom full



