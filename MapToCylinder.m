function [ XYZInCylSpace, matToMapAll ] = MapToCylinder( ptsCyl, XYZ )
% Take out the rotation translation from each set of points
% Returns the "normalized" points in XYZInCylSpace
%  and the matrices to get them there in matToMap

matToMapAll = zeros( size(XYZ,3), 4, 4 );
XYZInCylSpace = XYZ;

for t = 1:size(XYZ,3)
    matToMap = move_points( ptsCyl, XYZ, t );
    matToMap = matToMap^(-1);
    
    pts = squeeze(XYZ(:,:,t))';
    pts = matToMap * pts;
    XYZInCylSpace(:,:,t) = pts';
    
    matToMapAll(t, :,:) = matToMap;
    % Plot the transformed points
%     subplot(1,2,1);
%     plot3(pts(1,:), pts(2,:), pts(3,:), 'Or');
end

end

