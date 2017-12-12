function map = fenvToOccGrid(boundary, blocks, sz, margin)
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



% Centroid of each block in set
%centroid_blocks = [(blocks(:,1) + blocks(:,3))/2,(blocks(:,2) + blocks(:,4))/2];

% set occupancy is map, xy coords, and the occupancy value (1)
%size_lengths = [ (blocks(:,3) - blocks(:,1)), (blocks(:,4) - blocks(:,2) ) ];

%sides_plus_margin = [ (size_lengths(:,1) + margin), (size_lengths(:,2) + margin) ];

%% Find out what cells overlap grid

% Need to make this automated to work with any blocks in the various data
% structures


% Separate blocks into a matrix of: [xmin ymin; xmax ymax] instead of [xmin
% ymin xmax ymax; xmin ymin xmax ymax]
points = [blocks(:,1) blocks(:,2); blocks(:,3) blocks(:,4)];
%setOccupancy(map, [points(:,1) points(:,2)], 1)


%points = [blocks(1) blocks(4); blocks(2) blocks(5); blocks(3) blocks(6); blocks(7) blocks(10); blocks(8) blocks(11); blocks(9) blocks(12)]

grid_points = world2grid(map, points);




% Begin to search for min row, min col, max row, max col to fill in rest of
% blocks

row_length = numel(grid_points(:,1));
y = 0;
x = 0;
max_row = 0;
min_row = inf;
for i=1:row_length
    y = grid_points(i);
    if (y < min_row)
        min_row = y;
    end
end
for i=1:row_length
    x = grid_points(i);
    if (x > max_row)
        max_row = x;
    end
end

col = grid_points(:,2);
col_length = numel(col);
min_col = inf;
max_col = 0;
y = 0;
x = 0;

for i=1:col_length
    y = col(i);
    if (y < min_col)
        min_col = y;
    end
end

for i=1:col_length
    x = col(i);
    if (x > max_col)
        max_col = x;
    end
end

% Set occupancy of all the cells within the rows and columns

%I = [min_row min_col; max_row max_col];
corners = [min_row min_col; min_row max_col; max_row min_col; max_row max_col];
setOccupancy(map, [corners(:,1) corners(:,2)], 1, 'grid')


%Fill in rest of occupied spaces
rows = min_row:max_row;
cols = min_col:max_col;





for i=1:length(rows)
    for j=1:length(cols)
        world_cols = grid2world(map, [rows(i) cols(j)]);
        if ( ismember(cols(j), grid_points(:,2)) )
            setOccupancy(map, [rows(i) cols(j) ], 1, 'grid')
        end
    end
    %setOccupancy(map, [rows(i) min_col], 1, 'grid')
    %setOccupancy(map, [rows(i) max_col], 1, 'grid')
end

% for i=1:length(cols)
%     setOccupancy(map, [min_row cols(i)], 1, 'grid')
%     setOccupancy(map, [max_row cols(i)], 1, 'grid')
% end


%map.inflate(margin)
% Width, Height, Res

% =================== Your code ends here ===================
end
