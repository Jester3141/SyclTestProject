#!/bin/bash
#SBATCH --account=soc-gpu-np
#SBATCH --partition=soc-gpu-np
#SBATCH --job-name=cs6235
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=00:5:00
#SBATCH --export=ALL
#SBATCH --qos=soc-gpu-np

module load intel-oneapi-compilers/2023.0.0 intel-oneapi-tbb cuda/11.8.0
./build/cnn-app