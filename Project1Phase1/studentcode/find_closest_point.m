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

%number of points that make up the line segment
n = 5

%base point of the line segment
basept = path(:,segment);
basex = basept(1);
basey = basept(2);

%head point of the line segment
headpt = path(:,segment+1);
headx = headpt(1);
heady = headpt(2);

%slope:
slope = (heady - basey) / (headx - basex);

%generate line:
linepts = 




dist_min = Inf;
pt_min = [0; 0];

% =================== Your code ends here ===================

