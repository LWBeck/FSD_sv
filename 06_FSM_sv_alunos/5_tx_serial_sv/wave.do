onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/reset
add wave -noupdate /tb/dut/clock
add wave -noupdate -divider TRASMISSAO
add wave -noupdate /tb/dut/send
add wave -noupdate -radix hexadecimal /tb/dut/palavra
add wave -noupdate /tb/dut/busy
add wave -noupdate /tb/dut/linha
add wave -noupdate -divider RECEPCAO
add wave -noupdate -radix hexadecimal /tb/u_rx/data_o
add wave -noupdate /tb/u_rx/valid_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {230 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1050 ns}
