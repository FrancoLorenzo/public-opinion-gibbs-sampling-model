# --- Pooled Gaussian Model ---

# Settings
n_iter <- 5000

# Priors
mu0 <- 0
tau2_0 <- 1000
alpha0 <- 0.001
beta0 <- 0.001

# Storage
posterior_mu_pooled <- numeric(n_iter)
posterior_sigma2_pooled <- numeric(n_iter)

# Initialize
mu_current <- mean(survey_data$Support)
sigma2_current <- var(survey_data$Support)

# Gibbs Sampler
set.seed(789)

for (i in 1:n_iter) {
  
  # 1. Update global mean
  n <- nrow(survey_data)
  ybar <- mean(survey_data$Support)
  
  mu_n <- (mu0 / tau2_0 + n * ybar / sigma2_current) / (1/tau2_0 + n/sigma2_current)
  tau2_n <- 1 / (1/tau2_0 + n/sigma2_current)
  
  posterior_mu_pooled[i] <- rnorm(1, mean = mu_n, sd = sqrt(tau2_n))
  
  # 2. Update common variance
  sum_sq <- sum((survey_data$Support - posterior_mu_pooled[i])^2)
  
  alpha_n <- alpha0 + n/2
  beta_n <- beta0 + sum_sq/2
  
  sigma2_current <- 1 / rgamma(1, shape = alpha_n, rate = beta_n)
  posterior_sigma2_pooled[i] <- sigma2_current
}

# --- Posterior Summaries ---

# Posterior mean and 95% credible interval
mean(posterior_mu_pooled)
quantile(posterior_mu_pooled, probs = c(0.025, 0.975))

# Plot
hist(posterior_mu_pooled, breaks = 30, main = "Pooled Model Posterior",
     xlab = "Global Mean Support (%)", col = "lightcoral", border = "white")

