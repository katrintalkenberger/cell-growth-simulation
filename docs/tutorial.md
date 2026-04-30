# Run the cell growth simulation

This tutorial explains how to set up and run a cell growth simulation in **MATLAB Online** to generate visual growth data. **MATLAB Online** is free to use for up to 20 hours per month after registration without any local installation. 

If you have a valid MATLAB license, you can run the simulation `src/simulateCellGrowth.m` right away.

Alternatively, the simulation can also be run using the open source tool **GNU Octave**. In this case no MATLAB license or MathWorks registration is necessary. Simply install the latest [GNU Octave](https://octave.org/download) version, navigate to the `src/` folder and run the script.

## Setting Up the Simulation Environment
Follow these steps to configure the script in MATLAB Online:

1. **Sign in:** 
   * Got to [MATLAB](matlab.mathworks.com) and sign in with a MathWorks account (or create one).
   <img src="assets/matlab_setup_sign_in.svg" width="600" alt="Sign in to MATLAB Online">
   * Open [MATLAB Online](http://www.mathworks.com/products/matlab-online.html).
     <img src="assets/matlab_setup_open.svg" width="600" alt="Open MATLAB Online">
  
2. **Create folder structure:**
   The requested simulation folder structure is:
   ```
   cell-growth-simulation/
   │
   ├── /src                      # MATLAB source folder
   │   ├── simulateCellGrowth.m  # MATLAB cell growth function
   ├── /results                  # Folder to save simulation images
   ```
   You can either download this GitHub repository to your local machine and upload the folder `cell-growth-simulation/` to your [MATLAB Drive](mathworks.com/help/matlab/matlab_env/access-methods.html). Or you can create the folder structure manually:

   * Create a new directory via `New` -> `Folder`: `cell-growth-simulation`.
     <img src="assets/matlab_setup_create_folder.svg" width="600" alt="Create new MATLAB folder">
   * Navigate to this folder and create two subfolders: `src` and `results`.
     <img src="assets/matlab_setup_create_subfolder.svg" width="600" alt="Create new MATLAB subfolders"> 

3. **Configure the path:**
   * Right-click the `cell-growth-simulation` folder.
   * Select `Add to path` -> `Selected Folder(s) and Subfolders`. 
   * *Note: This ensures that MATLAB recognizes all dependencies and locations.*
   <img src="assets/matlab_setup_add_to_path.svg" width="600" alt="Add folders to MATLAB path"> 

4. **Import script:**
   * Select `New` -> `Script`.
   <img src="assets/matlab_setup_new_script.svg" width="600" alt="Create new MATLAB script">
   * Copy the contents of the file `src/simulateCellGrowth.m` from this repository into the MATLAB Online editor.
   * Save the file as `cell-growth-simulation/src/simulateCellGrowth.m`.
   <img src="assets/matlab_setup_save_as.svg" width="600" alt="Save new script to src/ folder">

5. **Start the simulation:**
   * In the Editor tab, make sure the `simulateCellGrowth.m` is the active tab, then click the `Run` button (or press `F5`).
   <img src="assets/matlab_setup_run.svg" width="600" alt="Run MATLAB simulation">

6. **Verify results**
   * Visual Output: A figure window should appear displaying the 2D grid of the cell growth.
   <img src="assets/matlab_setup_simulation.svg" width="600" alt="Visual MATLAB output">
   * Data Output: For each simulation step, an image is saved as *.png files in the results/ folder.
   <img src="assets/matlab_setup_results.svg" width="600" alt="MATLAB data output">
   * *Note: All files in MATLAB Online are stored in MATLAB Drive, not your local computer. To get folders back to your local machine (for example to generate an animated GIF using `tools/generate_gif.py`), right-click the folder in the Files panel and select Download.*

## Next steps
With the images you can proceed to the [How-to Guide](how-to-guide.md) to generate an animated GIF for the cell growth.