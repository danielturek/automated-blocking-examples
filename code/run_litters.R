source("autoBlock_utils.R")
load(file.path("data", "model_litters.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "litters"
dflitters <- createDFfromABlist(abList, niter)
dflitters_summary <- printMinTimeABS(dflitters, round = FALSE)
save(dflitters, dflitters_summary, file = file.path("results", "results_litters.RData"))

