onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/N
add wave -noupdate -divider entradas
add wave -noupdate -radix unsigned /tb/A
add wave -noupdate -radix unsigned /tb/B
add wave -noupdate /tb/Cin
add wave -noupdate -divider saidas
add wave -noupdate -radix unsigned /tb/Sum
add wave -noupdate /tb/Cout
update
WaveRestoreZoom {0 ns} {60 ns}
