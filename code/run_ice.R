source("autoBlock_utils.R")
load(file.path("data", "model_ice.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "ice"
dfice <- createDFfromABlist(abList, niter)
dfice_summary <- printMinTimeABS(dfice, round = FALSE)
save(dfice, dfice_summary, file = file.path("results", "results_ice.RData"))

