source("autoBlock_utils.R")
load(file.path("data", "model_test.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "test"
dftest <- createDFfromABlist(abList, niter)
dftest_summary <- printMinTimeABS(dftest, round = FALSE)
save(dftest, dftest_summary, file = file.path("results", "results_test.RData"))

