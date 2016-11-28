function matAlign = AlignPoints( pts1, pts2 )
% Assumes already rotated with normal in z, vecBisect at 0.5, 0.5,0

matAlign = [ 1,0; 0,1 ];
nPts = size(pts1,1);

%% Force into plane by setting length to be 3D length
for k=1:nPts
    xyLen = norm( pts1(k,1:2) );
    len = norm( pts1(k,1:3) );
    pts1(k,1:2) = pts1(k,1:2) .* (len ./ xyLen);
    pts1(k,3) = 0;
end
for k=1:nPts
    xyLen = norm( pts2(k,1:2) );
    len = norm( pts2(k,1:3) );
    pts2(k,1:2) = pts2(k,1:2) .* (len ./ xyLen);
    pts2(k,3) = 0;
end

ASolveLS = zeros( 2 * nPts, 3 );
RhsSolveLS = zeros( 2 * nPts, 1 );

for iR=1:nPts
    ASolveLS( 2*iR+0, 1 ) = pts1(iR,1);
    ASolveLS( 2*iR+0, 2 ) = pts1(iR,2);

    ASolveLS( 2*iR+1, 2 ) = pts1(iR,1);
    ASolveLS( 2*iR+1, 3 ) = pts1(iR,2);

    RhsSolveLS( 2*iR+0, 1 ) = pts2(iR,1);
    RhsSolveLS( 2*iR+1, 1 ) = pts2(iR,2);
end

xSolveLS = ASolveLS\RhsSolveLS;

% Symmetrical matrix; by construction this takes vecDs to the desired
% axes because points rotated so vecDs is x axis
matAlign = [ xSolveLS(1,1), xSolveLS(2,1); ...
             xSolveLS(2,1), xSolveLS(3,1) ];

