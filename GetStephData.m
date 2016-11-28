function [ times, XYZ ] = GetStephData( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

strs = {'X', 'Y', 'Z'};
cols = {'-Xr', '-Xg', '-Ob', '-Ok'};

data = csvread(filename, 9, 1);
if (data(end,2) == 0 )
    data = data(1:end-1,:);
end

nPts = floor( sum( data(1,:) ~= 0 ) / 3 );
times = data(:,1)';
nFrames = length(times);

XYZ = ones( nPts, 4, nFrames );
col = 2;
count = 1;
for p = 1:nPts
    for k = 1:3
        XYZ(p,k,:) = data(:,col)';
        col = col+1;
        fprintf('%s min %0.4f max %0.4f, \n', strs{k}, min(data(:,col)), max(data(:,col)));
        subplot( nPts, 4, count );
        plot( times, squeeze(XYZ(p,k,:))', cols{p} );
        title(strs{k});
        count = count+1;
    end
    subplot( nPts, 4, count );
    plot3( squeeze(XYZ(p,1,:))', squeeze(XYZ(p,2,:))', squeeze(XYZ(p,3,:))', cols{p} );
    title(strcat('Pt ', num2str(p)) );
    axis equal
    count = count+1;
    fprintf('\n');
    axis equal
end
    
end

