#Compile the code
vlog array_multiplier.sv tb_array_multiplier.sv

#Optimize the code
vopt +acc tb_array_multiplier -o tb_opt

#Simulate the code
vsim tb_opt

#Add Wave
add wave -position insertpoint sim:/tb_array_multiplier/*

# Enable code coverage for the testbench during simulation
vsim -coverage tb_array_multiplier -voptargs="+cover=bcesft"

# Run the simulation until completion
run -all

# Generate coverage reports for the simulation
coverage report -code bcesft

# Command to generate a comprehensive coverage report that includes all types of coverage
coverage report -codeAll

#Command to generate an assert coverage report.
coverage report -assert -binrhs -details -cvg
