function [u] = controller(qd, waypts, t, params)
% CONTROLLER robot controller
%
% INPUTS:
% qd     - qd structure, contains current state
% waypts - 2 x n, way points [x; y]
% t      - 1 x 1, time
% params - struct, output from turtlebot3() and whatever parameters you want to pass in
%
% OUTPUTS:
% u      - 2 x 1, wheel velocities [left, right]

% =================== Your code goes here ===================
%find lookahead point
radius = params.radius;
margin = 5;
lookahead = margin + radius;

%segment:
segment = 2;

[proj, dist_min] = find_closest_point(qd, waypts,segment)






u    = [32,0]; % You should fill this in






% =================== Your code ends here ===================


end
