source("autoBlock.R")
load(file.path("data", "model_litters.RData"))
dflitters <- autoBlock(code, constants, data, inits, 2e+05, runList)$summary
save(dflitters, file = file.path("results", "results_litters.RData"))

