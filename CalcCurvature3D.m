function [new_rot, theta_xy, phi_z, len] = CalcCurvature3D (p1, p2, old_rot)
%% Calculate the curvatures kg and kn at the point p1
%  Calculate the rotation matrix at point p2
%   kg is theta_xy / len
%   kn is phi_z / len
%   len is the length of p2-p1
%   old_rot is the rotation matrix at p1

%% Rotate everything down to [1,0,0] [0,1,0] [0,0,1]
% Use the rotation at p1 (which takes p1-p0 to the x-axis) to rotate the
% next vector into the plane
% vNext should be pretty close to being along the x axis, provided there is
% not too much rotation   
vNext = old_rot' * (p2 - p1) ;

% Length of vNext
len = sqrt( dot( vNext, vNext ) );

%% theta - rotation in the plane
% if vNext is too small this will be invalid; need to fix
theta_xy = atan2( vNext(2), vNext(1) );     

%% phi - rotation out of the plane
% Project vNext into the plane, then take the height of vNext over that
% projected length
%   if the length is very small, don't divide by it!
len_xy = sqrt( dot(vNext(1:2),vNext(1:2)) );

% Again, need to put length check in.
phi_z = atan2( vNext(3), len_xy ) ;


%% New rotation - rotate down to the plane, rotate by theta, then by phi
%     Actual rotation is inverse of that, since rotation matrix always
%     takes x-axis TO the vector
% Rotation matrices for theta and phi
r_theta = [cos(theta_xy) sin(theta_xy) 0; -sin(theta_xy) cos(theta_xy) 0; 0 0 1] ;
r_phi = [cos(phi_z) 0 sin(phi_z); 0 1 0; -sin(phi_z) 0 cos(phi_z)] ;

new_rot = (r_phi * r_theta * old_rot')';

end