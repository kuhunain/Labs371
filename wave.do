onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /car_detecting_tb/clk
add wave -noupdate /car_detecting_tb/reset
add wave -noupdate /car_detecting_tb/outer
add wave -noupdate /car_detecting_tb/inner
add wave -noupdate /car_detecting_tb/enter
add wave -noupdate /car_detecting_tb/exit
add wave -noupdate /car_detecting_tb/dut/ps
add wave -noupdate /car_detecting_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29 ps} 0}
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
configure wave -gridperiod 300
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {84 ps}
