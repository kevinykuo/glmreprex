library(magrittr)
library(purrr)

# Get data
# remotes::install_github("ropensci/piggyback")
# piggyback::pb_download("data/train_set_severity.rds")

train_set_severity <- readRDS("data/train_set_severity.rds")
# OK
m1_severity <- glm(
  severity ~ log1p_average_insured_amount,
  data = train_set_severity,
  weights = train_set_severity$claim_count,
  family = Gamma(link = "log")
)

# OK
m1_severity <- glm(
  severity ~ log1p_vehicle_age,
  data = train_set_severity,
  weights = train_set_severity$claim_count,
  family = Gamma(link = "log")
)

# Not OK
m1_severity <- glm(
  severity ~ log1p_average_insured_amount + log1p_vehicle_age,
  data = train_set_severity,
  weights = train_set_severity$claim_count,
  family = Gamma(link = "log")
)

train_set_severity %>% 
  map(~ any(is.na(.x)) || any(is.nan(.x)) || any(is.infinite(.x)))
