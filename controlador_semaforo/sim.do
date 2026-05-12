if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work  controlador.sv
vlog -work work  tb_semaforo.sv
 

vsim -voptargs=+acc -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1 

do wave.do

run 2 us

