puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/Extension.vhd
vcom -93 ../src/Memoire_Instruction.vhd
vcom -93 ../src/Unite_des_Instructions.vhd

vcom -93 tb_Unite_des_Instructions.vhd

vsim -novopt tb_Unite_des_Instructions




add wave tb_CLK 
add wave tb_Reset 
add wave tb_Offset
add wave tb_nPCsel 
add wave -radix hexadecimal tb_Instruction
add wave Done
run -a
wave zoom full