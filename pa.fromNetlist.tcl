
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name R_I_J_CPU -dir "/home/extra-home/leo/IC/R_I_J_CPU/planAhead_run_2" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/extra-home/leo/IC/R_I_J_CPU/TestLayer.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/extra-home/leo/IC/R_I_J_CPU} {ipcore_dir} }
add_files [list {ipcore_dir/RAM.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/InstROM.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "TestLayer.ucf" [current_fileset -constrset]
add_files [list {TestLayer.ucf}] -fileset [get_property constrset [current_run]]
link_design
