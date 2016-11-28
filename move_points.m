% Make a new variable for ptsCyl so that you don't move the original
% Turn this into a function that calculates a matrix that takes the
% "ideal" points on the cylinder to their current optitrack location
function [matAccum] = move_points(ptsCyl, XYZAll, timeFrame)
%Function rough draft
%Create M_accum of the four cylinder points from optitrack for each of the
%time frames 
matAccum = eye(4);
ptsCylOrig = ptsCyl;
% Do a couple times
% Matrix is
%   TtoOptiTrak R TtoOrig
XYZ = squeeze(XYZAll(:,:,timeFrame)');
for k = 1:3
    transMatToOrigFromCyl = eye(4);
    transMatToOrigFromXYZ = eye(4);
    transMatToXYZFromOrig = eye(4);
    %Takes the mean of the values in the array ptsCyl for each column and
    %assigns it the translation going from the origin to the cylinder 
%     transMatToOrigFromCyl(1:3,4) = - mean(ptsCyl(1:3,:)');
    transMatToOrigFromCyl(1:3,4) = - mean(ptsCyl(1:3,:)');
    %Takes the mean of the values in the array XYZ twice for from the
    %origin and from the XYZ cooridinates for the determined timeFrame
    transMatToXYZFromOrig(1:3,4) =   mean(XYZ(1:3,:)');
    transMatToOrigFromXYZ(1:3,4) = - mean(XYZ(1:3,:)');
     
    % Transform both the cylinder points and the optitrack points to the
    % origin for the designated time frame 
    ptsCyl = transMatToOrigFromCyl * ptsCyl;
    
    ptsXYZOrig = transMatToOrigFromXYZ * XYZ;
    
    % Find the best rotation
    transRot = eye(4);
    transRot(1:3,1:3) = BestRotation( ptsXYZOrig(1:3,:)', ptsCyl(1:3,:)' );
    transformMat = transMatToXYZFromOrig * transRot;

    % Transform the cylinder points by the rotation and then translate to
    % the center of the optitrac points
    ptsCyl = transformMat * ptsCyl;
    matAccum = transformMat * transMatToOrigFromCyl * matAccum;
end

%Test to see if the points are transformed correctly 
%test_M(ptsCylOrig, M_array)

% ptsCylCheck = matAccum * ptsCylOrig;
% sum( abs( ptsCylCheck - ptsCyl ) );
% cols = {'-Xr', '-Xg', '-Ob', '-Ok'};
% subplot(1,2,2);
% for k = 1:4
%     plot3( [ptsCylCheck(1,k), XYZ(1,k)], [ptsCylCheck(2,k), XYZ(2,k)], [ptsCylCheck(3,k), XYZ(3,k)], cols{k}, 'MarkerSize', 20 );
%     hold on;
% end
% subplot(1,2,1);

end 