function [EMax, EMin, Fij] = AnalyticStrain( pts1, pts2, h )
% pts1 and 2 should be centered at the origin (i.e., q_i - p, not q_i)
% pts1 and 2 should be nX3 matrices, n being the number of points
% vecDs, vecDt is the derivative at p (only used for calculating Fij)

%Store for future use
nPts = size( pts1, 1 );

%% Fit a polynomial to pts1 and pts2
% Need s,t values - should be same for both point sets because they represent f1(s,t) and f2(phi(s,t) )
% Find the normal to pts1 and get s,t from projecting to the plane

% Find the rotation matrix that takes the bisector of vecDs and vecDt to the 
% diagonal, and the normal to z
normPts1 = NormalToPoints(pts1);
rotToPlane = RotateToXYZ( pts1(1,:)', cross( normPts1, pts1(1,:) )' );

% Degree 2 polynomials a0 s^2 + a1 t^2 + a2 s t + a3 s + a4 t + a5

Apts = zeros( nPts+1, 6 );
stSave = zeros( nPts+1, 2 );
for k = 1:nPts
    st = rotToPlane * pts1(k,:)';
    stSave(k,1) = st(1);
    stSave(k,2) = st(2);
    Apts(k,:) = [ st(1).^2, st(2).^2, st(1) * st(2), st(1), st(2), 1 ];
end
Apts( nPts+1, 6 ) = 1;  % Center point

bpts = zeros( nPts+1, 6 );
bpts( 1:end-1, 1:3 ) = pts1;
bpts( 1:end-1, 4:6 ) = pts2;

polys = Apts \ bpts;

% for k = 1:nPts
%     pt1(1,1:3) = polys(1,1:3) .* stSave(k,1).^2 + ...
%                  polys(2,1:3) .* stSave(k,2).^2 + ...
%                  polys(3,1:3) .* stSave(k,1).^2 .* stSave(k,2).^2 + ...
%                  polys(4,1:3) .* stSave(k,1).^2 + ...
%                  polys(5,1:3) .* stSave(k,2).^2 + ...
%                  polys(6,1:3);
%     pt1 - Apts(k)
% end

% Take the derivative at 0,0 for both polynomials
% d p(s,t)/ds = 2 * a0 * s + a2 * t + a3, evaluated at 0,0 is a3
% d p(s,t)/dt = 2 * a1 * t + a2 * 2 + a4, evaluated at 0,0 is a4
vecDs1 = polys(4,1:3)';
vecDt1 = polys(5,1:3)';
vecDs2 = polys(4,4:6)';
vecDt2 = polys(5,4:6)';

% Extract strain and tensor
[EMax, EMin, Fij] = AnalyticStrainFromVecs( vecDs1, vecDt1, vecDs2, vecDt2 );



