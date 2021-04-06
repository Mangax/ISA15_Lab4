source /software/scripts/init_questa10.7c
vcom -93 -work ./work ../src/common/*.vhd
vcom -93 -work ./work ../src/mbe/*.vhd
vcom -93 -work ./work ../src/multiplier/fpmul_stage1_struct.vhd
vcom -93 -work ./work ../src/multiplier/fpmul_stage2_struct.vhd
vcom -93 -work ./work ../src/multiplier/fpmul_stage3_struct.vhd
vcom -93 -work ./work ../src/multiplier/fpmul_stage4_struct.vhd
vcom -93 -work ./work ../src/multiplier/fpmul_pipeline.vhd
vlog ../tb/top.sv
vsim top
