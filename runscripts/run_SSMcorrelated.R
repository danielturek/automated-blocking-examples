source("~/GitHub/automated-blocking-examples/autoBlock_utils.R")
load("~/GitHub/automated-blocking-examples/modelfiles/model_SSMcorrelated.RData")
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "SSMcorrelated"
dfSSMcorrelated <- createDFfromABlist(abList, niter)
dfSSMcorrelated_summary <- printMinTimeABS(dfSSMcorrelated, round = FALSE)
save(dfSSMcorrelated, dfSSMcorrelated_summary, file = "~/GitHub/automated-blocking-examples/results/results_SSMcorrelated.RData")

