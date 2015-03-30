source("autoBlock.R")
load(file.path("data", "model_spatial.RData"))
dfspatial <- autoBlock(code, constants, data, inits, 2e+05, runList)$summary
save(dfspatial, file = file.path("results", "results_spatial.RData"))

