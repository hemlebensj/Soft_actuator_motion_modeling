function [ XYZOptiTrak, XYZMarkers ] = ProcessAndAlign( fNameOptiTrak, fNameMarker2D, fNameGrid2D, cylRadius, cylHeight, nChambers, gridPerc, order )
%Read in the data and align it
%   Need to know the actual physical size of the cylinder

%% Variables
cols = {'-Xr', '-Xg', '-Ob', '-Ok'};
cols2 = {'*r', '*g', '*b', '*y', '*k'};

%% Read raw optitrak data and display it
figure(1);
set(gcf,'name','Raw XYZ data','numbertitle','off')
clf

% Store as 4 points, XYZ1, # of frames
[times, XYZ] = GetStephData(fNameOptiTrak );

% 
%   Black(top2)    Blue(side2)
%  Green(top1)   Red(side1)

top1 = order(1);
top2 = order(2);
side1 = order(3);
side2 = order(4);

%% Make cylinder
% Determine the angle between the dots;
%  Distance between the dots on the top & bottom, averaged
arcCyl = 0.5 * (sqrt( sum( ( XYZ(top1,1:3,1) - XYZ(side1,1:3,1) ).^2 ) ) + ...
                 sqrt( sum( ( XYZ(top2,1:3,1) - XYZ(side2,1:3,1) ).^2 ) ) );
myCyl = @(t,h) [ cylRadius .* cos(t); cylRadius .* sin(t); -cylHeight * 0.5 + h .* cylHeight ];
circum = 2 * pi * cylRadius;

% FIXME - make sure the spacing between the grid lines is correct
spcing = 0.005;
nSpcBtwnDots = 3;

percArc = circum / (nSpcBtwnDots * spcing);
angleBtwnDots = 2.0 * pi * (nSpcBtwnDots * spcing) / circum;
angle = 0.6 * angleBtwnDots;
angle = atan2(arcCyl/2, cylRadius);

thetaPts = [angle,-angle,angle,-angle];
% Was suppose to be at the middle of the first and fourth ring
% FIXME - if there are 5 chambers and the dot is in the middle of the
% chamber than this should be [0.5/5, 3.5/5] but I adjusted a bit because
% the markers weren't glued on in the middle
heightPts = [(0.5/nChambers), (0.5/nChambers), (nChambers-0.5)/nChambers, (nChambers-0.5)/nChambers];
%heightPts = [(0.25/nChambers), (0.75/nChambers), 3.4/nChambers, 3.4/nChambers];

ptsCyl = myCyl( thetaPts, heightPts );
ptsCyl(4,:) = ones(1, size(ptsCyl,2));
heightGrid = linspace(0.5/5, 4.5/5, nChambers);
thetaGrid = ones(size(heightGrid)) * (angle - gridPerc * (2*angle));
ptsGrid = myCyl( thetaGrid, heightGrid);

