source("~/GitHub/automated-blocking-examples/autoBlock_utils.R")
load("~/GitHub/automated-blocking-examples/modelfiles/model_ice.RData")
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "ice"
dfice <- createDFfromABlist(abList, niter)
dfice_summary <- printMinTimeABS(dfice, round = FALSE)
save(dfice, dfice_summary, file = "~/GitHub/automated-blocking-examples/results/results_ice.RData")

