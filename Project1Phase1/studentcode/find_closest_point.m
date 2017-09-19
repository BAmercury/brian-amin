function [pt_min, dist_min] = find_closest_point(position, path, segment)
% FIND_CLOSEST_POINT
%
% This function finds the point on the path that is closest to the current
% position of the robot.  Optionally, if the segment is specified, the
% function returns the point on the segment that is closest to the robot.
% For example, segment 3 consists of the line segment connecting points
% 3 and 4 in the path.
%
% INPUTS:
% position 	- 2 x 1, current position of the robot
% path 		- 2 x n, way points [x; y]
% segment   - 1 x 1, segment id [OPTIONAL], must be 1, 2, ..., n-1
%
% OUTPUTS:
% pt_min    - 2 x 1, point closest to the current robot position
% dist_min 	- 1 x 1, minimum distance from the robot to the path

% =================== Your code goes here ===================

% You should fill this in


%can we use segment as a linear index for path? then we can begin by
%creating some line with P1 and P2 (two points along path). We project the
%robot pose onto this line and see if its close to the projected point, or
%the two ends using an algorithim that determines closet point


%navigating path/waypts: point = waypts(:,segment) (all rows, but only the first
%column, etc. x = point(1) y = point(2)


dist_min = Inf;
pt_min = [0; 0];


%base point of the line segment
if nargin == 3
    basept = path(:,segment);
    
    
    %head point of the line segment
    headpt = path(:,segment+1);
    
    
    %projection:
    poi = headpt - basept;
    pos = position;
    poi_squared = dot(poi,poi);
    proj = (dot(pos, poi) / poi_squared);
    
    
    if (proj < 0.00)
        %Point is before basept
        proj = basept;
    elseif (proj > 1.00)
        % Point is after the headpt
        proj = headpt;
    else
        %Point lines inbetween base and head:
        proj = basept + proj * poi;
        
    end
    
    
    %found point closet to path (2x1)
    pt_min = transpose(proj);
    
    %now to find min distance of robot to path
    vector = pt_min - pos;
    dist_min = length(vector);
            
    
  
     


end







% =================== Your code ends here ===================

