library(nimble)
source("autoBlock.R")
k <- 6
N <- 2^k
rhoVector <- c(0.2, 0.5, 0.8)
niter <- 50000
runList <- list("all", "auto")
dfVaryingBlksFixedCorr <- NULL
for (rho in rhoVector) {
    blockLengths <- c(1, 2^(0:(k - 1)))
    indList <- list()
    cur <- 1
    for (len in blockLengths) {
        indList <- c(indList, list(cur:(cur + len - 1)))
        cur <- cur + len
    }
    data <- list()
    inits <- list(x = rep(0, N))
    codeAndConstants <- createCodeAndConstants(N, indList, rep(rho, length(indList)))
    code <- codeAndConstants$code
    constants <- codeAndConstants$constants
    dfTEMP <- autoBlock(code = code, constants = constants, data = data, inits = inits, niter = niter, run = runList)$summary
    dfTEMP <- cbind(data.frame(rho = rho), dfTEMP)
    if (is.null(dfVaryingBlksFixedCorr)) 
        dfVaryingBlksFixedCorr <- dfTEMP
    else dfVaryingBlksFixedCorr <- rbind(dfVaryingBlksFixedCorr, dfTEMP)
}
save(dfVaryingBlksFixedCorr, file = file.path("results", "results_varyingBlksFixedCorr.RData"))

