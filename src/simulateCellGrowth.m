function simulateCellGrowth(growthProb,isSavingEnabled)
% SIMULATECELLGROWTH Function to simulate a cellular automaton for cell growth.
% The simulation operates on a square 2D lattice where each site can host a single cell. 
% At each time step, every cell attempts to proliferate with a predefined probability. 
% The daughter cells attempt to move in opposite directions from the parent cell. If any 
% of the attempted new sites is already occupied, the poliferation event is aborted to 
% maintain the exclusion principle.
% Based on Simpson et al. (2007), Physical Review E.
%
% Inputs:
%   growthProb      : probabilty of cell proliferation in the range [0,1]
%   isSavingEnabled : boolean indicating each simulation step is saved as image (for GIF generation)
%
% Outputs:
%   None
%
% --- Assumptions & Constraints ---
% 1. Boundary Conditions: The simulation assumes zero-flux boundary conditions. 
%    Proliferation events attempting to place cells outside the lattice [1, dim] are 
%    automatically aborted by the exclusion principle (boundary check).
% 2. Synchronous vs. Asynchronous: This model uses a random sequential update 
%    (asynchronous), ensuring no two cells compete for the same site in the same sub-step.
% 3. Nutrients: Unlimited nutrients and space are assumed, limited only by 
%    the lattice dimensions and the exclusion principle.
% ---------------------------------
%
% --- Autor-Information ---
% Autor: Katrin Talkenberger
% E-Mail: k.talkenberger@mail.de
% Created on: 24-April-2026
% MATLAB Vers: R2024b
% Last revision: 24-April-2026
% ---------------------------


    %% INPUT PARAMETER CHECK
    % Growth rate shall be a number between 0 and 1
    if ~exist('growthProb') || ~isnumeric(growthProb) || growthProb < 0 || growthProb > 1
        % Set growth probability default value
        growthProb = 0.5;
    end

    % Image saving shall either be enabled or not
    if ~exist('isSavingEnabled') || ~islogical(isSavingEnabled)
        % Set default value
        isSavingEnabled = true;
    end


    %% INITIALIZATION
    % Set simulation time steps
    steps = 50;
    % Set lattice dimension
    dim = 100;
    % Initialize the lattice by placing one cell in the center of the lattice
    nrCells = 1;
    lattice = zeros(dim,dim);
    lattice(dim/2,dim/2) = 1;
    idxCells = [getLatticeIdx(dim/2,dim/2,dim)]; 

    % Remove previously stored images in results/ folder
    scriptPath = fileparts(mfilename('fullpath'));
    projectRoot = fileparts(scriptPath);
    folderName = fullfile(projectRoot, 'results');
    filePattern = fullfile(folderName, '*.png');
    if ~isempty(dir(filePattern))
        delete(fullfile(folderName, '*.png'));
    end    

    % Create figure with specific name and no number
    set(0, 'DefaultTextFontName', 'Arial')
    fig = figure('Name','Cell growth','NumberTitle','off','MenuBar', 'none', 'ToolBar', 'none');
    ax = axes('Parent', fig);
    set(ax, 'XTick', [], 'YTick', []);

    % Define colormap for cell states: 
    % Row 1 (index 1) -> white, row 2 (index 2) -> black, row 3 (index 3) -> red
    colormap(fig, [1,1,1; 0,0,0; 1,0,0]); 
    % Initial plot of lattice: add 1 because Octave/MATLAB indices start at 1
    img = imagesc(ax,lattice+1);
    % Ensure data values are used as direct pointers to colormap rows, preventing any automatic color scaling
    set(img, 'CDataMapping', 'direct');
    % Set axis proportion and margins
    axis(ax, 'equal', 'tight');
    % Set figure title
    title(['Simulation time: 0 | Number of cells: ', num2str(nrCells)]);
    % Draw first image
    drawnow();

    % Save image to results/ folder  
    if isSavingEnabled    
        % Prepare image naming: "img-cell-growth_xxx.png"
        n = floor(log10(steps)) + 1; % get number of digits for output images
        formatSpec = ['%0', num2str(n), 'd']; % define format string for output images  

        % Save first image
        imgName = sprintf(['img-cell-growth_',formatSpec], 0);   
        frame = getframe(fig); 
        imwrite(frame.cdata, fullfile(folderName,[imgName,'.png']));
    end


    %% SIMULATION
    for time = 1:steps
        % Rule: At each simulation step, a random selection of cells is made. 
        idxCellsRand = idxCells(randperm(length(idxCells)));
        cellSite = [0,0];

        % Rule: Each cell is given the opportunity to profilerate. 
        for i = 1:length(idxCellsRand)        
            cellIdx = idxCellsRand(i);
            [cellSite(1),cellSite(2)] = getLatticeSite(idxCellsRand(i),dim);

            % Reset cell state (for figure purposes only)
            if lattice(cellSite(1),cellSite(2)) == 2
                lattice(cellSite(1),cellSite(2)) = 1;
            end

            if rand <= growthProb
                % Rule: A cell proliferates only if the growth probability is less then or equal a random number chosen from a uniform distribution on (0,1) 


                % Rule: If the cell is identified to be proliferative, the daughter cells are allowed to occupy only opposing directions away from the site of the mother cell. If a cell at (x,y) proliferates, one of the four configurations with equal probability: (i) (x-1,y) and (x+1,y), (ii)  (x,y-1) and (x,y+1) (iii) (x-1,y+1) and (x+1,y-1), (iv) (x-1,y-1) and (x+1,y+1). If the chosen configuration contains already an occupied site, the proliferation is aborted.
                config = randi([1, 4]);
                switch config
                    case 1
                        % Neighboring cells are (x-1,y) and (x+1,y)
                        if lattice(cellSite(1)-1,cellSite(2)) == 0 && lattice(cellSite(1)+1,cellSite(2)) == 0
                            % Proliferate: Update lattice and cell index
                            lattice(cellSite(1)-1,cellSite(2)) = 2;
                            lattice(cellSite(1)+1,cellSite(2)) = 2;
                            lattice(cellSite(1),cellSite(2)) = 0;
                            idxCells = [idxCells,getLatticeIdx(cellSite(1)-1,cellSite(2),dim)];
                            idxCells = [idxCells,getLatticeIdx(cellSite(1)+1,cellSite(2),dim)];
                            idxCells(idxCells==cellIdx) = [];
                            nrCells = nrCells + 1;
                        end
                    case 2
                        % Neighboring cells are (x,y-1) and (x,y+1)
                            % Proliferate: Update lattice and cell index
                            lattice(cellSite(1),cellSite(2)-1) = 2;
                            lattice(cellSite(1),cellSite(2)+1) = 2;
                            lattice(cellSite(1),cellSite(2)) = 0;
                            idxCells = [idxCells,getLatticeIdx(cellSite(1),cellSite(2)-1,dim)];
                            idxCells = [idxCells,getLatticeIdx(cellSite(1),cellSite(2)+1,dim)];
                            idxCells(idxCells==cellIdx) = [];   
                            nrCells = nrCells + 1;                 
                    case 3
                        % Neighboring cells are (x-1,y+1) and (x+1,y-1)
                        % Proliferate: Update lattice and cell index
                            lattice(cellSite(1)-1,cellSite(2)+1) = 2;
                            lattice(cellSite(1)+1,cellSite(2)-1) = 2;
                            lattice(cellSite(1),cellSite(2)) = 0;
                            idxCells = [idxCells,getLatticeIdx(cellSite(1)-1,cellSite(2)+1,dim)];
                            idxCells = [idxCells,getLatticeIdx(cellSite(1)+1,cellSite(2)-1,dim)];
                            idxCells(idxCells==cellIdx) = [];  
                            nrCells = nrCells + 1;                   
                    case 4
                        % Neighboring cells are (x-1,y-1) and (x+1,y+1)
                        % Proliferate: Update lattice and cell index
                            lattice(cellSite(1)-1,cellSite(2)-1) = 2;
                            lattice(cellSite(1)+1,cellSite(2)+1) = 2;
                            lattice(cellSite(1),cellSite(2)) = 0;
                            idxCells = [idxCells,getLatticeIdx(cellSite(1)-1,cellSite(2)-1,dim)];
                            idxCells = [idxCells,getLatticeIdx(cellSite(1)+1,cellSite(2)+1,dim)];
                            idxCells(idxCells==cellIdx) = [];    
                            nrCells = nrCells + 1;                  
                    otherwise
                        % TODO: error
                end
            end
        end

        % Update the figure
        set(img,'CData',lattice+1)
        title(['Simulation time: ', num2str(time), ' | Number of cells: ', num2str(nrCells)]); 
        drawnow();

        % Save image to results/ folder  
        if isSavingEnabled        
            imgName = sprintf(['img-cell-growth_',formatSpec], time);   
            frame = getframe(fig); 
            imwrite(frame.cdata, fullfile(folderName,[imgName,'.png']));
        end
    end

    % Close figure
    close(fig)   

    % Finish simulation
    fprintf('Simulation finished. Final cell count: %d\n', nrCells);
end 
 

%% HELPER FUNCTIONS
function out = getLatticeIdx(i,j,Lx)
% GETLATTICEIDX Function to assign lattice index to integer value.

    out = i+(j-1)*Lx;
end
function [r,c]=getLatticeSite(idx,Lx)  
% GETLATTICESITE Function to assign integer value to lattice index.

    r= rem(idx-1,Lx)+1;  %Row
    c = (idx-r)/Lx + 1;   %Column
end