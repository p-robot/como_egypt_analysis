# Script to concatenate output from many CoMo runs into one file
# extracting attack rate

output_dir <- "data/output"
output_file <- "test.csv"
date_ar <- as.Date("2020-12-31")
population_size <-  102416974 # Taken from template

output <- list(); i <- 1

for(AR in c(10, 20, 30)){

	files <- list.files(file.path(output_dir, paste0("AR", AR)))
	files <- files[grepl(".csv", files)]
	print(files)

    for(f in files){
	    df <- read.csv(file.path(output_dir, paste0("AR", AR), f))
	    df$cum_cases <- cumsum(df$baseline_predicted_reported_and_unreported_med)
	    
	    df$date <- as.Date(df$date)
	    
            efficacy <- gsub("ME", "", unlist(strsplit(unlist(strsplit(f, ".csv")), "_"))[4])
	    coverage <- gsub("MC", "", unlist(strsplit(unlist(strsplit(f, ".csv")), "_"))[5])
	    df_sub <- subset(df, date == date_ar)
	    print(df_sub)
	    attack_rate <- 100*df_sub$cum_cases/population_size
	    
	    output[[i]] <- c(as.numeric(efficacy), as.numeric(coverage), AR, attack_rate, f)
            i <- i + 1
    }
}

# Concatenate all output into one file
df_all <- data.frame(do.call(rbind, output))
names(df_all) <- c("efficacy", "coverage", "ar_baseline", "ar", "filename")
print(head(df_all))

# Save to file
write.csv(df_all, output_file, row.names = FALSE)

