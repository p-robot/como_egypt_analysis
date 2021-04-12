#!/usr/bin/env Rscript
# 
# Script to plot heatmap of relstive reduction in incidence across different
# levels of mask wearing and mask efficacy.  

require(ggplot2)

args <- commandArgs(trailingOnly = TRUE)

data_dir <- args[1] # "./data/output/"
output_dir <- args[2] # "./results/figures/"

# Container to store results
output <- list(); i <- 1
for( ar in c("", " AR30", " AR20") ){
    df <- read.csv(file.path(data_dir, paste0("mask wearing cov eff", ar, ".csv")), header = TRUE)
    df$severity <- ar
    df$RR_AR <- 100 - 100*with(df, AR/max(AR))
    
    output[[i]] <- df; i <- i + 1
}
df_all <- do.call(rbind, output)
df_ar <- df_all[,-which(colnames(df_all) == "mortality")]

# Set zeros to be displayed as white
df_ar$RR_AR[df_ar$RR_AR == 0] <- NA

# Generate plot
p <- ggplot(df_ar, aes(x = Coverage, y = Efficacy, fill = RR_AR)) + 
    geom_tile() +
    theme_bw() + 
    xlab("Mask coverage (%)") + 
    ylab("Mask efficacy (%)") + 
    scale_fill_distiller(name = "Reduction\nin cases (%)", 
        palette = "Reds", limits = c(0, 50), direction = 1,# YlOrRd
        breaks = seq(0, 50, by = 10), na.value = "white") + 
    scale_x_continuous(expand = c(0, 0), limits = c(0, 105)) + 
    scale_y_continuous(expand = c(0, 0), limits = c(5, 35)) + 
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
        )

# Save plot to disk
ggsave(file.path(output_dir, "mask_efficacy_coverage.png"), p, width = 12, height = 4)
