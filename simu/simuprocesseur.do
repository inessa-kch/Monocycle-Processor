puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 ../src/Banc_Registres.vhd
vcom -93 ../src/Decodeur.vhd
vcom -93 ../src/Extension.vhd
vcom -93 ../src/Memoire_Data.vhd
vcom -93 ../src/Memoire_Instruction.vhd
vcom -93 ../src/Mux2v1.vhd
vcom -93 ../src/Registre.vhd
vcom -93 ../src/Unite_de_Traitement.vhd
vcom -93 ../src/Unite_des_Instructions.vhd
#vcom -93 ../src/Unite_de_Controle.vhd
vcom -93 ../src/Processeur.vhd

vcom -93 tb_Processeur.vhd

vsim -novopt tb_Processeur




add wave tb_CLK 
add wave tb_Reset 
add wave -radix hexadecimal tb_Afficheur
add wave /tb_Processeur/entity_processeur/entity_decodeur/instr_courante
add wave -radix hexadecimal /tb_Processeur/entity_processeur/entity_udt/entity_Banc_Registres/Banc

add wave -radix hexadecimal /tb_processeur/entity_processeur/entity_udt/entity_Memory/Memory


add wave Done
run -a
wave zoom full