`como_egypt_analysis`
====================

Code for analysis looking at PHSM in Egpyt against SARS-CoV-2.  

Data
----

* These scripts assume three basecase CoMo templates (V17.2) are stored in the `data/input` folder and named in the following manner: `EGY_V17.2_AR10.xlsx`, for example for the template with an attack rate of approximately 10% by 1st September 2020.  Assumes there are templates for 10, 20, 30% attack rate by 1st September 2020.  


Usage
-----

All analyses are performed using the Makefile.  

* `make install`: Clone the github repository of the `como_command_line` version of the model.  Install a virtual environment.  
* `make create_templates`: Create a range of templates for the CoMo model (version 17.2) across a range of mask-wearing efficacies and coverages (these are created in the folder `data/input/AR10`).  
* `make run_templates`: Run the created templates (and basecase templates) using the CoMo model.  Output is saved in `data/output/` (with a folder for results for each basecase attack rate).  
* `make consolidate_output`: Consolidate output from all runs into a single file of attack rates by 31 December 2020.  This file is saved as `data/cleaned/mask_efficacy_coverage_ar.csv`.  
* `make plot_all`: Generate all figures, including heatmap of relative change in attack rate over 1st Sept 2020 to 31st Dec 2020, time series of cases in each base case, indicators of hospitalisation in each base case.  

Other commands: 

* `make clean`: Remove the virtual environment and the `como_command_line` repository.  

