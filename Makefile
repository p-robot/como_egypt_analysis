.PHONY: install clean create_templates

SHELL := /bin/bash
BIN=venv/bin/

# Setup script for running CoMo model
install: 
	# Clone github repo of the CoMo model
	git clone https://github.com/p-robot/como_command_line
	
	# Create and activate virtual environment
	python3 -m venv venv; \
	source venv/bin/activate; \
	pip install -r requirements.txt; \
	deactivate

clean:
	rm -rf como_command_line
	rm -rf venv

# Script to create templates across a range of efficacies and coverages
# for mask efficacy
create_templates:
	for AR in 10 20 30 ; do \
		mkdir -p data/input/AR$$AR; \
		$(BIN)python src/egypt_mask_sensitivity.py \
			"data/input/EGY_V17.2_AR$$AR.xlsx" \
			"data/input/AR$$AR/"; \
	done

run_templates:
	./run_como.sh

# Consolidate all output into a single file
consolidate_output:
	Rscript src/consolidate_como_output.R \
		"data/output" \
		"data/cleaned/mask_efficacy_coverage_ar.csv" \
		"2020-12-31" \
		102416974

# Plot daily cases through time (figure 1)
plot_daily_cases:
	Rscript src/plot_attack_rates.R \
		"data/output" \
		"results/figures/daily_cases.png"

plot_daily_cases_pdf:
	Rscript src/plot_attack_rates.R \
		"data/output" \
		"results/figures/daily_cases.pdf"


# Plot heatmap of RR in attack rate as function
# of mask efficacy and coverage (figure 5)
plot_heatmap: 
	Rscript src/plot_mask_eff_cov.R \
		"data/cleaned/mask_efficacy_coverage_ar.csv" \
		"results/figures/mask_efficacy_coverage.png"
plot_heatmap_pdf:
	Rscript src/plot_mask_eff_cov.R \
		"data/cleaned/mask_efficacy_coverage_ar.csv" \
		"results/figures/mask_efficacy_coverage.pdf"

# Plot hospitalisations
plot_hospitalisations:
	Rscript src/plot_hospitalisation.R \
		"data/output/" \
		"results/figures/"

# Generate all plots
plot_all:
	make plot_daily_cases
	make plot_daily_cases_pdf
	make plot_heatmap
	make plot_heatmap_pdf
	make plot_hospitalisations
