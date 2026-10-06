library(readr)
library(dplyr)


wage <- read_csv(
  "Data/raw_data/hourly_earnings_raw.csv",
  show_col_types = FALSE
)

cpi <- read_csv(
  "Data/raw_data/cpi_raw.csv",
  show_col_types = FALSE
)


wage <- wage |>
  rename(
    date = observation_date,
    hourly_wage = CES0500000003
  )

cpi <- cpi |>
  rename(
    date = observation_date,
    cpi = CPIAUCSL
  )

wage <- wage |>
  mutate(date = as.Date(date))

cpi <- cpi |>
  mutate(date = as.Date(date))


economic_data <- wage |> inner_join(cpi,by = "date")

economic_data <- economic_data |>
  filter(
    date >= as.Date("2015-01-01"),
    date <= as.Date("2025-12-31")
  )

economic_data <- economic_data |>
  mutate(
    real_wage = hourly_wage / cpi
  )

base_values <- economic_data |>
  filter(format(date, "%Y") == "2015") |>
  summarise(
    base_wage = mean(hourly_wage, na.rm = TRUE),
    base_cpi = mean(cpi, na.rm = TRUE),
    base_real_wage = mean(real_wage, na.rm = TRUE)
  )

economic_data <- economic_data |>
  mutate(
    wage_index =
      hourly_wage / base_values$base_wage * 100,
    
    price_index =
      cpi / base_values$base_cpi * 100,
    
    real_wage_index =
      real_wage / base_values$base_real_wage * 100
  )

write_csv(
  economic_data,
  "Data/processed_data/wages_inflation_clean.csv"
)

glimpse(economic_data)