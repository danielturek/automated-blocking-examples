source("autoBlock_utils.R")
load(file.path("data", "model_SSMcorrelated.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "SSMcorrelated"
dfSSMcorrelated <- createDFfromABlist(abList, niter)
dfSSMcorrelated_summary <- printMinTimeABS(dfSSMcorrelated, round = FALSE)
save(dfSSMcorrelated, dfSSMcorrelated_summary, file = file.path("results", "results_SSMcorrelated.RData"))

