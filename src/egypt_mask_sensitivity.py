#!/usr/bin/env python3
"""
Script to adjust mask efficacy and mask coverage from a template using the CoMo model.  
Based on modelling analysis for Egypt for COVID19 outbreak in 2020
p-robot, keyrellous, 2021
"""

import sys, os
import openpyxl
import pandas as pd, numpy as np
from shutil import copy2

# Parse command-line arguments
file_path = sys.argv[1] # path to xls files
output_dir = sys.argv[2] # output directory in which to save the new xls files

mask_efficacies = np.arange(5, 40, 5)
mask_coverages = np.arange(0, 110, 10)

param_ranges = [mask_efficacies, mask_coverages]

# Find all combinations of input parameters
param_combinations = np.array(np.meshgrid(*param_ranges)).T.reshape(-1, 2)

# Adjust parameter values of interest
basename = os.path.basename(file_path)
basename = os.path.basename(file_path.split(".")[0])
dirname = os.path.dirname(file_path)
extension = file_path.split(".")[-1]

# Create abbreviations for parameter names (mask coverage, mask efficacy)
param_abbrevs = ["ME", "MC"]

for i, p in enumerate(param_combinations):
    
    # Create filename suffix
    suffix = "_".join([f'{n}{v}' for n, v in zip(param_abbrevs, p)])
    new_file_path = os.path.join(output_dir, f"{basename}_{suffix}.{extension}")
    
    # Make a copy of the whole excel file
    copy2(file_path, new_file_path)
    
    # Load the new workbook
    wb = openpyxl.load_workbook(new_file_path, keep_vba = True, data_only = True)
    
    # Adjust "mask efficacy" in the "Interventions Param" sheet
    wb["Interventions Param"]["C17"] = int(p[0])

    # Adjust "mask coverage" in the "Interventions" sheet when "Date Start" is 01/09/2020
    # and "Intervention" is "Mask Wearing"
    wb["Interventions"]["D9"] = int(p[1])

    # Save excel to file
    wb.save(new_file_path)
