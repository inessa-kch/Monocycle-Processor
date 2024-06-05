puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/ALU.vhd
vcom -93 ../src/Banc_Registres.vhd
vcom -93 ../src/Decodeur.vhd
vcom -93 ../src/Extension.vhd
vcom -93 ../src/Memoire_Data.vhd
vcom -93 ../src/Memoire_Instruction_IRQ.vhd
vcom -93 ../src/VIC.vhd
vcom -93 ../src/Mux2v1.vhd
vcom -93 ../src/Registre.vhd
vcom -93 ../src/Unite_de_Traitement.vhd
vcom -93 ../src/Unite_des_Instructions_IRQ.vhd
#vcom -93 ../src/Unite_de_Controle.vhd
vcom -93 ../src/Processeur.vhd

vcom -93 tb_Processeur.vhd

vsim -novopt tb_Processeur




add wave tb_CLK 
add wave tb_Reset 
add wave tb_IRQ0
add wave tb_IRQ1
add wave -radix hexadecimal tb_Afficheur
add wave /tb_Processeur/entity_processeur/entity_decodeur/instr_courante
add wave -radix hexadecimal /tb_Processeur/entity_processeur/entity_udt/entity_Banc_Registres/Banc
add wave -radix hexadecimal /tb_processeur/entity_processeur/entity_udt/entity_Memory/Memory
add wave -hexadecimal tb_Processeur/entity_processeur/entity_udi/PC
add wave -hexadecimal tb_Processeur/entity_processeur/entity_udi/LR
add wave -hexadecimal tb_Processeur/entity_processeur/entity_udi/IRQ_SERV
add wave tb_Processeur/entity_processeur/entity_vic/IRQ
add wave -radix hexadecimal sim:/tb_processeur/entity_processeur/IRQ_END

add wave Done
run -a
wave zoom full