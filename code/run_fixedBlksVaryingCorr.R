library(nimble)
source("autoBlock_utils.R")
Nvalues <- c(20)
niter <- 2e+05
control <- list(niter = niter)
runList <- list("all", "auto")
abList <- list()
for (N in Nvalues) {
    blockSize <- N/10
    numberOfBlocks <- 9
    indList <- lapply(((1:numberOfBlocks) - 1) * blockSize, function(x) x + (1:blockSize))
    rhoVector <- seq(from = 0.9, to = 0.1, by = -0.1)
    codeAndConstants <- createCodeAndConstants(N, indList, rhoVector)
    code <- codeAndConstants$code
    constants <- codeAndConstants$constants
    data <- list()
    inits <- list(x = rep(0, N))
    ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
    ab$run(runList)
    abList[[paste0("fixedBlksVaryingCorrN", N)]] <- ab
}
dfFixedBlksVaryingCorr <- createDFfromABlist(abList, niter)
dfFixedBlksVaryingCorr$N <- as.numeric(gsub(".*N(.+)", "\\1", dfFixedBlksVaryingCorr$model))
dfFixedBlksVaryingCorr$model <- gsub("fixedBlksVaryingCorr", "", dfFixedBlksVaryingCorr$model)
dfFixedBlksVaryingCorr$model <- gsub("N([23456789]0)$", "N0\\1", dfFixedBlksVaryingCorr$model)
dfFixedBlksVaryingCorr_summary <- printMinTimeABS(dfFixedBlksVaryingCorr, round = FALSE)
save(dfFixedBlksVaryingCorr, dfFixedBlksVaryingCorr_summary, file = file.path("results", "results_fixedBlksVaryingCorr.RData"))

