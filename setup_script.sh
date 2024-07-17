#!/bin/bash

#SBATCH --job-name=gsw-flight-test
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --partition=amilan
#SBATCH --time=00:15:00
#SBATCH --mail-type=ALL
# Removed --mail-user for default behaviour

# Description: This script is designed for conducting flight tests for gsw.
# Author: AKHIL SINGAMPALLI
# Date: [Date of Creation]

##################################
##### How to Use this Script #####
## Run it in the background and look at the output file
# sbatch gsw-flight-test.sh
# ls -alt | head -n 3

## Run it interactively and watch output in the terminal

# give permission to execute file
# chmod 755 gsw-flight-test.sh
# acompile
# ./gsw-flight-test.sh

## another way to run interactively with more granular control
# sinteractive --reservation=XYZ --time=1:00:00 --partition=amilan -N 1 -n 1
##################################

# Initialize Debug Mode to false
debug_mode=false

# Function Definitions
print_help() {
    echo "Usage: $0 [options]"
    echo "-h, --help            Show this help message"
    echo "-d, --debug           Enable debug mode"
    # ... [other options] ...
    echo
    echo " This script is designed to create conda env for geospatial-workshop."
    echo "  
    ---- How to Use this Script ----
    ## Run it in the background and look at the output file
    #  sbatch gsw-flight-test.sh
    #  ls -alt | head -n 3

    ## Run it interactively and watch output in the terminal

    # give permission to execute file
    # chmod 755 gsw-flight-test.sh
    # acompile
    # ./gsw-flight-test.sh"
    echo 
}

# Check for flags
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--debug) debug_mode=true ;;
        -h|--help) print_help; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

########
## Verify and Explain Alpine Directories
###########
# Verifying Alpine Directories
echo "#########################"
echo "Learn more about directories and their paths"
echo "#########################"
echo "Your HOME directory ($HOME) has 2GB in capacity."
echo "Your PROJECT directory (/project/$USER) has 250GB in capacity."
echo "Your SCRATCH directory (/scratch/alpine/$USER) has 10TB in capacity. **Files are purged after 90-days of inactivity!**"
echo "Your temp (TMPDIR) directory ($TMPDIR) is a staging ground for package files and libraries when installing new software."
echo "#########################"

# Get the available space on /tmp in gigabytes
available_space_gb=$(df -h /tmp | awk 'NR==2 {print $4}' | tr -d 'G')

# Set a threshold for available space (adjust as needed)
threshold_gb=2  # This is 2 GB, you can adjust it based on your requirements

# Check if available space is below the threshold
if (( $(echo "$available_space_gb < $threshold_gb" | bc -l) )); then
  echo "/tmp directory is almost full. Available space: $available_space_gb G"

  # Set TMP to a new directory
  new_tmp_directory="/scratch/alpine/$USER"
  export TMP="$new_tmp_directory"

  echo "TMP environment variable set to: $new_tmp_directory"
else
  echo "/tmp directory has sufficient space. Available space: $available_space_gb G"
fi

if [[ "$debug_mode" = true ]]; then
    echo "#########################"
    echo "Debug Mode: Displaying .bashrc contents:"
    echo "Your bashrc files contain default scripts and paths information on login. This can be helpful for troubleshooting. The output of this file is here: "
    echo "#########################"
    cat ~/.bashrc
    echo "#########################"
fi

echo ""
echo "#########################"
echo "Check if on a login node"
echo "#########################"
echo ""

# Check if on a login node
if [[ "$(hostname)" =~ ^login ]]; then
  echo "You are on a login node, the following script module load test will likely fail."
  echo "Please type 'acompile' to switch to another node type"
  # code block to execute if string matches regex pattern
else
  # code block to execute if string does not match regex pattern
  echo "You are not on a login node. Great choice! Now you can run different software modules."

  # Begin cloning workshop git repo and creating env
  echo ""
  echo "#########################"
  echo "Cloning Git Repo"
  echo "#########################"
  echo "Workshop git repo containing jupyter notebooks is being cloned to your /project/$USER directory"
  echo "This might take a couple minutes."
  echo "#########################"
  echo ""

  # Clean up any loaded modules
  module purge
  module load anaconda
  module load mambaforge

  # Define the content to append
  content="pkgs_dirs:
  - /projects/\$USER/.conda_pkgs
envs_dirs:
  - /projects/\$USER/software/anaconda/envs"

  # Ensure .condarc exists and then append the content if necessary
  condarc_file="$HOME/.condarc"
  touch "$condarc_file"
  if ! grep -Fxq "pkgs_dirs:" "$condarc_file"; then
    echo "$content" >> "$condarc_file"
    echo ".condarc file updated"
  else
    echo ".condarc file already contains necessary entries"
  fi

  # Git clone workshop repo if it doesn't already exist
  if [ ! -d "/projects/$USER/interactive_geospatial_python" ]; then
    cd /projects/$USER/
    git clone https://github.com/GeospatialCentroid/interactive_geospatial_python.git
    echo "Git repo cloned"
  else
    echo "Git repo already exists"
  fi

  cd /projects/$USER/interactive_geospatial_python

  echo ""
  echo "#########################"
  echo "Creating Conda env"
  echo "#########################"
  echo "Conda env is being created using geospatial_environment.yaml file in the workshop git repo"
  echo "This might take a couple minutes."
  echo "#########################"
  echo ""

  # Create env if it doesn't already exist
  if ! conda env list | grep -q "geospatial-env"; then
    mamba env create -f environment.yaml
    echo "Conda environment created"
  else
    echo "Conda environment already exists"
  fi

  # Check for env
  conda info --env
fi

echo "Script execution completed."