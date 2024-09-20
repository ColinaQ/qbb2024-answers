#Step 1.3

setwd("/Users/cmdb/qbb2024-answers/week1")


##################################################
#simulate sequencing 3x coverage of a 1Mbp genome with 100bp reads

png("ex1_3x_cov.png", width = 800, height = 600)

coverage_data <- scan("/Users/cmdb/qbb2024-answers/9_13_24/coverage_3x.txt")

hist(coverage_data,
     breaks = seq(-0.5, max(coverage_data) + 0.5, by = 1),
     xlab = "Coverage",
     ylab = "Frequency",
     main = "Coverage Overlaid by Poisson and Normal Distributions",
     col = "lightgrey")

coverage_values <- 0:max(coverage_data)

genome_size <- length(coverage_data)

# Poisson
lambda <- 3
pois_probs <- dpois(coverage_values, lambda)

# Normal
norm_mean <- 3
norm_stdv <- sqrt(3)
norm_probs <- dnorm(coverage_values, norm_mean, norm_stdv)

pois_counts <- pois_probs * genome_size
norm_counts <- norm_probs * genome_size

# Poisson distribution
lines(coverage_values, pois_counts, col = "orange", lwd = 2)

# Normal distribution
lines(coverage_values, norm_counts, col = "blue", lwd = 2)

legend("topright",
       legend = c("Histogram of Coverage", "Poisson Distribution", "Normal Distribution"),
       col = c("lightgrey", "orange", "blue"),
       pch = c(15, NA, NA),
       lty = c(NA, 1, 1),
       lwd = c(NA, 2, 2),
       bty = "n")

dev.off()

###########################################################
#zero_coverage for 3x coverage
zero_cov_3x <- sum(coverage_data == 0)
zero_cov_3x_port <- (zero_cov_3x / genome_size)

pois_zero_cov_prob <- dpois(0, lambda)
pois_zero_cov_expected <- pois_zero_cov_prob * genome_size

norm_zero_cov_prob <- pnorm(0, mean = norm_mean, sd = norm_stdv)
norm_zero_cov_expected <- norm_zero_cov_prob * genome_size


####################################################################
#simulate sequencing 10x coverage of a 1Mbp genome with 100bp reads

png("ex1_10x_cov.png", width = 800, height = 600)

coverage_data <- scan("/Users/cmdb/qbb2024-answers/9_13_24/coverage_10x.txt")

hist(coverage_data,
     breaks = seq(-0.5, max(coverage_data) + 0.5, by = 1),
     xlab = "Coverage",
     ylab = "Frequency",
     main = "Coverage Overlaid by Poisson and Normal Distributions",
     col = "lightgrey")

coverage_values <- 0:max(coverage_data)

genome_size <- length(coverage_data)

# Poisson
lambda <- 10
pois_probs <- dpois(coverage_values, lambda)

# Normal
norm_mean <- 10
norm_stdv <- sqrt(10)
norm_probs <- dnorm(coverage_values, norm_mean, norm_stdv)

pois_counts <- pois_probs * genome_size
norm_counts <- norm_probs * genome_size

# Poisson distribution
lines(coverage_values, pois_counts, col = "orange", lwd = 2)

# Normal distribution
lines(coverage_values, norm_counts, col = "blue", lwd = 2)

legend("topright",
       legend = c("Histogram of Coverage", "Poisson Distribution", "Normal Distribution"),
       col = c("lightgrey", "orange", "blue"),
       pch = c(15, NA, NA),
       lty = c(NA, 1, 1),
       lwd = c(NA, 2, 2),
       bty = "n")

dev.off()

###########################################################
#zero_coverage for 10x coverage
zero_cov_10x <- sum(coverage_data == 0)
zero_cov_10x_port <- (zero_cov_10x / genome_size)

pois_zero_cov_prob <- dpois(0, lambda)
pois_zero_cov_expected <- pois_zero_cov_prob * genome_size

norm_zero_cov_prob <- pnorm(0, mean = norm_mean, sd = norm_stdv)
norm_zero_cov_expected <- norm_zero_cov_prob * genome_size



######################################################################
#simulate sequencing 30x coverage of a 1Mbp genome with 100bp reads

png("ex1_30x_cov.png", width = 800, height = 600)

coverage_data <- scan("/Users/cmdb/qbb2024-answers/9_13_24/coverage_30x.txt")

hist(coverage_data,
     breaks = seq(-0.5, max(coverage_data) + 0.5, by = 1),
     xlab = "Coverage",
     ylab = "Frequency",
     main = "Coverage Overlaid by Poisson and Normal Distributions",
     col = "lightgrey")

coverage_values <- 0:max(coverage_data)

genome_size <- length(coverage_data)

# Poisson
lambda <- 30
pois_probs <- dpois(coverage_values, lambda)

# Normal
norm_mean <- 30
norm_stdv <- sqrt(30)
norm_probs <- dnorm(coverage_values, norm_mean, norm_stdv)

pois_counts <- pois_probs * genome_size
norm_counts <- norm_probs * genome_size

# Poisson distribution
lines(coverage_values, pois_counts, col = "orange", lwd = 2)

# Normal distribution
lines(coverage_values, norm_counts, col = "blue", lwd = 2)

legend("topright",
       legend = c("Histogram of Coverage", "Poisson Distribution", "Normal Distribution"),
       col = c("lightgrey", "orange", "blue"),
       pch = c(15, NA, NA),
       lty = c(NA, 1, 1),
       lwd = c(NA, 2, 2),
       bty = "n")

dev.off()

###########################################################
#zero_coverage for 30x coverage
zero_cov_30x <- sum(coverage_data == 0)
zero_cov_30x_port <- (zero_cov_30x / genome_size)

pois_zero_cov_prob <- dpois(0, lambda)
pois_zero_cov_expected <- pois_zero_cov_prob * genome_size

norm_zero_cov_prob <- pnorm(0, mean = norm_mean, sd = norm_stdv)
norm_zero_cov_expected <- norm_zero_cov_prob * genome_size








