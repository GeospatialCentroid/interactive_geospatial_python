# Geospatial Python Notebooks – Setup and Usage Guide

The following Jupyter notebooks have been adapted from the Carpentries material:  
Introduction to Geospatial Raster and Vector Data with Python  
https://carpentries-incubator.github.io/geospatial-python/

The following episodes are included:

- Episode 5: Access satellite imagery using Python  
- Episode 6: Read and visualize raster data  
- Episode 7: Vector data in Python  
- Episode 9: Raster Calculations in Python  

Each notebook is complete and ready for workshop instruction.

Special features:
- Interactive plots for selecting Points of Interest (POI) and Areas of Interest (AOI)
- NDVI classification across multiple years
- Outputs include GeoTIFF files and summary statistics for each year

---

## IMPORTANT REQUIREMENT

A conda environment named `geospatial` must be created before running these notebooks.

---

## BEFORE YOU BEGIN

1. Download this repository from GitHub:
   - Click the green **Code** button
   - Select **Download ZIP**
2. Unzip the folder to a location on your computer

---

## 1. Install Conda (Recommended)

Install Miniforge from:
https://conda-forge.org/download/

Download and install the latest version for your operating system.

---

## 2. Open Terminal or Miniforge Prompt

- Windows: Open **Miniforge Prompt**
- Mac: Open **Terminal**

---

## 3. Navigate to Your Project Directory

Use the `cd` command:

```bash
cd {project directory}
```

Tip:
- Type `cd ` (with a space)
- Drag your project folder into the terminal window
- Press ENTER to run the command

⚠️ IMPORTANT: You must press the ENTER key after typing each command in the terminal. Commands will NOT run until ENTER is pressed.

---

## 4. Create and Activate the Environment

```bash
conda env create -n geospatial --file geospatial.yaml
```

Press ENTER to execute.

Then activate:

```bash
conda activate geospatial
```

Press ENTER again.

---

## 5. Launch Jupyter Notebook

```bash
jupyter lab
```

Press ENTER to launch.

Your browser will open and allow you to run the notebooks.

---

## Alternate Installation (Anaconda)

If using Anaconda:

1. Open Anaconda Navigator
2. Click **Environments**
3. Click **Import**
4. Select the `geospatial.yaml` file
5. Keep the default environment name
6. Click **Import**
7. Select the new environment
8. Launch Jupyter Lab

---

## Additional Resources

Software setup guide:
https://carpentries-incubator.github.io/geospatial-python/index.html#software-setup

---

## Notes

- Ensure all commands are run inside the terminal using ENTER
- Do not skip environment creation
- If errors occur, verify you are in the correct directory

