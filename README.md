# Public Opinion on Military Aid to Ukraine – A Bayesian Approach

This project uses **Bayesian inference** and **Gibbs sampling** to analyze survey data on U.S. adult opinions regarding military aid to Ukraine. Using a dataset from *The Economist/YouGov Survey (Feb. 2025)*, we model public sentiment across political affiliations using separate, pooled, and hierarchical Gaussian models.

## 📊 Dataset Summary

The data reflects the percentage distribution of support among 1,603 U.S. adults (18+), segmented by political affiliation:

| Affiliation  | Increase Aid | Maintain Aid | Not Sure | Decrease Aid |
|--------------|--------------|--------------|----------|--------------|
| Democrats    | 35%          | 39%          | 16%      | 10%          |
| Independents | 19%          | 23%          | 26%      | 33%          |
| Republicans  | 10%          | 24%          | 21%      | 45%          |

## 🧠 Model Overview

Three Bayesian Gaussian models with a **common variance** are implemented:

- **Separate (Unpooled) Model**: Each group has its own mean.
- **Pooled Model**: A single mean is estimated across all groups.
- **Hierarchical Model**: Group means are modeled with a shared hyperprior distribution to allow for shrinkage and partial pooling.

All models are fit using **Gibbs sampling**.

## 🔁 Gibbs Sampling

We implement Gibbs sampling in R to sample from the joint posterior distributions. Posterior diagnostics and predictive checks are included for:

- Group-level posterior means
- Predictive distribution for a hypothetical (6th) group
- Posterior uncertainty comparisons across models

## 📂 Project Structure


## 🚀 How to Run

1. Clone the repo  
   ```bash
   git clone https://github.com/yourusername/public-opinion-gibbs-sampling-model.git
   ```

2. Open R and install required packages:
  ```R
  install.packages(c("coda", "ggplot2"))
  ```

3. Run any of the scripts from the scripts/ folder:

  ```
  source("scripts/model_hierarchical.R")
  ```

## 📈 Results Preview
- Hierarchical model shows posterior shrinkage toward the population mean
- Predictive distribution provides reasonable estimates for a hypothetical unaffiliated group
- MCMC diagnostics confirm proper convergence

## 📚 Interpretation
The hierarchical model provides a nuanced view of public opinion, balancing between individual group data and broader trends. It is particularly effective when working with limited or imbalanced data.

## 📝 License
This project is for educational purposes and shared under the MIT License.
