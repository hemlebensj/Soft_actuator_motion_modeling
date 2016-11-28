function vecNorm = NormalToPoints( pts )
% Find the normal to the set of points using cross product

vecNorm = cross( pts(end,:), pts(1,:) );
for k = 1:size(pts,1)-1
    vecNorm = vecNorm + cross( pts(k,:), pts(k+1,:) );
end

vecNorm = vecNorm ./ norm( vecNorm );

