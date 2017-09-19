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

%segment 1 is the inital location of robot, so we index at 2
segment = 2;
pose = transpose(qd.pos);
[proj, dist_min] = find_closest_point(pose, waypts,segment)

closing_distance = length(proj-qd.pos);
while (dist_min > closing_distance)
    u = [10,10]
    
end








%u    = [32,0]; % You should fill this in






% =================== Your code ends here ===================


end
