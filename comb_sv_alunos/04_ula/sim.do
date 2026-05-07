if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work  FA.sv
vlog -work work  sum_sub.sv
vlog -work work  ula.sv
vlog -work work  tb_ula.sv

vsim -voptargs=+acc -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1 

do wave.do

run 1500 ns

