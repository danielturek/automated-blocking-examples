library(nimble)
source("autoBlock.R")
Nvalues <- c(20, 30, 50)
niter <- 50000
runList <- list("all", "auto")
dfFixedBlksVaryingCorr <- NULL
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
    dfTEMP <- autoBlock(code = code, constants = constants, data = data, inits = inits, niter = niter, run = runList)$summary
    dfTEMP <- cbind(data.frame(N = N), data.frame(model = paste0("N", N)), dfTEMP)
    if (is.null(dfFixedBlksVaryingCorr)) 
        dfFixedBlksVaryingCorr <- dfTEMP
    else dfFixedBlksVaryingCorr <- rbind(dfFixedBlksVaryingCorr, dfTEMP)
}
save(dfFixedBlksVaryingCorr, file = file.path("results", "results_fixedBlksVaryingCorr.RData"))

