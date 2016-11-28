function [ UVGrid, UVMarker ] = GetImagePoints( fNameMarker2D, fNameGrid2D )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

data = csvread(fNameGrid2D);
UVMarkerData = load( fNameMarker2D );
UVMarker = UVMarkerData.centers;

figure(3);
set(gcf,'name','2D Grid from camera','numbertitle','off')
clf
nRows = 2;
nCols = 3;
subplot(nRows,nCols,1);

nPts = size(data,1);
nTimePts = floor( size(data,2) / 2 );
UVGrid = ones( nPts, 4, nTimePts );

cols = {'-Xr', '-Xg', '-Xb', '-Xy', '-Xk'};
for p = 1:nPts
    UVGrid(p,1:2,:) = [ data(p,1:nTimePts); -data(p,nTimePts+1:end)];
end
%Smooth data
for f = 1:3
    save = UVGrid;
    for k = 2:nTimePts-1
        UVGrid(p, 1, k) = 0.25 * save(p, 1, k-1) + 0.5 * save(p, 1, k) + 0.25 * save(p, 1, k+1);
        UVGrid(p, 2, k) = 0.25 * save(p, 2, k-1) + 0.5 * save(p, 2, k) + 0.25 * save(p, 2, k+1);
    end        
    save = UVGrid;
    for p = 2:nPts-1
        UVGrid(p, 1, :) = 0.25 * save(p-1, 1, :) + 0.5 * save(p, 1, :) + 0.25 * save(p+1, 1, :);
        UVGrid(p, 2, :) = 0.25 * save(p-1, 2, :) + 0.5 * save(p, 2, :) + 0.25 * save(p+1, 2, :);
    end        
end
            
for p = 1:nPts
    plot( squeeze(UVGrid(p, 1,:)), squeeze(UVGrid(p,2,:)), cols{p} );
    hold on;
    plot( squeeze(UVGrid(p, 1,1)), squeeze(UVGrid(p,2,1)), '*k', 'MarkerSize', 15 );
end
for t = 1:3:size(UVGrid, 3)
    plot( squeeze(UVGrid(:, 1,t)), squeeze(UVGrid(:,2,t)), '-g' );
end
axis equal
title('UVLine');

for p = 1:size(UVMarker,1);
    UVMarker(p,2,:) = UVMarker(p,2,:) * -1;
    subplot(nRows, nCols, 2);
    plot( squeeze(UVMarker(p, 1,:)), squeeze(UVMarker(p,2,:)), cols{p} );
    hold on;
    plot( squeeze(UVMarker(p, 1,1)), squeeze(UVMarker(p,2,1)), '*k', 'MarkerSize', 15 );
end
axis equal
title('Marker');

subplot(nRows,nCols,1);
plot( UVGrid(1,1,1), UVGrid(1,2,1), '*k', 'MarkerSize', 20);
plot( [UVGrid(:,1,1) UVGrid(:,1,end)], [UVGrid(:,2,1) UVGrid(:,2,end)], '-Ok');
hold on;
plot( [UVGrid(1,1,1) UVGrid(1,1,end)], [UVGrid(1,2,1) UVGrid(1,2,end)], '-Xk');

subplot(nRows,nCols,2);
hold on;
plot( UVMarker(1,1,1), UVMarker(1,2,1), '*k', 'MarkerSize', 20);
plot( [UVMarker(1,1,1) UVMarker(4,1,end)], [UVMarker(1,2,1) UVMarker(4,2,end)], '-Ok');
end

