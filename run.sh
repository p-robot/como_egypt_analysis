#!/usr/bin/env bash
# 
# Script for generating figures and parameter templates for the CoMo model
# for modelling analysis looking at public health and social measures against COVID-19 in Egypt





####################################################
# SENSITIVITY ANALYSIS TO MASK EFFICACY AND COVERAGE
# --------------------------------------------------

# Run sensitivity analysis across a range of attach rates
for AR in 11 20 30
do
	# Create a directory for output
	mkdir -p "data/input/AR${AR}"
	
	# Create a sensitivity analysis across mask efficacy and mask coverage
	python3 src/egypt_mask_sensitivity.py \
		"data/input/Egypt_V15_masksensitivity_AR${AR}.xlsx" \
		"data/input/AR${AR}"
	
	# Compress the resultant folder
	(cd "data/input/"; zip -r "AR${AR}.zip" "AR${AR}")
done


# Figure 5
Rscript src/plot_mask_eff_cov.R \
	"data/output" \
	"results/figures"
