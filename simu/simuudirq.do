puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/Extension.vhd
vcom -93 ../src/Mux2v1.vhd
vcom -93 ../src/Memoire_Instruction_IRQ.vhd
vcom -93 ../src/Unite_des_Instructions_IRQ.vhd

vcom -93 tb_Unite_des_Instructions_IRQ.vhd

vsim -novopt tb_Unite_des_Instructions_IRQ


add wave tb_CLK 
add wave tb_Reset
add wave tb_IRQ
add wave -radix hexadecimal tb_VICPC
add wave -hexadecimal /tb_Unite_des_Instructions_IRQ/entity_UDI/LR  
add wave -hexadecimal /tb_Unite_des_Instructions_IRQ/entity_UDI/PC
#add wave -hexadecimal /tb_Unite_des_Instructions_IRQ/entity_UDI/PC_out
add wave tb_IRQ_END
add wave tb_Offset
add wave tb_nPCsel 
add wave -radix hexadecimal tb_Instruction
add wave tb_IRQ_SERV
add wave Done
run -a
wave zoom full