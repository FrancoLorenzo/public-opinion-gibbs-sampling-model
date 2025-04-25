# --- Data Setup ---
survey_data <- data.frame(
  Group = rep(c("Democrat", "Independent", "Republican"), each = 4),
  Opinion = rep(c("Increase Aid", "Maintain Aid", "Not Sure", "Decrease Aid"), times = 3),
  Support = c(35, 39, 16, 10,   # Democrats
              19, 23, 26, 33,   # Independents
              10, 24, 21, 45)   # Republicans
)

# View the data
print(survey_data)