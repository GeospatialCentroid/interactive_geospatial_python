#!/bin/bash

#SBATCH --partition=amilan
#SBATCH --job-name=cnrp
#SBATCH --output=cnrp-job.%j.out
#SBATCH --time=0:15:00
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=kevin.worthington@colostate.edu


module load anaconda
conda activate geospatial


papermill 5_Boundary\ Raster\ Classification_complete.ipynb -p year 2021

