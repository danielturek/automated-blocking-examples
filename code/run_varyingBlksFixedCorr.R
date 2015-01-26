library(nimble)
source("autoBlock_utils.R")
k <- 3
N <- 2^k
rhoVector <- c(0.2)
niter <- 2e+05
control <- list(niter = niter)
runList <- list("all", "auto")
abList <- list()
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
    ab <- autoBlock(code = code, constants = constants, data = data, inits = inits, control = control)
    ab$run(runList)
    abList[[paste0("varyingBlksFixedCorr", rho)]] <- ab
}
dfVaryingBlksFixedCorr <- createDFfromABlist(abList, niter)
dfVaryingBlksFixedCorr$rho <- as.numeric(gsub(".*Corr(.+)", "\\1", dfVaryingBlksFixedCorr$model))
dfVaryingBlksFixedCorr_summary <- printMinTimeABS(dfVaryingBlksFixedCorr, round = FALSE)
save(dfVaryingBlksFixedCorr, dfVaryingBlksFixedCorr_summary, file = file.path("results", "results_varyingBlksFixedCorr.RData"))

