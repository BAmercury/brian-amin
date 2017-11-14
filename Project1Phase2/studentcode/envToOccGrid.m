function map = envToOccGrid(boundary, blocks, sz, margin)
% ENVTOOCCGRID
%
% This function takes in the output of readEnv and two additional
% parameters and outputs BinaryOccupancyGrid object that represents the
% input environment.
%
% INPUTS:
% boundary  - 1 x 4, matrix with [xmin, ymin, xmax, ymax] of the environment
% blocks 	- n x 4, matrix with n rows, one for each block, of the form
%                    [xmin, ymin, xmax, ymax]
% sz        - 1 x 1, size of the cells [m/cell]
% margin    - 1 x 1, amount to inflate each obstacle by (in both x and y)
%
% OUTPUTS:
% map       - robotics.BinaryOccupancyGrid object

% =================== Your code goes here ===================

% This opens the documentation for the occupancy grid. You should comment 
% this out later if you don't want it popping up every time you run the 
% function.
%doc robotics.BinaryOccupancyGrid 

% You should fill this in!  I picked dummy values just so it would run.
width = norm(boundary(1) - boundary(3));
height = norm(boundary(2) - boundary(4));
map = robotics.BinaryOccupancyGrid(width,height,(1/sz));

map.GridLocationInWorld = [boundary(1) boundary(2)]

%Set world limits

map.inflate(margin)

%% Need to find center points of the obscatles?

bg = [(blocks(:,1) + blocks(:,3))/2,(blocks(:,2) + blocks(:,4))/2];

setOccupancy(map,bg,1)

% Width, Height, Res

% =================== Your code ends here ===================
end
