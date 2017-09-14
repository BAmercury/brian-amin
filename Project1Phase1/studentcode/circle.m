function [waypts] = circle
% CIRCLE generates waypoints to move the robot in a circle
% 
% The circle should have radius 1m and should be centered at the point 
% (0, 1)m.  The robot should traverse the trajectory in a counter-clockwise
% fashion.  The robot should start at the origin.

%define circle constraints
radius = 1;
center = [0 1];

%Number of points
n = 15;

%generate values from 0 to n
t = linspace(0,2*pi,n);

%get x and y these will pretty much be the waypoints
x = center(1) + radius*sin(t);
y = center(2) + radius*cos(t);

%line = line(x,y)


waypts = [center(1), x ; center(2), y];

end
