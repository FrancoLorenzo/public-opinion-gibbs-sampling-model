# --- Hierarchical Normal Model ---

# Load necessary library
library(MASS)

# Settings
n_iter <- 5000  # number of iterations
groups <- unique(survey_data$Group)
n_groups <- length(groups)

# Hyperpriors
mu0_prior_mean <- 0
mu0_prior_var <- 1000
alpha0 <- 0.001
beta0 <- 0.001

# Storage
posterior_mu_g <- matrix(NA, nrow = n_iter, ncol = n_groups)
posterior_mu0 <- numeric(n_iter)
posterior_tau2 <- numeric(n_iter)
posterior_sigma2 <- numeric(n_iter)

# Initialize
mu_g_current <- tapply(survey_data$Support, survey_data$Group, mean)
mu0_current <- mean(mu_g_current)
tau2_current <- var(mu_g_current)
sigma2_current <- var(survey_data$Support)

# Indexing
group_idx <- split(1:nrow(survey_data), survey_data$Group)

# Gibbs Sampler
set.seed(456)

for (i in 1:n_iter) {
  
  # 1. Update group means mu_g
  for (g in 1:n_groups) {
    group_data <- survey_data$Support[group_idx[[g]]]
    n_g <- length(group_data)
    ybar_g <- mean(group_data)
    
    mu_n <- (mu0_current / tau2_current + n_g * ybar_g / sigma2_current) / (1/tau2_current + n_g/sigma2_current)
    tau2_n <- 1 / (1/tau2_current + n_g/sigma2_current)
    
    posterior_mu_g[i, g] <- rnorm(1, mean = mu_n, sd = sqrt(tau2_n))
  }
  
  # 2. Update global mean mu0
  mu0_n <- (mean(posterior_mu_g[i, ]) * n_groups / tau2_current + mu0_prior_mean / mu0_prior_var) / (n_groups / tau2_current + 1 / mu0_prior_var)
  mu0_var_n <- 1 / (n_groups / tau2_current + 1 / mu0_prior_var)
  
  mu0_current <- rnorm(1, mean = mu0_n, sd = sqrt(mu0_var_n))
  posterior_mu0[i] <- mu0_current
  
  # 3. Update group-level variance tau2
  alpha_tau <- alpha0 + n_groups / 2
  beta_tau <- beta0 + 0.5 * sum((posterior_mu_g[i, ] - mu0_current)^2)
  
  tau2_current <- 1 / rgamma(1, shape = alpha_tau, rate = beta_tau)
  posterior_tau2[i] <- tau2_current
  
  # 4. Update observation-level variance sigma2
  sum_sq <- 0
  for (g in 1:n_groups) {
    group_data <- survey_data$Support[group_idx[[g]]]
    sum_sq <- sum_sq + sum((group_data - posterior_mu_g[i, g])^2)
  }
  
  alpha_sigma <- alpha0 + nrow(survey_data)/2
  beta_sigma <- beta0 + sum_sq/2
  
  sigma2_current <- 1 / rgamma(1, shape = alpha_sigma, rate = beta_sigma)
  posterior_sigma2[i] <- sigma2_current
}

# Label columns
colnames(posterior_mu_g) <- groups