% Check lengths
CheckLengths(ptsCyl(1:3,:), squeeze(XYZ(:,1:3,1))', cylHeight, nChambers, order );

[X,Y,Z] = cylinder(cylRadius);
Z(1,:) = -cylHeight * 0.5;
Z(2,:) =  cylHeight * 0.5;
% cylXYZ = ones(4, size(X,1) * size(X,2) );
% cylXYZ(1,:) = reshape(X, [size(cylXYZ,2), 1] );
% cylXYZ(2,:) = reshape(Y, [size(cylXYZ,2), 1] );
% cylXYZ(3,:) = reshape(Z, [size(cylXYZ,2), 1] );

% Draw the cylinder with the four "canonical" points on the cylinder
figure(2);
set(gcf,'name','Cylinder with rigid-body aligned OptiTrak points','numbertitle','off')
nR = 2;
nC = 2;
clf
% Draw cylinder and points
for k = 1:2
    subplot(nR,nC,k);
    surf(X,Y,Z, 'EdgeColor', [0,0,0], 'FaceColor', [0.95 0.95 0.95]);
    camlight 'left';
    lighting phong;
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    axis equal;
    view(90,10)
    hold on;
    plot3( ptsCyl(1,:), ptsCyl(2,:), ptsCyl(3,:), 'Xk', 'MarkerSize', 20 );
    plot3( ptsGrid(1,:), ptsGrid(2,:), ptsGrid(3,:), 'O-G', 'MarkerSize', 10 );
    title('Cylinder coordinate frame with Optitrak and 2D data');
end

% Align to XYZ
[XYZMappedToCyl, matToMapAll] = MapToCylinder( ptsCyl, XYZ );

subplot(nR,nC,1);
plot3( [XYZMappedToCyl(top1,1,1), XYZMappedToCyl(top2,1,1)], [XYZMappedToCyl(top1,2,1), XYZMappedToCyl(top2,2,1)],[XYZMappedToCyl(top1,3,1), XYZMappedToCyl(top2,3,1)], '-y', 'LineWidth', 2 );
plot3( [XYZMappedToCyl(side1,1,1), XYZMappedToCyl(side2,1,1)], [XYZMappedToCyl(side1,2,1), XYZMappedToCyl(side2,2,1)],[XYZMappedToCyl(side1,3,1), XYZMappedToCyl(side2,3,1)], '--y', 'LineWidth', 2 );
nFrames = size( XYZ, 3 );
for k = 1:4    
    plot3( squeeze(XYZMappedToCyl(k,1,1:nFrames)), squeeze(XYZMappedToCyl(k,2,1:nFrames)), squeeze(XYZMappedToCyl(k,3,1:nFrames)), cols{k});
end
axis equal;

figure(2);
subplot(nR,nC,3);
hold off;
plot3( [XYZ(top1,1,1), XYZ(top2,1,1)], [XYZ(top1,2,1), XYZ(top2,2,1)],[XYZ(top1,3,1), XYZ(top2,3,1)], '-y', 'LineWidth', 2 );
hold on;
plot3( [XYZ(side1,1,1), XYZ(side2,1,1)], [XYZ(side1,2,1), XYZ(side2,2,1)],[XYZ(side1,3,1), XYZ(side2,3,1)], '--y', 'LineWidth', 2 );
for k = 1:4    
    plot3( squeeze(XYZ(k,1,1:nFrames)), squeeze(XYZ(k,2,1:nFrames)), squeeze(XYZ(k,3,1:nFrames)), cols{k}, 'MarkerSize', 10);
end
title('Raw OptiTrak data verse pressure');
axis equal
view(3);
xlabel('X axis');
ylabel('Y axis');
zlabel('Z axis');

%% Now do the 2D stuff
[Grid3D, Marker3D] = ImageDataToCylinder( fNameMarker2D, fNameGrid2D, XYZMappedToCyl, ptsGrid, ptsCyl, order );
% Plot with cylinder
figure(2);
subplot(nR,nC,2);
% Plot grid
plot3( Grid3D(:,1,1), Grid3D(:,2,1), Grid3D(:,3,1), '-Ok');
% Plot markers
for p = 1:size(Marker3D,1)
    plot3( squeeze(Marker3D(p,1,:)), squeeze(Marker3D(p,2,:)), squeeze(Marker3D(p,3,:)), cols2{p} );
end
title('2D Data on Cylinder');

figure(5);
set(gcf,'name','Bend, Twist, Presure','numbertitle','off')
clf
nRows = 1;
nCols = 4;
angBend = zeros(1,nFrames);
angTwist = zeros(1,nFrames);
for k = 1:nFrames
    [angBend(k), angTwist(k)] = BendTwist( XYZMappedToCyl, k, order );
end

% Get pressure
[horizontal_average,P]=stretchCyl(XYZ);
figure(6)
%subplot(nRows,nCols,1);
plot( P(1:nFrames), angBend );
xlim([0 1.35])
%title('Bend versus pressure');
xlabel('Pressure (psi)');
ylabel('Bend angle (radians)');

figure(7)
%subplot(nRows,nCols,2);
plot( P(1:nFrames), angTwist );
xlim([0 1.35])
title('Twist versus pressure');
xlabel('Pressure (psi)');
ylabel('Twist angle (radians)');

figure(8)
%Generate extension/stretch graph 
%subplot(nRows,nCols,3);
plot(P, horizontal_average)
xlim([0 1.35])
title('Extension versus pressure');
xlabel('Pressure (psi)');
ylabel('Horizontal extention (mm)');

figure(9)
%subplot(nRows,nCols,4);
hold off;
crvs = FindCurvatures(Grid3D);
crvInds = floor( linspace(1,length(times), size(crvs,2) ) );
colLines = {'-r', '-g', '-b', '-c', '-k'};
for k = 1:size(crvs,1)
    plot(P(crvInds), crvs(k,:), colLines{k})
    hold on;
end
legend('Pos1', 'Pos2', 'Pos3', 'Pos4', 'Pos5' );
xlim([0 1.35])
%legend('Pos1', 'Pos2', 'Pos3', 'Pos4' );
title('Curvature versus Pressure');
xlabel('Pressure (psi)');
ylabel('Curvature (mm^(-1))');



end

