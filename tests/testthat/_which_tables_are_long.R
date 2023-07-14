library(ovalide)
library(purrr)

(champ <- c("mco", "had", "ssr", "psy"))
(statut <- c("dgf", "oqn"))

walk(champ, function(.c) {
  walk(statut, function(.s) {
    read_ovalide_tables(.c, .s)
  })
})


