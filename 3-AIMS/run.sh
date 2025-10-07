#!/usr/bin/env bash

mkdir -p /tmp/terachem
cp /pscratch/sd/n/nancyzmn/license.key /tmp/terachem/
cp -r /software/terachem/basis /tmp/terachem/
cp -r /software/terachem/grid /tmp/terachem/
export TeraChem="/tmp/terachem"
MPI_ADDITIONAL_ARGUMENT="-nameserver localhost"

# Generate random port number to avoid conflicts
# Initialize server
server=tcfms_port$[ ( $RANDOM % 10000 ) + 1]
printf "&tc\nserver_name = $server" > tc_input

# Connecting the two processes on the server
if [ -z $(ps aux | grep hydra_nameserver | grep -v "grep" | awk '{print $2}') ]; then hydra_nameserver & sleep 5; fi

# mpiexec.hydra seems to be the most effective way to start the two processes
mpiexec.hydra $MPI_ADDITIONAL_ARGUMENT -n 1 terachem -U2 --MPIPort=$server > tc.out &
PID1=$!

sleep 5

mpiexec.hydra $MPI_ADDITIONAL_ARGUMENT -n 1 FMS.tc.e > fms.out &
PID2=$!

# Should be replace with "wait -n" once we have bash 4.3
while ( (kill -0 $PID1 >& /dev/null) && (kill -0 $PID2 >& /dev/null) ); do sleep 1; echo "Waiting..."; done

# The following logic is not robust against OS pid resue!
if ! (kill -0 $PID1 >& /dev/null); then
    wait $PID1; RETURN1=$?; echo "1 exit, return = $RETURN1";
    if [ $RETURN1 -ne 0 ]; then
        kill $PID2; wait $PID2; RETURN2=$?; echo "2 killed, return = $RETURN2";
    fi
elif ! (kill -0 $PID2 >& /dev/null); then
    wait $PID2; RETURN2=$?; echo "2 exit, return = $RETURN2";
    if [ $RETURN2 -ne 0 ]; then
        kill $PID1; wait $PID1; RETURN1=$?; echo "1 killed, return = $RETURN1";
    fi
fi

