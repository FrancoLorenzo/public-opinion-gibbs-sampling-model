# --- Predictive Distribution for New Political Affiliation ---

# Settings
n_iter <- length(posterior_mu0)  # use the same number of posterior draws

# Storage for predictive mean
predictive_mu_new <- numeric(n_iter)

# Sampling
set.seed(999)

for (i in 1:n_iter) {
  predictive_mu_new[i] <- rnorm(1, mean = posterior_mu0[i], sd = sqrt(posterior_tau2[i]))
}

# --- Posterior Summaries for Predictive Mean ---

# Posterior mean and 95% credible interval
mean(predictive_mu_new)
quantile(predictive_mu_new, probs = c(0.025, 0.975))

# Plot predictive distribution
hist(predictive_mu_new, breaks = 30, main = "Predictive Distribution: New Group",
     xlab = "Mean Support (%)", col = "lightyellow", border = "gray40")
