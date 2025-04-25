# --- Plots and Summaries ---

# Load libraries
library(ggplot2)

# 1. Posterior Summaries
# Separate model
separate_means <- apply(posterior_mu, 2, mean)
separate_ci <- t(apply(posterior_mu, 2, quantile, probs = c(0.025, 0.975)))

# Pooled model
pooled_mean <- mean(posterior_mu_pooled)
pooled_ci <- quantile(posterior_mu_pooled, probs = c(0.025, 0.975))

# Hierarchical model
hierarchical_means <- apply(posterior_mu_g, 2, mean)
hierarchical_ci <- t(apply(posterior_mu_g, 2, quantile, probs = c(0.025, 0.975)))

# Predictive
predictive_mean <- mean(predictive_mu_new)
predictive_ci <- quantile(predictive_mu_new, probs = c(0.025, 0.975))

# 2. Combine Summaries in a Table
summary_table <- data.frame(
  Model = c(paste("Separate:", colnames(posterior_mu)),
            "Pooled",
            paste("Hierarchical:", colnames(posterior_mu_g)),
            "Predictive (New Group)"),
  Mean = c(separate_means, pooled_mean, hierarchical_means, predictive_mean),
  CI_Lower = c(separate_ci[,1], pooled_ci[1], hierarchical_ci[,1], predictive_ci[1]),
  CI_Upper = c(separate_ci[,2], pooled_ci[2], hierarchical_ci[,2], predictive_ci[2])
)

print(summary_table)

# --- Save table if needed
# write.csv(summary_table, file = "outputs/summary_table.csv", row.names = FALSE)

# 3. Plots

# Separate model posterior distributions
par(mfrow = c(1,3))
for (g in 1:length(separate_means)) {
  hist(posterior_mu[,g], breaks = 30, main = paste("Separate:", colnames(posterior_mu)[g]),
       xlab = "Mean Support (%)", col = "lightblue", border = "white")
}

# Pooled model posterior distribution
hist(posterior_mu_pooled, breaks = 30, main = "Pooled Model",
     xlab = "Global Mean Support (%)", col = "lightcoral", border = "white")

# Hierarchical model posterior distributions
par(mfrow = c(1,3))
for (g in 1:length(hierarchical_means)) {
  hist(posterior_mu_g[,g], breaks = 30, main = paste("Hierarchical:", colnames(posterior_mu_g)[g]),
       xlab = "Group Mean (%)", col = "lightgreen", border = "white")
}

# Predictive distribution for new group
hist(predictive_mu_new, breaks = 30, main = "Predictive: New Group",
     xlab = "Predicted Mean Support (%)", col = "lightyellow", border = "gray40")
