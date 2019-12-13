#!/bin/bash
#SBATCH --job-name=scatter_MPI
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=akella.v@ufl.edu
#SBATCH --account=eel6763
#SBATCH --qos=eel6763
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000mb
#SBATCH -t 00:05:00
#SBATCH -o Output
#SBATCH -e myerr
srun --mpi=pmix_v2 ./a.out