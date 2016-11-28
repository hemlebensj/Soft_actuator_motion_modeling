function [ XYZGrid, XYZMarkers ] = ImageDataToCylinder( fNameMarker2D, fNameGrid2D, XYZMappedToCyl, ptsGrid, ptsCyl, order )
%Read in the 2D data and map it to the cylinder as best as possible

nRows = 2;
nCols = 3;
cols = {'-Xr', '-Xg', '-Xb', '-Xy', '-Xk'};


% 
%   Black(top2)    Blue(side2)
%  Green(top1)   Red(side1)

top1 = order(1);
top2 = order(2);
side1 = order(3);
side2 = order(4);
top1_2D = 1;
top2_2D = 2;
side1_2D = 4;
side2_2D = 3;

%% Get 2D data
% Grid line
[UVLineOrig, UVMarkerOrig] = GetImagePoints(fNameMarker2D, fNameGrid2D);

UVLine = UVLineOrig;
UVMarker = UVMarkerOrig;

% Translate lower left point to 0,0
UVMarker(:,1,:) = UVMarker(:,1,:) - UVMarker(1,1,1);
UVMarker(:,2,:) = UVMarker(:,2,:) - UVMarker(1,2,1);
UVLine(:,1,:) = UVLine(:,1,:) - UVLine(1,1,1);
UVLine(:,2,:) = UVLine(:,2,:) - UVLine(1,2,1);

% Scale both to be approximate heights
% Rotate both to bring markers in line with y up
angRotPlaneMarker = -pi/2 + atan2( UVMarker(top2_2D,2,1) - UVMarker(top1_2D,2,1), UVMarker(top2_2D,1,1) - UVMarker(top1_2D,1,1) );
matRot = [ cos(angRotPlaneMarker), sin(angRotPlaneMarker); -sin(angRotPlaneMarker), cos(angRotPlaneMarker) ];

heightMarkers3D = 0.5 * (sqrt( sum( ( XYZMappedToCyl(top1,2:3,1) - XYZMappedToCyl(top2,2:3,1) ).^2 ) ) + ...
                         sqrt( sum( ( XYZMappedToCyl(side1,2:3,1) - XYZMappedToCyl(side2:3,1) ).^2 ) ) );

heightMarkers2D = 0.5 * (sqrt( sum( ( UVMarker(top1_2D,1:2,1) - UVMarker(top2_2D,1:2,1) ).^2 ) ) + ...
                         sqrt( sum( ( UVMarker(side1_2D,1:2,1) - UVMarker(side2_2D,1:2,1) ).^2 ) ) );

widthMarkers3D = 0.5 * (sqrt( sum( ( XYZMappedToCyl(side2,2:3,1) - XYZMappedToCyl(top2,2:3,1) ).^2 ) ) + ...
                         sqrt( sum( ( XYZMappedToCyl(side1,2:3,1) - XYZMappedToCyl(top1,2:3,1) ).^2 ) ) );

widthMarkers2D = 0.5 * (sqrt( sum( ( UVMarker(side2_2D,1:2,1) - UVMarker(top2_2D,1:2,1) ).^2 ) ) + ...
                         sqrt( sum( ( UVMarker(side1_2D,1:2,1) - UVMarker(top1_2D,1:2,1) ).^2 ) ) );
uvScl = heightMarkers3D / heightMarkers2D;
uvSclW = widthMarkers3D / widthMarkers2D;
matScl = [ uvSclW, 0; 0, uvScl ];
       
matAlign = matScl * matRot;
matAlignGrid = [0.5, 0; 0, 0.5] * matAlign; % I think the marker image was downsized 1/2
         
for p = 1:size(UVLine,1)
    pts2D = squeeze(UVLine(p,1:2,:));
    pts2D = matAlignGrid * pts2D;
    % Moving the bottom of the line up to the bottom of the cylinder
    pts2D(2,:) = pts2D(2,:);
    UVLine(p,1:2,:) = pts2D(1:2,:);
end
subplot(nRows, nCols, 3);
plot( UVLine(1,1,1), UVLine(1,2,1), '*k', 'MarkerSize', 15);
hold on;
plot( UVLine(:,1,1), UVLine(:,2,1), '-Ok' );
for t = 1:3:size(UVLine, 3)
    plot( squeeze(UVLine(:, 1,t)), squeeze(UVLine(:,2,t)), '-g' );
end
axis equal
title('Rotated scaled UVLine');

subplot(nRows, nCols, 4);
for p = 1:size(UVMarker,1)
    pts2D = squeeze(UVMarker(p,1:2,:));
    pts2D = matAlign * pts2D;
    % Moving the bottom of the line up to the bottom of the cylinder
    %pts2D(2,:) = pts2D(2,:) - heightCyl * 0.5;
    UVMarker(p,1:2,:) = pts2D(:,:);
    plot( squeeze(UVMarker(p,1,:)), squeeze(UVMarker(p,2,:)), cols{p} );
    hold on;
    plot( UVMarker(p,1,1), UVMarker(p,2,1), '*k', 'MarkerSize', 15 );
end
axis equal
title('Rotated scaled markers');

%% Now translate the UV line to be in the right place wrt the markers
% Should be roughly 0.005, -0.01 to 0.005 -0.1
subplot(nRows, nCols, 5);
plot( [ptsCyl(2,top1) ptsCyl(2,top2)], [ptsCyl(3,top1) ptsCyl(3,top2)], '-Xc' ); 
hold on
plot( [ptsCyl(2,side1) ptsCyl(2,side2)], [ptsCyl(3,side1) ptsCyl(3,side2)], '-Xy' ); 
plot( ptsGrid(2,:), ptsGrid(3,:), '-Og' );

transLine = ptsGrid(2:3,1);
for p = 1:size(UVLine,1)
    UVLine(p,1,:) = UVLine(p,1,:) + transLine(1);
    UVLine(p,2,:) = UVLine(p,2,:) + transLine(2);
end
plot( UVLine(1,1,1), UVLine(1,2,1), '*k', 'MarkerSize', 15);
plot( UVLine(:,1,1), UVLine(:,2,1), '-Ok' );

% should be roughly -0.01, -0.01 to 0.01, 0.01
transMarker = ptsCyl(2:3,top1);
for p = 1:size(UVMarker,1)
    UVMarker(p,1,:) = UVMarker(p,1,:) + transMarker(1);
    UVMarker(p,2,:) = UVMarker(p,2,:) + transMarker(2);
    plot( squeeze(UVMarker(p,1,:)), squeeze(UVMarker(p,2,:)), cols{p} );
    plot( UVMarker(p,1,1), UVMarker(p,2,1), '*k', 'MarkerSize', 15 );
end
axis equal
title('UVLine aligned with Markers');

%% Now promote to 3D
XYZGrid = ones( size(UVLine,1), 4, size(UVLine,3) );
XYZMarkers = ones( size( UVMarker,1), 4, size( UVMarker,3) );

for p = 1:size(XYZGrid,1)
    XYZGrid(p,1,:) = ptsGrid(1,1);
    XYZGrid(p,2,:) = UVLine(p,1,:);
    XYZGrid(p,3,:) = UVLine(p,2,:);
end

for p = 1:size(XYZMarkers,1)
    XYZMarkers(p,1,:) = XYZMappedToCyl(1,1,1);
    XYZMarkers(p,2,:) = UVMarker(p,1,:);
    XYZMarkers(p,3,:) = UVMarker(p,2,:);
end




end

