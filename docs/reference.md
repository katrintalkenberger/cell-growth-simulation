# Reference Guide: Cell Growth Simulation
This document provides a technical overview of the parameters, data structures, and external sources used in the simulation.

## 1. MATLAB simulation (`src/simulateCellGrowth`)
The MATLAB simulation is developed and tested on MATLAB R2026a and GNU Octave 11.1. It is compatible with most versions supporting basic matrix operations and imwrite.

### 1.1. Lattice & State Definitions
The simulation operates on a discrete 2D square lattice.

| Value | State | Description |
| ----------- | ----------- | ----------- |
| 0 | Empty | Lattice node is unoccupied. |
| 1 | Mature | A cell capable of proliferation. |
| 2 | Daughter | A newly created cell; undergoes maturation in the next step. |


### 1.2. Configuration Parameters
The simulation configuration parameters are defined in the `src/simulateCellGrowth.m` file.

| Parameter | Type | Default | Description |
| ----------- | ----------- | ----------- | ----------- |
| `dim` | Integer | 100 | Dimension of square lattice (`dim` $\times$ `dim`). |
| `steps` | Integer | 50 | Number of discrete time simulation steps (`steps` $\in \mathbb{N}$). |
| `growthProb` | Float | 0.5 | Cell proliferation probability (Range: $0 \leq$ `growthProb` $\leq 1.0$) |

## 2. Python Gif Tool (`tools/generate_gif.py`)
Technical details for the post-processing automation script.

Requirements
- Python: 3.10+
- Libraries: imageio

The automation tool supports GIF generation via imageio. For future high-resolution MP4 exports, the pipeline is prepared to integrate OpenCV.

Arguments:
- `--input`: Path to the image folder (default: results/).
- `--output`: Name of the generated file (default: simulation.mp4).
- `--fps`: Frames per second (default: 10).


## 4. Bibliography & Research Sources
The implementation is based on the following scientific literature:
**Simpson, M. J., Landman, K. A., & Hughes, B. D. (2007)**. *Multi-species simulation of cell growth and migration.* Physical Review E, 76(2), 021908.

- [Simpson et al. (2007), Physical Review E.](https://researchers.ms.unimelb.edu.au/~barrydh@unimelb/Simpson-et-al-PRE-2007.pdf)
- Focus: Computational tool to replicate both the population-scale and cell-scale properties of invasive cell populations. 