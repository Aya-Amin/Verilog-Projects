onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/dut/clk
add wave -noupdate /testbench/dut/reset
add wave -noupdate /testbench/dut/op
add wave -noupdate /testbench/dut/funct
add wave -noupdate /testbench/dut/zero
add wave -noupdate /testbench/dut/md/state
add wave -noupdate /testbench/dut/alucontrol
add wave -noupdate /testbench/dut/pcen
add wave -noupdate /testbench/dut/md/controls
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 184
configure wave -valuecolwidth 58
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {32 ns}
