#!/bin/bash

ml purge
module use /home/cruzeiro/modules
module load Amber/vinicius_develop

#mpirun -np 6 
$AMBERHOME/bin/pmemd.cuda -O -i pH7.5.mdin \
-o pH7.5.mdout \
-cpin ../0-PAR/2h5q.cpin \
-cpout pH7.5.cpout \
-cprestrt pH7.5.cpin \
-p ../0-PAR/2h5q_mod.prmtop \
-c ../1-MIN/2h5q_equi3.rst7 \
-r pH7.5.rst7 \
-x pH7.5.nc \
-ref ../1-MIN/2h5q_equi3.rst7

