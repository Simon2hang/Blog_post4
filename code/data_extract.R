library(readr)
library(dplyr)

dir.create(
  "Data/raw_data",
  recursive = TRUE,
  showWarnings = FALSE
)

dir.create(
  "Data/processed_data",
  recursive = TRUE,
  showWarnings = FALSE
)


wage_url <- paste0(
  "https://fred.stlouisfed.org/graph/fredgraph.csv?",
  "id=CES0500000003"
)

cpi_url <- paste0(
  "https://fred.stlouisfed.org/graph/fredgraph.csv?",
  "id=CPIAUCSL"
)


wage_raw <- read_csv(
  wage_url,
  show_col_types = FALSE
)

cpi_raw <- read_csv(
  cpi_url,
  show_col_types = FALSE
)


write_csv(
  wage_raw,
  "Data/raw_data/hourly_earnings_raw.csv"
)

write_csv(
  cpi_raw,
  "Data/raw_data/cpi_raw.csv"
)


head(wage_raw)
head(cpi_raw)