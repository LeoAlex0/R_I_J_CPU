
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name R_I_J_CPU -dir "C:/Users/codgi/Documents/GitHub/R_I_J_CPU/planAhead_run_4" -part xc7a100tfgg484-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "TestLayer.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/InstROM.ngc}]
set hdlfile [add_files [list {ipcore_dir/RAM.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/InstROM.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Controller.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {SimpleALU.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {RegHeap.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
add_files [list {ipcore_dir/RAM.ngc}]
set hdlfile [add_files [list {InstGetter.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {InsAnalyser.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {WBSeg.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {MEMSeg.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {IFSeg.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {IDSeg.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {hazard.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {EXSeg.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {MultiSegCPU.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Exp16Fdiv.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {Display.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {TestLayer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top TestLayer $srcset
add_files [list {TestLayer.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/InstROM.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/RAM.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tfgg484-3
