source("autoBlock_utils.R")
load(file.path("data", "model_spatial.RData"))
niter <- 2e+05
control <- list(niter = niter)
ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
ab$run(runList)
abList <- list(ab)
names(abList) <- "spatial"
dfspatial <- createDFfromABlist(abList, niter)
dfspatial_summary <- printMinTimeABS(dfspatial, round = FALSE)
save(dfspatial, dfspatial_summary, file = file.path("results", "results_spatial.RData"))

