source("~/GitHub/automated-blocking-examples/autoBlock_utils.R")
load("~/GitHub/automated-blocking-examples/modelfiles/model_mhp.RData")
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "mhp"
dfmhp <- createDFfromABlist(abList, niter)
dfmhp_summary <- printMinTimeABS(dfmhp, round = FALSE)
save(dfmhp, dfmhp_summary, file = "~/GitHub/automated-blocking-examples/results/results_mhp.RData")

