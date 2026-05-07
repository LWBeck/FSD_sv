onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/opmode
add wave -noupdate -divider entradas
add wave -noupdate -radix hexadecimal /tb/op1
add wave -noupdate -radix hexadecimal /tb/op2
add wave -noupdate -divider saidas
add wave -noupdate -radix hexadecimal /tb/outalu
add wave -noupdate /tb/z
add wave -noupdate /tb/cout
add wave -noupdate /tb/ov
update
WaveRestoreZoom {0 ns} {1500 ns}
