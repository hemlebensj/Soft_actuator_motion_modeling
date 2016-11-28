function [EMax, EMin, Fij] = AnalyticStrainFromVecs( vecDs1, vecDt1, vecDs2, vecDt2 )
% Take both to the plane, matching bisectors
% Map from f' back to f
rotToPlane1 = RotateToXYZ( vecDs1, vecDt1 );
rotToPlane2 = RotateToXYZ( vecDs2, vecDt2 );

matA = (rotToPlane1 * [vecDs1, vecDt1, [0;0;1]]);
matB = (rotToPlane2 * [vecDs2, vecDt2, [0;0;1]]);

matMap = matB(1:2,1:2) * inv(matA(1:2,1:2)) ;

% Now take svd to find eigen values
Fij = matMap' * matMap;
[U S Vt] = svd( Fij );

Ssq = [ S(1,1).^0.5, 0; 0, S(2,2).^0.5 ];
Fij = U * Ssq * Vt';

S1 = 0.5 .* ( S(1,1) - 1 );
S2 = 0.5 .* ( S(2,2) - 1 );
EMax = max( S1, S2 );
EMin = min( S1, S2 );

