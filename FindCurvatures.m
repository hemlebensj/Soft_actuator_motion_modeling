function [ crvs ] = FindCurvatures( GridXYZ )
%Calc curvatures

% G
% nCrvs = 5;
nCrvs = 4;
crvs = zeros( nCrvs, size(GridXYZ,3) );

npts = size(GridXYZ,1);

nResample = npts*5;
pts2DR = zeros(2,nResample);
for t = 1:size(GridXYZ,3)
    pts2D = squeeze( GridXYZ(:,2:3, t ) )';
    [X,Y] = ArcLengthSampling( pts2D(1,:), pts2D(2,:), 10 );
    pts2DR(1,:) = interp1( linspace(0,1,length(X)), X, linspace(0,1,nResample), 'spline' );
    pts2DR(2,:) = interp1( linspace(0,1,length(Y)), Y, linspace(0,1,nResample), 'spline' );
    
    crv = CalcCurvature( pts2DR(:,1:nResample-2), pts2DR(:,2:nResample-1), pts2DR(:,3:end) );
    indices = floor( linspace(0,length(crv), nCrvs) ) + 1;
    indices(end) = indices(end)-1;
    crvs(:,t) = crv( indices )';
end            

end

