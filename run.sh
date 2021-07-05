#!/usr/bin/env bash
# 
# Script for generating figures and parameter templates for the CoMo model
# for modelling analysis looking at public health and social measures against COVID-19 in Egypt

#Rscript src/plot_como_output_calibration.R

####################################################
# SENSITIVITY ANALYSIS TO MASK EFFICACY AND COVERAGE
# --------------------------------------------------

# Run sensitivity analysis across a range of attach rates
for AR in 10 20 30
do
	# Create a directory for output
	mkdir -p "data/input/AR${AR}"
	
	# Create a sensitivity analysis across mask efficacy and mask coverage
	python3 src/egypt_mask_sensitivity.py \
		"data/input/EGY_V17.2_AR${AR}.xlsx" \
		"data/input/AR${AR}"
	
	# Compress the resultant folder
	(cd "data/input/"; zip -r "AR${AR}.zip" "AR${AR}")
done


# Figure 1
Rscript src/plot_attack_rates.R \
    "data/output" \
    "results/figures"

# Figure 5
Rscript src/plot_mask_eff_cov.R \
	"data/output" \
	"results/figures"

# Figures of hospitalisations
# (produces six figures)
Rscript src/plot_hospitalisation.R \
    "data/output/21.06.28" \
    "results/figures"
