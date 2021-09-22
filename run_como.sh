#!/usr/bin/env bash
# 
# Script to run CoMo model (V17.2) on basecase
# and across range of mask efficacies and coverages
# 
# On cluster systems, this script can be left running using: 
# nohup ./run_como.sh > run_como.log 2> run_como.err &


cd como_command_line

# Run sensitivity analysis across a range of attach rates
for AR in 10 20 30
do
        # Create a directory for output
	output_dir="../data/output/AR${AR}"
        mkdir -p "$output_dir"

	# Run basecase
	Rscript como_command_line.R "Egypt" "../data/input/EGY_V17.2_AR${AR}.xlsx" "../data/output/EGY_V17.2_AR${AR}.csv"
	
	for f in ../data/input/AR${AR}/*xlsx
	do
		filename=$(basename --suffix .xlsx $f)
		echo $filename
		Rscript como_command_line.R "Egypt" "$f" $output_dir/$filename.csv
	done
done


