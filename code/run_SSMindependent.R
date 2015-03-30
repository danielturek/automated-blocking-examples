source("autoBlock.R")
load(file.path("data", "model_SSMindependent.RData"))
dfSSMindependent <- autoBlock(code, constants, data, inits, 2e+05, runList)$summary
save(dfSSMindependent, file = file.path("results", "results_SSMindependent.RData"))

