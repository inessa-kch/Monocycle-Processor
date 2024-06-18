puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/Memoire_Data.vhd


vcom -93 tb_Memoire_Data.vhd

vsim -novopt tb_Memoire_Data


add wave tb_CLK
add wave tb_Reset
add wave -radix hexadecimal tb_DataIn
add wave -radix hexadecimal tb_DataOut
add wave tb_Addr
add wave tb_WrEn
add wave -hexa /tb_Memoire_Data/entity_memory/Memory



run -a
wave zoom full
