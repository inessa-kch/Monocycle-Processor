puts "Simulation script for ModelSim "

vlib work
vcom -93 ../src/VIC.vhd


vcom -93 tb_VIC.vhd

vsim -novopt tb_VIC


add wave tb_CLK
add wave tb_Reset
add wave tb_IRQ_SERV
add wave tb_IRQ0
add wave tb_IRQ1
add wave tb_IRQ
add wave -radix hexadecimal tb_VICPC
add wave Done

run -a
wave zoom full