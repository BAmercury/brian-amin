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
dist_min = Inf;
pt_min = [0; 0];

% =================== Your code ends here ===================

