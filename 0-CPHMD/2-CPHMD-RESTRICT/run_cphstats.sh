#Trajectory Chunk Average
cphstats -i ../0-PAR/2h5q.cpin --chunk 500000 ./pH7.5.cpout

#Trajectory Cumulative Average
cphstats -i ../0-PAR/2h5q.cpin --cumulative --cumulative-out cum.7.5.dat ./pH7.5.cpout
