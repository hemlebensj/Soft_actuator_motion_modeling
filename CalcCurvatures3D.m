function [crvs, rotations] = CalcCurvatures3D( pts )
%% Pts is a list of 3D points
% rotations is a 3x3xn matrix of rotations, one for each point
%   The ith matrix rotates the x-axis to p_i - p_i-1 and the z-axis to
%      (p_i+1 - p_i) X (p_i - p_i-1)
% crvs is a 2xn matrix of the curvature values;
%   first row is lateral rotation (in the xy plane)
%   second row is dorsal rotation (out of the xy plane)
%    The ith curvature values tells how to rotate the coordinate frame at
%    the ith position to the ith+1 (ie, how to change R_i)
%
% Note that the 1st and last rotation/curvature values are undefined. Set
% to their nearest neighbor.

% Pre-alloc the data
num_pts = size(pts, 2);
rotations = zeros( 3,3, num_pts) ;
crvs = zeros( 2, num_pts) ;

% Set up first rotation matrix so that normal of p1,p2,p3 is z and p2-p1 is
% x
prevRot = FirstRotMat(pts) ;
rotations(:,:,1) = prevRot; % Put this initial matrix in slot for 1 just to have it
rotations(:,:,2) = prevRot; % Properly belongs to point 2

debug = 0;
% While we have valid points...
for k = 2 : (length(crvs))-1
 
    % The rotation matrix at point k should
    %    Take the z-axis to the normal of the points p_k-1 p_k p_k+1
    %    Take the x-axis to the vector p_k-1 p_k
    % The curvature values at point k should create a rotation *change* matrix
    % that takes the rotation matrix at k to the one at k+2, which has
    % the property that it takes [1,0,0] to p_k+1 - p_k
    %
    % Calculate crv values at k by finding rotation matrix for k+1 and
    % writing curvatures as the angles that you rotate the matrix k through
    % to get to k+1
    %   CalcCurvatures returns rotation angles; divide by length to get
    %   curvature values
    [nextRot, theta_xy, phi_z, len] = CalcCurvature3D( pts(1:3,k), pts(1:3,k+1), prevRot) ;

    % Save the next rotation matrix
    rotations(:,:,k+1) =  nextRot ;
    
    % calculate curvature from angles
    if len > 1e-32
        kappa_g = (theta_xy/len) ; %double check the length outputs
        kappa_n = (phi_z/len) ;

        crvs(:,k) =[kappa_g; -kappa_n ] ;
    end

    if debug
        % (Optional) Check that the rotation matrice are correct
        vPrev = prevRot' * (pts(1:3,k) - pts(1:3,k-1));
        vPrev = vPrev ./ sqrt(dot(vPrev,vPrev)); % This should be 1,0,0

        % (Optional) Check the new rotation matrix and make sure it works correctly 
        vCur = nextRot' * (pts(1:3,k+1) - pts(1:3,k));
        vCur = vCur ./ sqrt(dot(vCur,vCur)); % This should be 1,0,0

        fprintf('Vecs: %0.2f %0.2f %0.2f %0.2f %0.2f %0.2f Curvatures: %0.6f %0.6f\n', vPrev, vCur, crvs(:,k) );
    end
    
    % Increment matrices
    prevRot = nextRot;
end

% Copy the values we can't calculate
crvs(:,1) = crvs(:,2);
crvs(:,end) = crvs(:,end-1);
rotations(:,:,end) = rotations(:,:,end-1);

end