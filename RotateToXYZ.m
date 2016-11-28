function rotToPlane = RotateToXYZ( vecDs, vecDt )

% Find the rotation matrix that takes the bisector of vecDs and vecDt to the 
% diagonal, and the normal to z
vecDs =  vecDs ./ norm( vecDs ); % make sure unit length
vecDt =  vecDt ./ norm( vecDt ); % make sure unit length
vecBisect = ( vecDs + vecDt ) ./ norm( ( vecDs + vecDt ) ); % Vector half-way between for determining plane rotation
vecNormPlane = cross( vecDs, vecDt ) ./ norm( cross( vecDs, vecDt ) ); % Rotate this to 0,0,1
vecCoBisectPlane = cross( vecNormPlane, vecBisect );

rotDiag = [ cos(-pi/4), sin(-pi/4), 0; ...
            -sin(-pi/4), cos(-pi/4), 0; ...
            0, 0, 1 ];
rotToPlane = rotDiag * [ vecBisect'; vecCoBisectPlane'; vecNormPlane' ];
