#!/bin/bash

$AMBERHOME/bin/sander -O -i mdin_qmmm.prod \
-o test.out \
-p mod.prmtop \
-c coors.rst7 \
-r test.rst7 \
-x test.mdcrd \
-ref coors.rst7

