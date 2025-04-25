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


## 🚀 How to Run

1. Clone the repo  
   ```bash
   git clone https://github.com/yourusername/public-opinion-gibbs-sampling-model.git
   ```

2. Open R and install required packages:
  ```R
  install.packages(c("coda", "ggplot2"))
  ```

3. Run the scripts from the scripts/ folder:

  ```R
  source("scripts/01_data_setup.R")
  source("scripts/02_separate_model.R")
  source("scripts/03_pooled_model.R")
  source("scripts/04_hierarchical_model.R")
  source("scripts/05_predictive_analysis.R")
  source("scripts/06_plots_and_summaries.R")
  ```

4. Knit the final report:

Open `07_final_report.Rmd` and Knit to **PDF**.

## 📈 Results Preview

- Hierarchical model shows posterior shrinkage toward the population mean.
- Predictive distribution provides reasonable estimates for a hypothetical unaffiliated group.
- MCMC diagnostics confirm good convergence across samplers.

## 📚 Interpretation

The hierarchical model provides a balanced and robust perspective of public opinion by blending individual group tendencies with overall trends.
This approach is especially effective for small or imbalanced datasets, capturing uncertainty without overfitting.

## 📝 License

This project is for educational purposes and shared under the MIT License.
