onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate  /tb/N
add wave -noupdate -divider entradas
add wave -noupdate  -radix hexadecimal /tb/A
add wave -noupdate  -radix hexadecimal /tb/B
add wave -noupdate  /tb/mode
add wave -noupdate -divider saidas
add wave -noupdate  -radix hexadecimal /tb/Sum
add wave -noupdate  /tb/Cout
add wave -noupdate  /tb/ov
WaveRestoreZoom {0 ns} {80 ns}
