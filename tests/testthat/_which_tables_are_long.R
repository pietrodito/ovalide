library(ovalide)
library(purrr)

(champs <- c("mco", "had", "ssr", "psy"))
(statuts <- c("dgf", "oqn"))


((
  champs
  %>% map(function(.c) { map(statuts, function(.s) nature(.c, .s)) })
  %>% flatten()
) -> natures)

(
  natures
  %>% walk(load_ovalide_tables)
)
