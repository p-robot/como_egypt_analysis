#!/usr/bin/env Rscript

##########
# PREAMBLE
# --------

require(tidyverse)
require(ggplot2)
require(gridExtra)

# Directories
data_dir <- "data/output"
output_dir <- "results/figures"

# Start/end dates for plotting
start_date <- as.Date("2020-01-28")
end_date <- as.Date("2020-08-31")

# Loop for reading all datasets (into one dataframe)
output <- list(); i <- 1
for( AR in c(11, 20, 30) ){
    
    filename <- file.path(data_dir, paste0("outputs-Egypt_V15_facemask25_AR", AR, ".csv"))
    df <- read.csv(filename)
    df$attack_rate <- AR
    
    output[[i]] <- df; i <- i + 1
}
df_all <- do.call(rbind, output)

df_all$date <- as.Date(df_all$date)

# Rename some columns
df_all$pred_cases <- df_all$baseline_predicted_reported_and_unreported_med
df_all$obs_cases <- df_all$input_cases
df_all$pred_rep_cases <- df_all$baseline_predicted_reported_med

df_all$attack_rate <- as.character(df_all$attack_rate)
df_all$attack_rate <- df_all$attack_rate %>% 
    recode(
        "11" = "High virus severity", 
        "20" = "Medium virus severity", 
        "30" = "Low virus severity") %>% 
    factor(ordered = T, 
         levels = c("Low virus severity", "Medium virus severity", "High virus severity"))

color_values <- c("#56B4E9", "#0072B2", "black")

####################
# Plotting of reported cases
# ------------------
ymax <- 3000

p1 <- ggplot(df_all, aes(x = date, y = pred_rep_cases))  +
    geom_line(aes(x = date, y = pred_rep_cases, colour = attack_rate), show.legend = T,size = 1.2) +
    geom_point(aes(x = date, y = obs_cases), colour = "red", show.legend = F, alpha = 0.6) +
    labs(x = "", y = "Daily reported cases") +
    theme(
          axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 12),
          strip.text = element_text(size = 12, face = "bold"),
          strip.background = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          legend.text = element_text(size = 12), 
          axis.line = element_line(colour = "black"), 
          plot.title = element_text(hjust = 0.5, size = 12, face = "bold")) +
    ylim(0, ymax) + 
    scale_colour_manual(name = "", values = color_values) + 
    scale_x_date(breaks = "1 month", date_labels = "%b", limits = c(start_date, end_date))


####################
# Plotting of deaths
# ------------------

ymax <- 6000
df_all$obs_cum_mort <- df_all$input_cumulative_death

death_cols <- c(
    "baseline_death_treated_hospital_med",
    "baseline_death_treated_icu_med",
    "baseline_death_treated_ventilator_med",
    "baseline_death_untreated_hospital_med",
    "baseline_death_untreated_icu_med",
    "baseline_death_untreated_ventilator_med"
)
df_all$pred_cum_mort <- rowSums(df_all[, death_cols])


p2 <- ggplot(df_all, aes(x = date, y = pred_cum_mort)) + 
    geom_line(aes(colour=attack_rate), show.legend = T, size = 1.2) + 
    geom_point(aes(x = date, y = obs_cum_mort), colour = "red", show.legend = F, alpha = 0.6) +
    labs(x = "", y = "Cumulative mortality") + 
    theme(
          axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
          axis.text.y = element_text(size = 12),
          axis.title = element_text(size = 12),
          strip.text = element_text(size = 12, face = "bold", color = "white"),
          strip.background = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          legend.text = element_text(size = 12), 
          legend.position = "top", 
          axis.line = element_line(colour = "black"), 
          plot.title = element_text(hjust = 0.5, size = 12, face = "bold")) +
    ylim(0, ymax) + 
    scale_colour_manual(name = "", values = color_values) + 
    scale_x_date(breaks = "1 month", date_labels = "%b %Y", limits = c(start_date, end_date))

# Arrange all figures in one plot
#p_all <- grid.arrange(p1, p2, nrow = 2)

# Save composite figure to file
ggsave(file.path(output_dir, "calibration_daily_cases_mortality.pdf"), 
    plot = p2, device = "pdf", width = 8, height = 6)
