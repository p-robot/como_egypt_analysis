#!/usr/bin/env Rscript
# 
# Script to plot heatmap of relstive reduction in incidence across different
# levels of mask wearing and mask efficacy.  

require(ggplot2)
require(tidyverse)

args <- commandArgs(trailingOnly = TRUE)

input_file <- args[1] # data/cleaned/mask_efficacy_coverage_ar.csv
output_file <- args[2] # "./results/figures/"

# Container to store results
df <- read.csv(input_file, header = TRUE)

# Add label for nice plotting
df$severity <- paste0("Proportion infected ", df$ar_baseline, "%")

# Calculate relative reduction in attack rate (for each baseline)
df_ar <- df %>% 
	group_by(ar_baseline) %>%
	mutate(rr_ar = 100 - 100*ar/max(ar))

print(head(df))

# In case you want to set zeros to be displayed as white
#df_ar$RR_AR[df_ar$RR_AR == 0] <- NA

# Generate plot
p <- ggplot(df_ar, aes(x = coverage, y = efficacy, fill = rr_ar)) + 
    geom_tile() +
    theme_bw() + 
    xlab("Mask coverage (%)") + 
    ylab("Mask efficacy (%)") + 
    scale_fill_distiller(name = "Reduction\nin cases (%)", 
        palette = "Reds", limits = c(0, 60), direction = 1,# YlOrRd
        breaks = seq(0, 60, by = 10), na.value = "white") + 
    scale_x_continuous(expand = c(0, 0), limits = c(-5, 105), breaks = seq(0, 100, 10)) + 
    scale_y_continuous(expand = c(0, 0), limits = c(2.5, 37.5), breaks = seq(5, 35, 5)) + 
    facet_grid(cols = vars(severity)) + 
    theme(
        strip.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        strip.text = element_text(size = 16),
        axis.text.x = element_text(size = 14),#, hjust = 0.5
        axis.text.y = element_text(size = 14),#, hjust = 0.5
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16)
        ) + theme(panel.spacing = unit(1, "lines"))

# Save plot to disk
ggsave(output_file, p, width = 12, height = 4)

