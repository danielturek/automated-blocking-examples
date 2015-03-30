source("autoBlock.R")
load(file.path("data", "model_SSMcorrelated.RData"))
dfSSMcorrelated <- autoBlock(code, constants, data, inits, 2e+05, runList)$summary
save(dfSSMcorrelated, file = file.path("results", "results_SSMcorrelated.RData"))

