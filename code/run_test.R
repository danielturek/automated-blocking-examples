source("autoBlock.R")
load(file.path("data", "model_test.RData"))
dftest <- autoBlock(code, constants, data, inits, 2e+05, runList)$summary
save(dftest, file = file.path("results", "results_test.RData"))

