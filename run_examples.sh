#!/bin/bash

echo "running sampling efficiency simulation..."
R CMD BATCH --vanilla code/run_samplingEfficiency.R

echo "running computational requirements simulation..."
R CMD BATCH --vanilla code/run_computationalRequirement.R

echo "running varying blocks of fixed correlation model..."
R CMD BATCH --vanilla code/run_varyingBlksFixedCorr.R

echo "running fixed blocks of varying correlation model..."
R CMD BATCH --vanilla code/run_fixedBlksVaryingCorr.R

echo "running random effects model..."
R CMD BATCH --vanilla code/run_litters.R

echo "running auto-regressive model..."
R CMD BATCH --vanilla code/run_ice.R

echo "running state space independent model..."
R CMD BATCH --vanilla code/run_SSMindependent.R

echo "running state space correlated model..."
R CMD BATCH --vanilla code/run_SSMcorrelated.R

echo "running spatial model..."
R CMD BATCH --vanilla code/run_spatial.R

echo "running GLMM model..."
R CMD BATCH --vanilla code/run_mhp.R

echo "running test model..."
R CMD BATCH --vanilla code/run_test.R
