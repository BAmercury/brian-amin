function map = denvToOccGrid(boundary, blocks, sz, margin)
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

%% Find out what cells overlap grid

% Separate blocks into a matrix of: [xmin ymin; xmax ymax] instead of [xmin
% ymin xmax ymax; xmin ymin xmax ymax]
block_size = size(blocks);
block_rows = block_size(1);
points = [];
for g=1:block_rows
    points = [points; blocks(g,1) blocks(g,2);blocks(g,3) blocks(g,4)];
end

%points = [blocks(:,1) blocks(:,2); blocks(:,3) blocks(:,4)];
%points = [blocks(1) blocks(4); blocks(2) blocks(5); blocks(3) blocks(6); blocks(7) blocks(10); blocks(8) blocks(11); blocks(9) blocks(12)]

grid_points = world2grid(map, points);



for k=1:(length(grid_points)-1)
    % Find minrow/col and maxrow/col for each individual block
    %if (i == length(grid_points)-1)
    %    disp('here')
    %    break;
    %else
    grid_point_block = [grid_points(k,:); grid_points(k+1,:)];
    %end
    row_length = numel(grid_point_block(:,1));
    y = 0;
    x = 0;
    max_row = 0;
    min_row = inf;
    %Find Min Row
    for h=1:row_length
        y = grid_point_block(h);
    if (y < min_row)
        min_row = y;
    end
    end
    % Find max row
    for w=1:row_length
    x = grid_point_block(w);
    if (x > max_row)
        max_row = x;
    end
    end
    
    % Finding max and min col
    col = grid_point_block(:,2);
    col_length = numel(col);
    min_col = inf;
    max_col = 0;
    y = 0;
    x = 0;
    % Finding min col
    for r=1:col_length
        y = col(r);
        if (y < min_col)
            min_col = y;
        end
    end

    % Finding max col
    for t=1:col_length
        x = col(t);
        if (x > max_col)
            max_col = x;
        end
    end
    
    for (i=min_row:max_row)
        
        for (j=min_col:max_col)
            setOccupancy(map,[i j],1,'grid')
        end
    end
    
    
    %setOccupancy(map,[min_row max_col],1,'grid');
    
%     % Begin settign occupancy
%     for (i=min_row:max_row)
% 
%         for (j=min_col:max_col)
% 
%             col_val = ismember(j,grid_points(:,2));
%             row_val = ismember(i,grid_points(:,1));
%             
%             if (col_val == 1 && row_val == 0)
%                 setOccupancy(map,[i j],1,'grid')
%             end
%             
%             if (col_val == 1 && row_val == 1)
%                 setOccupancy(map,[i j],1,'grid')
%                 
%                 
%                 
%             end
%             
% 
%         end
%     end
    
  
    
    
%     for i=1:length(rows)
%         for j=1:(length(cols)-1)
%             %world_coords = grid2world(map,[row(i) cols(j)]);
%             %val = ismember(cols(j), grid_points(:,2))
%             
%             if (val == 1)
%                 setOccupancy(map,[rows(i) cols(j)],1,'grid')
%                 %setOccupancy(map,[rows(i+1) cols(j+1)],1,'grid');
%             end
%         end
%     end


    

end
    
    
    




%map.inflate(margin)
% Width, Height, Res

% =================== Your code ends here ===================
end