# Script to schedule the jobs on a PBS cluster to run the simulation
# Set parameters based on available resources

#PBS -S /bin/bash
#PBS -j oe
#PBS -o output.txt
#PBS -m ae
#PBS -M xyz@abc.com 
#PBS -q dque
#PBS -l nodes=nn:ppn=pp
#PBS -l walltime=350:00:00
#PBS -N nerve_stimulation

source /etc/profile.modules
module load openmpi/openmpi-1.3.2-intel intel/intel-icc-ifort-Compiler-11.083

MPI_DIR=/apps/openmpi-1.3.2/bin
EXEC=/your_folder_here/x86_64/special
HOC=/your_folder_with_hoc_files/

echo pbs nodefile:
cat $PBS_NODEFILE
NPROCS=`wc -l < $PBS_NODEFILE`
cat $PBS_NODEFILE > host.list

echo Running job...
date
time
$MPI_DIR/mpiexec -np $NPROCS -hostfile host.list $EXEC -mpi $HOC/test_par.hoc
