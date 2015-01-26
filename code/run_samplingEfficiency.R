library(nimble)
library(coda)
source("autoBlock_utils.R")
kValues <- 0:1
Nvalues <- c(2, 4)
niter <- 2e+05
keepInd <- (niter/2 + 1):niter
dfsamplingEfficiency <- data.frame()
for (expDecay in c(FALSE, TRUE)) {
    for (k in kValues) {
        for (N in Nvalues) {
            rho <- 1 - (1 - 0.8)^k
            candc <- createCodeAndConstants(N, list(1:N), rho, expDecay = expDecay)
            code <- candc$code
            constants <- candc$constants
            data <- list()
            inits <- list(x = rep(0, N))
            Rmodel <- nimbleModel(code = code, constants = constants, data = data, inits = inits)
            nodeNames <- Rmodel$expandNodeNames("x", returnScalarComponents = TRUE)
            spec <- configureMCMC(Rmodel, nodes = NULL)
            for (node in nodeNames) spec$addSampler("RW", list(targetNode = node), print = FALSE)
            Rmcmc <- buildMCMC(spec)
            compiledList <- compileNimble(list(Rmodel, Rmcmc))
            Cmodel <- compiledList[[1]]
            Cmcmc <- compiledList[[2]]
            Cmodel$setInits(inits)
            set.seed(0)
            timing <- as.numeric(system.time(Cmcmc$run(niter))[1])
            timePer10kN <- timing/(niter/10000)
            samples <- as.matrix(Cmcmc$mvSamples)
            samples <- samples[keepInd, , drop = FALSE]
            ess <- apply(samples, 2, effectiveSize)
            meanESS <- mean(ess)
            essPerN <- meanESS/length(keepInd)
            thisDF <- data.frame(expDecay = expDecay, k = k, rho = rho, N = N, timePer10kN = timePer10kN, essPerN = essPerN)
            dfsamplingEfficiency <- rbind(dfsamplingEfficiency, thisDF)
            save(dfsamplingEfficiency, file = file.path("results", "results_samplingEfficiency.RData"))
        }
    }
}

