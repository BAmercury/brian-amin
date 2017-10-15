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
margin = 1;
lookahead = 1.00;



[pt_min, dist_min, segment_index] = find_closest_point(qd.pos,waypts);
   

world_goal = [0;0;1];


%% Finding the Goal Point



% Find the endpoint of the current segment
end_point = waypts(:,(segment_index+1));

% Does the endpoint of current segment end OUTSIDE of the lh circle?
dist2endpoint = qd.pos - end_point;
dist2endpoint = norm(dist2endpoint);

if (dist2endpoint > lookahead)
    % Segment end is OUTSIDE circle, so closest point (pt_min) must be
    % inside. Goal point must be inside the point. Find it using trig
    %world_goal = [pt_min; 1];
    
    
    dist2goal = sqrt((lookahead^2) - (dist_min^2));
    world_goal = [pt_min(1)+dist2goal; pt_min(2)+dist2goal;1];

    
else
    % Check next segments until we find the one where the endseg is outside
    % lh
    
    start_segment = segment_index+1;
    max_segment = length(waypts);
    endpoint_segment = segment_index;
    
    for (i = start_segment:max_segment)
        %search for a segment endpoint that lies outside lh circle
        end_point = waypts(:,i);
        dist2endpoint = qd.pos - end_point;
        dist2endpoint = norm(dist2endpoint);
        
        if (dist2endpoint > lookahead)
            endpoint_segment = i;
            break;
        end
        
    end
    
    %Now we have the index of the endpoint. Let's find the goal point
    base_segment = endpoint_segment -1;
    
    [pt_min, dist_min, segment_index] = find_closest_point(qd.pos,waypts, base_segment);
    
    dist2goal = sqrt( (lookahead^2) - (dist_min^2));
    world_goal = [pt_min(1)+dist2goal; pt_min(2)+dist2goal;1];
    
    disp('im here')
    

        
end


%% Transform goal point

% Rotation of Robot Frame from World frame (wRr)
rot = [cos(qd.theta), -sin(qd.theta); sin(qd.theta), cos(qd.theta)];
% World frame from Robot Frame (rRw)
%rot = inv(rot);
%rot_h = [rot; 0,0];
trans = [qd.pos];
%H = [rot_h, trans;0,0,1];
R = transpose(rot);
H = [R, (-R * trans); 0,0,1];

robot_goal = H * world_goal;


%% Calculate radius of the arc connecting robot to goal point

l_squared = (lookahead)^2;
R = l_squared / (2 * robot_goal(2));


%% Set wheel velocities given actuator limits and relationship R = v/w


v = params.max_vel;


w = (v / R);


% Sign correction for W

if (robot_goal(1) > 0 && robot_goal(2) > 0)
    % w > 0
    if (sign(w) == -1)
        w = abs(w);
    end
elseif (robot_goal(1) > 0 && robot_goal(2) < 0)
    % w < 0
    if (sign(w) == 1)
        w = -w;
    end
elseif (robot_goal(1) < 0 && robot_goal(2) < 0)
    if (sign(w) == -1)
        w = abs(w);
    end
elseif (robot_goal(1) < 0 && robot_goal(2) > 0)
    if (sign(w) == 1)
        w = -w;
    end
end



   
c_input = [0.5*v; 0.5*w];





control_t = [(1/params.wheel_radius), ((-params.wheel_base) / (2*params.wheel_radius)); (1/params.wheel_radius), ((params.wheel_base) / (2* params.wheel_radius))];
    
u = control_t * c_input

u = real(u);


            

        




% =================== Your code ends here ===================


end
