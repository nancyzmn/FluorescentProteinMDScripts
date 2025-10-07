#!/bin/bash

module use /home/cruzeiro/modules
module load Amber/vinicius_develop

$AMBERHOME/bin/pmemd.cuda -O -i minimization.prod \
-o 2h5q_min1.out \
-p ../0-PAR/2h5q_mod.prmtop \
-c ../0-PAR/2h5q_init0.rst7 \
-r 2h5q_min1.rst7 \
-x 2h5q_min1.mdcrd \
-ref ../0-PAR/2h5q_init0.rst7

$AMBERHOME/bin/pmemd.cuda -O -i heating.prod \
-o 2h5q_heat2.out \
-p ../0-PAR/2h5q_mod.prmtop \
-c 2h5q_min1.rst7 \
-r 2h5q_heat2.rst7 \
-x 2h5q_heat2.mdcrd \
-ref 2h5q_min1.rst7

$AMBERHOME/bin/pmemd.cuda -O -i equilibration.prod \
-o 2h5q_equi3.out \
-p ../0-PAR/2h5q_mod.prmtop \
-c 2h5q_heat2.rst7 \
-r 2h5q_equi3.rst7 \
-x 2h5q_equi3.mdcrd \
-ref 2h5q_heat2.rst7
