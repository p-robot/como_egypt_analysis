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
for( ar in c(10, 20, 30) ){
    df <- read.csv(file.path(data_dir, paste0("AR", ar, "_Base_Case.csv")), header = TRUE)
    df$severity <- paste0("Proportion infected ", ar, "%")
    
    df$predicted <- df[["Predicted.Reported...Unreported"]]
    
    
    if( ar == 10 ){
        df$date <- as.Date(df$DateTime, "%m/%d/%Y %H:%M")
    }else{
        df$date <- as.Date(df$DateTime, "%Y-%m-%d %H:%M:%S")
    }
    output[[i]] <- df; i <- i + 1
}
df_ar <- do.call(rbind, output)


# Generate plot
p <- ggplot(df_ar, aes(x = date, y = predicted/1000)) + 
    geom_line(color = "#0072B2") + 
    theme_bw() + 
    geom_vline(xintercept = as.Date("2020-09-01"), color = "#D55E00", linetype = "dashed") + 
    ylab("Total daily cases (thousands)") + 
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
        axis.text.y = element_text(size = 14),#, hjust = 0.5
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16)
        ) + theme(panel.spacing = unit(1, "lines"))

# Save plot to disk
ggsave(file.path(output_dir, "attack_rate.png"), p, width = 12, height = 4)
