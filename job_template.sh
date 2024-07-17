#!/bin/bash

#SBATCH --partition=amilan
#SBATCH --job-name=cnrp
#SBATCH --output=cnrp-job.%j.out
#SBATCH --time=1:00:00
#SBATCH --qos=normal
#SBATCH --nodes=2
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --mail-user=akhilsin@colostate.edu


module load anaconda
conda activate geospatial


papermill Boundary\ Raster\ Classification.ipynb output_2021.ipynb -p year 2021

