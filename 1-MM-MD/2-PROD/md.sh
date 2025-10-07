#!/bin/bash

ml Amber/22-GCC-9.3.0-CUDA-11.4.1 
export CUDA_VISIBLE_DEVICES=0
#mpirun -np 6 
$AMBERHOME/bin/pmemd.cuda -O -i mdin.prod \
-o 2h5q_md.out \
-p ../0-PAR-AMBER22/2h5q.prmtop \
-c ../1-MIN-AMBER22/2h5q_equi3.rst7 \
-r 2h5q_md.rst7 \
-x 2h5q_md.mdcrd \
-ref ../1-MIN-AMBER22/2h5q_equi3.rst7

