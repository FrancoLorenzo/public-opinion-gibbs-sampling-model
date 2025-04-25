# --- Gibbs Sampler for Separate Models ---

# Load library
library(MASS)

# Settings
n_iter <- 5000  # number of Gibbs iterations
groups <- unique(survey_data$Group)
n_groups <- length(groups)

# Prior hyperparameters
mu0 <- 0
tau2_0 <- 1000
alpha0 <- 0.001
beta0 <- 0.001

# Storage
posterior_mu <- matrix(NA, nrow = n_iter, ncol = n_groups)
posterior_sigma2 <- numeric(n_iter)

# Initialize
mu_current <- tapply(survey_data$Support, survey_data$Group, mean)
sigma2_current <- var(survey_data$Support)

# Indexing
group_idx <- split(1:nrow(survey_data), survey_data$Group)

# Gibbs Sampler
set.seed(123)

for (i in 1:n_iter) {
  
  # Update each group mean
  for (g in 1:n_groups) {
    group_data <- survey_data$Support[group_idx[[g]]]
    n_g <- length(group_data)
    ybar_g <- mean(group_data)
    
    # Posterior parameters
    mu_n <- (mu0 / tau2_0 + n_g * ybar_g / sigma2_current) / (1/tau2_0 + n_g/sigma2_current)
    tau2_n <- 1 / (1/tau2_0 + n_g/sigma2_current)
    
    # Sample new group mean
    posterior_mu[i, g] <- rnorm(1, mean = mu_n, sd = sqrt(tau2_n))
  }
  
  # Update common variance
  sum_sq <- 0
  for (g in 1:n_groups) {
    group_data <- survey_data$Support[group_idx[[g]]]
    sum_sq <- sum_sq + sum((group_data - posterior_mu[i, g])^2)
  }
  
  alpha_n <- alpha0 + nrow(survey_data)/2
  beta_n <- beta0 + sum_sq/2
  
  sigma2_current <- 1 / rgamma(1, shape = alpha_n, rate = beta_n)
  posterior_sigma2[i] <- sigma2_current
}

# Label columns
colnames(posterior_mu) <- groups
