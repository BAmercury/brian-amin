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
margin = 2;
lookahead = margin + radius;




[pt_min, dist_min] = find_closest_point(qd.pos, waypts);

disp(pt_min)
disp(dist_min)


if (dist_min ~= lookahead)
    %if the closet point is not inside lh circle, drive to closetpoint
    %so convert pt_min (closet point) to robot's frame
    
    %make homogenous
    world_goal = [pt_min; 0]
    
    rot = [cos(qd.theta), -sin(qd.theta); sin(qd.theta), cos(qd.theta); 0,0];
    trans = [qd.pos;0]
    
    H = [rot, trans]
    
    robot_goal = H * world_goal;
    vector = robot_goal - [qd.pos;0];
    dist = norm(vector);
    
    
    dist_squared = (dist)^2;
    R = dist_squared / (2 * robot_goal(2));
    w = R / 10;
    cinput = [10; w];
    
    
    %convert to wheel speeds
    control_t = [1/params.wheel_radius, -params.wheel_base / (2*params.wheel_radius); 1/params.wheel_radius, params.wheel_base / (2* params.wheel_radius)]
    
    u = control_t * cinput;
end
% elseif (dist_min > lookahead)
%     %goal point must be along current segment sinze it starts inside and
%     %ends outside. Do some geometry to figure out goal point
% else
%     %shift to next segment, if that ends outside circle do what we did
%     %above
%     
% else
%     %goto next semgment
%     
    
    %we can add on a new thign to spit out segment from find_closet_point

    

%determine which segment we need to choose for proper indexing






%so we have a line segment between the waypoint and the robot's projection
%onto the path (with that projection's distance dt_min. So the goal point
%can lie on that path between the proj and the waypt, if waypt and proj are
%inside the circle, then the goal must be on the segment. If not have the
%robot check the next segment

% =================== Your code ends here ===================


end
