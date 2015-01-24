source("~/GitHub/automated-blocking-examples/autoBlock_utils.R")
load("~/GitHub/automated-blocking-examples/modelfiles/model_litters.RData")
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "litters"
dflitters <- createDFfromABlist(abList, niter)
dflitters_summary <- printMinTimeABS(dflitters, round = FALSE)
save(dflitters, dflitters_summary, file = "~/GitHub/automated-blocking-examples/results/results_litters.RData")

