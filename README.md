# FluorescentProteinMDScripts
This repo contains scripts for fluorescent protein simulation workflow. 

```0-CPHMD```
Scipts to run discrete CpHMD in explicit solvent (at pH=7.5) using AMBER. 

```1-MM-MD```
Scripts to run classical MD in explicit solvent (fixed protonation states) using AMBER

```2-QMMM```
Scripts to run QM/MM-MD to relax geometries sampled from classical MM using TeraChem & AMBER.

```3-AIMS```
Scripts to run QM/MM nonadiabatic dynamics using TeraChem & FMS

## Requirements

AMBER (in the example we're using a customized version to include a large number of titratable residues; newer versions of AMBER could handle them)

TeraChem (for QM/MM coupling and AIMS electronic structure)
