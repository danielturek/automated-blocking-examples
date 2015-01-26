source("autoBlock_utils.R")
load(file.path("data", "model_mhp.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "mhp"
dfmhp <- createDFfromABlist(abList, niter)
dfmhp_summary <- printMinTimeABS(dfmhp, round = FALSE)
save(dfmhp, dfmhp_summary, file = file.path("results", "results_mhp.RData"))

