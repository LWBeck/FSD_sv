onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider entradas
add wave -noupdate /tb/a
add wave -noupdate /tb/b
add wave -noupdate /tb/c
add wave -noupdate -divider saidas
add wave -noupdate /tb/sum
add wave -noupdate /tb/cout
update
WaveRestoreZoom {0 ns} {84 ns}
