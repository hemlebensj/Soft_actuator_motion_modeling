%Curve implementation for Steph
%Reads in all of the data from the mocap point data
% [X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
%     X_close_ridge, Y_close_ridge, Z_close_ridge] = PlotforSteph();
% %Takes the points 
% [cylinder_points, mocap_points] = Cylinder(X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
%     X_close_ridge, Y_close_ridge, Z_close_ridge);
% 
% 44fr48u8u
figure(1);
set(gcf,'name','Raw XYZ data','numbertitle','off')
clf
clear
cols = {'-Xr', '-Xg', '-Ob', '-Ok'};
cols2 = {'*r', '*g', '*b', '*y', '*k'};

% FIXME actual file name
%filename = 'Actuator Update Take 2016-02-09 06.04.27 PM.csv';
%filename = 'Actuator Edit Take Two 2016-02-09 06.04.27 PM.csv';
%filename = 'Manual Smooth of Data 2016-02-09 06.04.27 PM.csv';
filename = 'Best motion Take 2016-02-19 04.26.29 PM.csv';
% Get point track data
XYZ = ones( 4, 4, 4525 );
for k = 1:4
    data = GetStephData(filename, 1 + (k-1) * 3);
    XYZ(k,1:3,:) = data;
    fprintf('range ');
    for m = 1:3
        fprintf('%0.2f %0.2f, ', min(XYZ(k,m,:)), max(XYZ(k,m,:)));
    end
    fprintf('\n');
end

%% FIXME in milliseconds
% Should be linsapce(0, total milliseconds, XYZ )
times = linspace(0,3000, size(XYZ,3));

% 
%   Black(top2)    Blue(side2)
%  Green(top1)   Red(side1)

order = [2 4 1 3];
top1 = 2;
top2 = 4;
side1 = 1;
side2 = 3;

%% Make cylinder
% FIXME - make sure the radius and height of cylinder are correct
radiusFromPts = 0.0125; %0.5 * sqrt( sum( ( XYZ(side1,1:3,1) - XYZ(side2,1:3,1) ).^2 ) );
heightCyl = 0.03;% 1.3 * 0.5 * (sqrt( sum( ( XYZ(top1,1:3,1) - XYZ(top2,1:3,1) ).^2 ) ) + ...
                 %  sqrt( sum( ( XYZ(side1,1:3,1) - XYZ(side2,1:3,1) ).^2 ) ) );
arcCyl = 0.5 * (sqrt( sum( ( XYZ(top1,1:3,1) - XYZ(side1,1:3,1) ).^2 ) ) + ...
                 sqrt( sum( ( XYZ(top2,1:3,1) - XYZ(side2,1:3,1) ).^2 ) ) );
myCyl = @(t,h) [ radiusFromPts .* cos(t); radiusFromPts .* sin(t); -heightCyl * 0.5 + h .* heightCyl ];
circum = 2 * pi * radiusFromPts;
% FIXME - make sure the spacing between the grid lines is correct
spcing = 0.005;
nSpcBtwnDots = 3;

percArc = circum / (nSpcBtwnDots * spcing);
angleBtwnDots = 2.0 * pi * (nSpcBtwnDots * spcing) / circum;
angle = 0.6 * angleBtwnDots;

thetaPts = [angle,-angle,angle,-angle];
% Was suppose to be at the middle of the first and fourth ring
% FIXME - if there are 5 chambers and the dot is in the middle of the
% chamber than this should be [0.5/5, 3.5/5] but I adjusted a bit because
% the markers weren't glued on in the middle
heightPts = [(0.25/5), (0.75/5), 3.4/5, 3.4/5];

ptsCyl = myCyl( thetaPts, heightPts );
ptsCyl(4,:) = ones(1, size(ptsCyl,2));
heightGrid = linspace(0.5/5, 4.5/5, 5);
thetaGrid = ones(size(heightGrid)) * (angle - 0.3 * (2*angle));
ptsGrid = myCyl( thetaGrid, heightGrid);

[X,Y,Z] = cylinder(radiusFromPts);
Z(1,:) = -heightCyl * 0.5;
Z(2,:) =  heightCyl * 0.5;
cylXYZ = ones(4, size(X,1) * size(X,2) );
cylXYZ(1,:) = reshape(X, [size(cylXYZ,2), 1] );
cylXYZ(2,:) = reshape(Y, [size(cylXYZ,2), 1] );
cylXYZ(3,:) = reshape(Z, [size(cylXYZ,2), 1] );

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
nFrames = 1500; %size( XYZ, 3 );
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
title('Raw OptiTrak data over time');
axis equal
view(3);
xlabel('X axis');
ylabel('Y axis');
zlabel('Z axis');

%% Now do the 2D stuff
[Grid3D, Marker3D] = ImageDataToCylinder( XYZMappedToCyl, ptsGrid, ptsCyl, order );
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
set(gcf,'name','Bend, Twist, Presure over time','numbertitle','off')
clf
nRows = 1;
nCols = 4;
angBend = zeros(1,nFrames);
angTwist = zeros(1,nFrames);
for k = 1:nFrames
    [angBend(k), angTwist(k)] = BendTwist( XYZMappedToCyl, k, order );
end
subplot(nRows,nCols,1);
plot( times(1:nFrames), angBend );
title('Bend over time');
xlabel('Time (ms)');
ylabel('Bend angle (degrees)');

subplot(nRows,nCols,2);
plot( times(1:nFrames), angTwist );
title('Twist over time');
xlabel('Time (ms)');
ylabel('Twist angle (degrees)');
 
%Generate extension/stretch graph 
subplot(nRows,nCols,3);
[horizontal_average,P]=stretchCyl(XYZ);

plot(P, horizontal_average)
title('Pressure verse extension of the five chamber actuator');
xlabel('Pressure (??)');
ylabel('Horizontal extention (mm)');

subplot(nRows,nCols,4);
hold off;
crvs = FindCurvatures(Grid3D);
timesCrvs = linspace(0, times(end), size(crvs,2) );
colLines = {'-r', '-g', '-b', '-c', '-k'};
for k = 1:size(crvs,1)
    plot(timesCrvs, crvs(k,:), colLines{k})
    hold on;
end
legend('Pos1', 'Pos2', 'Pos3', 'Pos4', 'Pos5' );
title('Curvature over time');
xlabel('Time (ms)');
ylabel('Curvature');


