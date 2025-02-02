puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 ../src/Banc_Registres.vhd
vcom -93 ../src/Extension.vhd
vcom -93 ../src/Memoire_Data.vhd
vcom -93 ../src/Mux2v1.vhd
vcom -93 ../src/Unite_de_Traitement.vhd

vcom -93 tb_Unite_de_Traitement.vhd

vsim -novopt tb_Unite_de_Traitement


add wave *
add wave -hexa /tb_Unite_de_Traitement/entity_UDT/entity_Banc_Registres/Banc
add wave -hexa /tb_Unite_de_Traitement/entity_UDT/entity_Memory/Memory
run -a
wave zoom full