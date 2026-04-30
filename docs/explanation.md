# Mathematical Model: Cellular Automaton
We consider a 2D square lattice with fixed lattice spacing. To each lattice node we assign a cell state value: 0 - empty, 1 - mature cell, 2 - daughter cell. 

The time evolution of the cellular automaton is defined as follows: At each discrete time step, the cells are selected at random and given the opportunity to proliferate by the following rules:

1. Maturation: A cell that was a daughter cell (state 2) in the previous time step, becomes a mature cell (state 1).
2. Proliferation attempt: A proliferation event is initiated only if the cell's proliferation probability $P_p$ meets the condition: $P_p \geq R$, $R$ is a uniformly distributed random number on $[0,1]$.
3. Relocation attempt: 
    - If a cell at $(x,y)$ proliferates, it attempts to place daughter cells in one of four configurations with equal probability: (i) $(x-1,y)$ and $(x+1,y)$, (ii) $(x,y-1)$ and $(x,y+1)$ (iii) $(x-1,y+1)$ and $(x+1,y-1)$, (iv) $(x-1,y-1)$ and $(x+1,y+1)$ (*symmetric division process*). 
    - If the chosen configuration already contains an occupied site, the proliferation is aborted (*exclusion principle*).

<p align="left">
  <img src="assets/division_logic.svg" alt="Cell Division Logic">
  <br>
  <em>Figure 1: Cellular automaton transition rules. Lattice sites are color-coded: white (empty, state 0), black (mature, state 1), and red (daughter, state 2). During a simulation step, a cell either remains in its current state or undergoes symmetric division. In the latter case, the parent cell is replaced by two daughter cells occupying one of four possible spatial configurations.</em>
</p>


# MATLAB Implementation Details: Visualization & Data Integrity
Developing a reliable simulation requires more than just correct mathematical logic; the translation of data into visual frames must be consistent to ensure the integrity of the generated time-lapse.

## Consistent Frame Export via `imwrite`
While MATLAB’s print or saveas functions are common for quick exports, they depend on the active figure window's state and resolution. This can lead to "flickering" or slight shifts in image dimensions if the window is resized during execution.
- **Solution**: We utilize `imwrite` on the raw matrix data.
- **Impact**: This ensures that every exported frame (results/img-cell-growth_xx.png) has a fixed pixel resolution, providing a stable, jitter-free input for the Python-based video processing pipeline.

## Color Mapping Integrity (`CDataMapping`)
A common "gotcha" in MATLAB visualization is the default scaled color mapping. When the simulation starts with only a few cells, the automatic scaling might map the first cell (State 1) to the maximum color value (red) instead of the intended mature state (black).

- **Solution**: The property `'CDataMapping', 'direct'` is enforced.
- **Impact**: This ensures that the integer states `(0, 1, 2)` always map directly to the defined indices in our colormap (White, Black, Red), maintaining visual consistency from the very first frame (t=0).

# Python Implementation Details
To optimize for web performance and keep the documentation lightweight, I implemented a sampling algorithm to reduce the GIF size while maintaining the visual narrative of the simulation.