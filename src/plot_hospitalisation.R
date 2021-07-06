#!/usr/bin/env Rscript
# 
# Script to plot timeseries of various measures of hospitalisations from CoMo output.  

require(ggplot2)

args <- commandArgs(trailingOnly = TRUE)

data_dir <- args[1] # "./data/output/"
output_dir <- args[2] # "./results/figures/"

# Container to store results
output <- list(); i <- 1
for( ar in c(10, 20, 30) ){
    df <- read.csv(file.path(data_dir, paste0("COVID_OUTPUT_EGY_V17.2_AR", ar, ".csv")), 
        header = TRUE)
    
    df$severity <- paste0("Proportion infected ", ar, "%")
    output[[i]] <- df; i <- i + 1
}
df_ar <- do.call(rbind, output)
df_ar$date <- as.Date(df_ar$date)

plotting_vars <- c(
    "baseline_normal_bed_occupancy_med", 
    "baseline_normal_bed_requirement_med", 
    "baseline_icu_bed_occupancy_med", 
    "baseline_icu_ventilator_occupancy_med", 
    "baseline_icu_bed_requirement_med", 
    "baseline_icu_ventilator_requirement_med")

hlines <- list(
    "baseline_normal_bed_occupancy_med" = 35152,
    "baseline_normal_bed_requirement_med" = 35152,
    "baseline_icu_bed_occupancy_med" = 3539,
    "baseline_icu_ventilator_occupancy_med" = 3539,
    "baseline_icu_bed_requirement_med" = 2218, 
    "baseline_icu_ventilator_requirement_med" = 2218
    )

# Generate plots
for(v in plotting_vars){
    
    ylab <- gsub("baseline_", "", v)
    ylab <- gsub("_med", "", ylab)
    ylab <- gsub("_", " ", ylab)
    ylab <- gsub("icu", "ICU", ylab)
    
    p <- ggplot(df_ar, aes_string(x = "date", y = v)) + 
        geom_line(color = "#0072B2") + 
        theme_bw() + 
        ylab(paste0("Hospitalisations\n(", ylab, ")")) + 
        geom_hline(yintercept = hlines[[v]], color = "#D55E00", linetype = "dashed") + 
        # scale_y_continuous(expand = c(0, 0), limits = c(2.5, 37.5), breaks = seq(5, 35, 5)) +
        xlim(c(as.Date("2020-01-01"), as.Date("2020-12-30"))) + 
        xlab("") + 
        facet_grid(cols = vars(severity)) + 
        theme(
            strip.background = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            strip.text = element_text(size = 16),
            axis.text.x = element_text(size = 14, angle = 45, vjust = 1, hjust = 1), 
            axis.text.y = element_text(size = 10),#, hjust = 0.5
            axis.title.x = element_text(size = 16),
            axis.title.y = element_text(size = 16),
            legend.text = element_text(size = 14),
            legend.title = element_text(size = 16)
            ) + theme(panel.spacing = unit(1, "lines"))

    # Save plot to disk
    ggsave(file.path(output_dir, paste0(v, ".png")), p, width = 12, height = 4)
}
