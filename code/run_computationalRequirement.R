library(nimble)
source("autoBlock.R")
niter <- 50000
keepInd <- (niter/2 + 1):niter
dfcomputationalRequirement <- data.frame()
Nvalues <- c(2, 3)
for (dist in c("uni", "multi", "gamma")) {
    for (N in Nvalues) {
        if (dist == "uni") 
            candc <- createCodeAndConstants(N)
        if (dist == "multi") 
            candc <- createCodeAndConstants(N, list(1:N), 0)
        if (dist == "gamma") 
            candc <- createCodeAndConstants(N, gammaScalars = TRUE)
        code <- candc$code
        constants <- candc$constants
        data <- list()
        inits <- list(x = rep(1, N))
        Rmodel <- nimbleModel(code = code, constants = constants, data = data, inits = inits)
        nodeNames <- Rmodel$expandNodeNames("x", returnScalarComponents = TRUE)
        specList <- list()
        for (i in 1:3) specList[[i]] <- configureMCMC(Rmodel, nodes = NULL)
        for (node in nodeNames) specList[[1]]$addSampler("RW", list(targetNode = node), print = FALSE)
        specList[[2]]$addSampler("RW_block", list(targetNodes = nodeNames, adaptScaleOnly = TRUE), print = FALSE)
        specList[[3]]$addSampler("RW_block", list(targetNodes = nodeNames), print = FALSE)
        toCompileList <- list(Rmodel)
        for (i in 1:3) toCompileList[[i + 1]] <- buildMCMC(specList[[i]])
        compiledList <- compileNimble(toCompileList)
        Cmodel <- compiledList[[1]]
        Cmcmcs <- compiledList[2:4]
        timePer10kN <- numeric(0)
        for (i in 1:3) {
            Cmodel$setInits(inits)
            set.seed(0)
            timing <- as.numeric(system.time(Cmcmcs[[i]]$run(niter))[1])
            timePer10kN[i] <- timing/(niter/10000)
        }
        thisDF <- data.frame(N = rep(N, 3), dist = rep(dist, 3), blocking = c("scalar", "blockNoAdapt", "blockAdapt"), timePer10kN = timePer10kN)
        dfcomputationalRequirement <- rbind(dfcomputationalRequirement, thisDF)
        save(dfcomputationalRequirement, file = file.path("results", "results_computationalRequirement.RData"))
        cat("\n")
        print(dfcomputationalRequirement)
    }
}

