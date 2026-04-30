# How to customize simulation parameters

You can adjust the lattice size, simulation time and the growth probability either by modifying the source code or by passing arguments to the function.

## Method 1: Modifying the code
To change the default growth rate, open `src/simulateCellGrowth.m` and locate the input parameter check section:

```matlab
   %% INPUT PARAMETER CHECK
   % Growth rate shall be a number between 0 and 1
   (...)
      % Set growth probability default value
      growthProb = 0.5;
```

The lattice size and simulation time can be changed in the initialization section:

```matlab
   %% INITIALIZATION
   % Set simulation time steps
   steps = 50;
   % Set lattice dimension
   dim = 100;
```

### Method 2: Passing parameters via Command Line
For the growth probability, you can override the default value directly when calling the function in the MATLAB Command Window:

```matlab
% Run simulation with a 80% growth probability
simulateCellGrowth(0.8)
```

*Note: The lattice size and simulation time currently remains controlled by the `dim` and `steps` variables within the script.*


# How to generate an animated GIF from simulation frames

This guide explains how to use the provided Python tool to convert the exported MATLAB simulation images into a single animated GIF.

## Prerequisites
- Python 3.10+ installed on your system.
- The required libraries installed: `pip install -r requirements.txt`.

## Steps

The Python script is pre-configured to look for images in the `results/` folder and save the GIF in the project root.

1. **Navigate to the project root:**
   ```bash
   cd path/to/cell-growth-simulation
   ```

2. **Run the script:**
   ```bash
   python tools/generate_gif.py
   ```

3. **Check the output:**
   The file `simulation_cell_growth.gif` will be created in your current directory.


## Customization
You can adjust the speed of the animation by changing the duration argument in the call of the main routine:

```python
    # Call main routine
    create_simulation_gif(
        source_folder=simulation_results_folder,
        output_path=gif_output_file,
        duration_s=0.1 # duration in seconds per frame (duration of 0.1 seconds corresponds to 10 FPS)
    )
```

A lower value results in a faster animation (e.g., 0.05s), while a higher value slows it down.