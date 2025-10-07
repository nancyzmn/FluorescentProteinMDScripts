index=$1
qm=$2
abs=$3
mkdir "aims_${abs}"
cd ../3-QMMM-AMBER22/dft_${index}/prod
cp frame_${index}_${qm}_whole.rst7 frame_whole.rst7
cp frame_whole.rst7 2h5q_sphere_nobox.prmtop /data/nancyzmn/mCherry-Water/5-AIMS-AMBER22/aims_${abs}
cd ../../../4-ABS-AMBER22/${abs}
energy=$(grep "1  singlet" ./sp.chromo.out | tail -n 1 | awk '{print $3}')
i=$(echo "${energy} * -1" | bc)
echo "Ground state energy is ${i}"
cd scr.cas.chromo
cp c0.casscf /data/nancyzmn/mCherry-Water/5-AIMS-AMBER22/aims_${abs}
cd ../../../5-AIMS-AMBER22
cp Control.dat misc_options convert_to_geomdat.py run.sh submit.sbatch region.qm ./aims_${abs}
cd ./aims_${abs}
mkdir "output"
mv convert_to_geomdat.py ./output #Prepare initial conditions (coordinates and velocities)
cp frame_whole.rst7 ./output
cd ./output
python3 convert_to_geomdat.py -p ../2h5q_sphere_nobox.prmtop -r ../ -o ./ 
cd output
mv Geometry.dat ../../
cd ../../
rm -r output
sed -i "s/X/${i}/g" Control.dat #Put the ground state energy at ExShift in Control.dat
