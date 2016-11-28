function [EMax, EMin, Fij] = DiscreteStrain( pts1, pts2, vecDs, vecDt, h )
% pts1 and 2 should be centered at the origin (i.e., q_i - p, not q_i)
% pts1 and 2 should be nX3 matrices, n being the number of points
% vecDs, vecDt is the derivative at p (only used for calculating Fij)

%Store for future use
nPts = size( pts1, 1 );

%% Find the rotation matrix that takes the bisector of vecDs and vecDt to the 
% diagonal, and the normal to z
rotToPlane = RotateToXYZ( vecDs, vecDt );

% Dot( vecBisect, vecNormPlane )
% Dot( vecCoBisectPlane, vecNormPlane )
% Dot( vecBisect, vecCoBisectPlane )
% Dot( vecCoBisectPlane, vecCoBisectPlane )
% Dot( vecBisect, vecBisect )
% Dot( vecNormPlane, vecNormPlane )
% 
% rotToPlane * vecBisect
% rotToPlane * vecDs
% rotToPlane * vecDt
% rotToPlane * vecNormPlane

ptsCopy1 = pts1;
for k = 1:3
    % Find the rotation that best takes pts2 to pts1
    bestRotMat = BestRotation( ptsCopy1, pts2 );

    % Take pts2 to pts 1 and the whole thing to the plane
    rotPts1 = (rotToPlane * pts1')';
    rotPts2 = (rotToPlane * bestRotMat * pts2')';

    % Find the symmetric matrix that takes rotPts1 to pts2
    Fij = AlignPoints( rotPts1, rotPts2 );
    
    % Adjust copy points by scale so best rotation works better
    matAlign3D = [ Fij(1,:), 0; Fij(2,:), 0; 0,0,1];
    ptsCopy1 = ( bestRotMat' * rotToPlane' * matAlign3D * rotToPlane * bestRotMat * pts1')';
end

% Already aligned so that x is vecDs, y is vecDt
[EMax, EMin] = ExtractStrain( Fij );

bDraw = 0;
if ( bDraw )
    figure(h);
    subplot(2,3,3);
    
    clf(h);
    hold on;

    % Plot axes
    dLen = norm( pts1(1,:) );
    plot3( [0,dLen], [0,0], [0,0], 'black' );
    plot3( [0,0], [0,dLen], [0,0], 'black' );

    % Second set of points rotated to the plane
    plot3( rotPts2(:,1), rotPts2(:,2), rotPts2(:,3), 'b' );
    % First set of points in the plane before scaling
    plot3( rotPts1(:,1), rotPts1(:,2), rotPts1(:,3), 'g+' );
    % First set of points after rotating and scaling
    matAlign3D = [ Fij(1,:), 0; Fij(2,:), 0; 0,0,1];
    rotSclPts1 = (matAlign3D * rotPts1')';
    plot3( rotSclPts1(:,1), rotSclPts1(:,2), rotSclPts1(:,3), 'r' );
    plot3( rotSclPts1(:,1), rotSclPts1(:,2), rotSclPts1(:,3), 'r+' );
    
    % Plot vecDs and vecDt
    vecCheckDs = rotToPlane * vecDs;
    vecCheckDt = rotToPlane * vecDt;
    plot3( [0, vecCheckDs(1,1) * dLen * 1.5], [0, vecCheckDs(2,1) * dLen * 1.5], [0, vecCheckDs(3,1) * dLen * 1.5],  'm' );
    plot3( [0, vecCheckDt(1,1) * dLen * 1.5], [0, vecCheckDt(2,1) * dLen * 1.5], [0, vecCheckDt(3,1) * dLen * 1.5],  'm' );
    axis equal;
    view(2);
end



