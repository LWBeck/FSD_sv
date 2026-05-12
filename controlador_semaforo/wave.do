onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/sensor_ns
add wave -noupdate /tb/dut/sensor_lo
add wave -noupdate /tb/dut/modo
add wave -noupdate -divider comando
add wave -noupdate /tb/dut/cmd
add wave -noupdate -divider saidas
add wave -noupdate /tb/dut/nsLD
add wave -noupdate /tb/dut/loLD
add wave -noupdate /tb/dut/som
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {110 ns} 0}
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
WaveRestoreZoom {0 ns} {116 ns}
