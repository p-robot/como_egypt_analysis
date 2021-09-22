.PHONY: install clean create_templates

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
