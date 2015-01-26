source("autoBlock_utils.R")
load(file.path("data", "model_SSMindependent.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "SSMindependent"
dfSSMindependent <- createDFfromABlist(abList, niter)
dfSSMindependent_summary <- printMinTimeABS(dfSSMindependent, round = FALSE)
save(dfSSMindependent, dfSSMindependent_summary, file = file.path("results", "results_SSMindependent.RData"))

