% Beginner erosion.

clear all; close all; clc

m = 200;            % length of channel
n = 50;             % width of channel
diffrate = 0.5;     % fraction of fluid in each cell that passes to its daughters on each timestep.
randomness = 0.1;  % randomness in diffusion from cell to its daughters. A homogenizing parameter.
outflow = 1.0;      % fractional amt we take out from bottom at each step.
                    
figx = 4*n+100;     % Figure width
figy = 4*m;         % Figure height

% --------------------------------------------

figx = min(figx,1600);
figy = min(figy,900);
S = zeros(m,n);  % fluid density in soil.  Change this later maybe.



% The model:
% a node at the top gets assigned a value of 1+current value.
% At each step, every node distributes half of its value to its three
% nearest neighbors below, proportional to their current fluid.
% Every cell at the bottom gets theirs/total removed from it (so total fluid
% in channel is conserved).
%
% will we see rivers forming?


fighandle = figure;
set(fighandle, 'Position', [20,50,figx,figy])
image(S);
axis equal;
%colormap(hot(256));
colorbar('EastOutside');
caxis([0 3]);
caxis manual

for t = 0:ceil(10*m/diffrate)
    drop = ceil(n*rand(1,2));
    S(1,drop) = S(1,drop) + 4;
    
    S = dieflow(S,diffrate,outflow,randomness);
    
    
    if mod(t,1)==0
        
        imagesc(S);
        %axis equal;
        %axis square;
        colorbar('EastOutside');
        caxis([0 3])
        pause(0.001);
    end
end