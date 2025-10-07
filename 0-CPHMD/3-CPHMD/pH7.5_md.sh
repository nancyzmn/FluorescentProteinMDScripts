#!/bin/bash

ml purge
module use /home/cruzeiro/modules
module load Amber/vinicius_develop

#mpirun -np 6 
$AMBERHOME/bin/pmemd.cuda -O -i pH7.5.mdin \
-o pH7.5.mdout \
-cpin ../2-CPHMD-RESTRICT/pH7.5.cpin \
-cpout pH7.5.cpout \
-cprestrt pH7.5.cpin \
-p ../0-PAR/2h5q_mod.prmtop \
-c ../2-CPHMD-RESTRICT/pH7.5.rst7 \
-r pH7.5.rst7 \
-x pH7.5.nc \
-ref ../2-CPHMD-RESTRICT/pH7.5.rst7

