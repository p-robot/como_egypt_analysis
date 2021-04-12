`como_egypt_analysis`
====================

Code for analysis looking at PHSM in Egpyt against SARS-CoV-2.  


Data
----

* These scripts assume three files for looking at efficacy of mask wearing are in `data/output` folder: 

```
data/output/mask wearing cov eff AR20.csv
data/output/mask wearing cov eff AR30.csv
data/output/mask wearing cov eff.csv
```

Usage
-----


* Figure 5 can be generated in the following manner: 

```bash
Rscript src/plot_mask_eff_cov.R "data/output" "results/figures"
```
