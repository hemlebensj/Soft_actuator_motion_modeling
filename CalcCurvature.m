function crv = CalcCurvature( p1, p2, p3 )
%% Calculate the curvature at p2 (p1,p2,p3 are consecutive points on a line)
% Calculations of discrete curvature:
%  1) For a circle, the curvature is 1/R, where R is the radius of the circle.
%  2) Curvature is also change in angle over change in length (d Theta / d s)
%     Change in angle is approximated by the exterior angle between v1 and v2
%     ie, acos( dot<v1,v2> / ||v1|| ||v2|| ) / u2 - u1  -> theta
%     Change in length is approximated by the average length of v1 and v2
%  3) Can also get by taking cross product and measuring lengths

% Vectors between points
v1 = p2 - p1;
v2 = p3 - p2;
lenV1 = sqrt( v1(1,:).^2 + v1(2,:).^2 ); % Vec lengths
lenV2 = sqrt( v2(1,:).^2 + v2(2,:).^2 );
% Length between p1 and p3 - used to determine if infinite curvature
lenV13 = sqrt( (p3(1,:) - p1(1,:)).^2 + (p3(2,:) - p1(2,:)).^2 );

% Make zeros
crv = zeros( 1, size(p1,2) );
% If one of the segments is zero length then need to set to value of
% neighbor; in practice, set to zero
flat = lenV1 < 1e-16 | lenV2 < 1e-16;
% If p1 and p2 are same, infinite curvature
folded = lenV13 < 1e-16;
% Cap at a maximum value
crv(folded) = 1e10;
% For all other points, calculate d theta / ds
colIndex = ~flat & ~folded;
% d Theta
dotVs(colIndex) = ( v1(1,colIndex) .* v2(1,colIndex) + v1(2,colIndex) .* v2(2,colIndex) ) ./ ( lenV1(colIndex) .* lenV2(colIndex) );
% Fix numerical error
dotVs( dotVs > 1.0 ) = 1.0;
dotVs( dotVs < -1.0 ) = -1.0;
% Get angle
chngAngle(colIndex) = acos( dotVs(colIndex) );
% Get length
chngLen(colIndex) = 0.5 * ( lenV1(colIndex) + lenV2(colIndex) );

% Curvature
crv(colIndex) = chngAngle(colIndex) ./ chngLen(colIndex);

% Are we curving to the left or to the right? Cross product
orientation = v1(2,:) .* v2(1,:) - v1(1,:) .* v2(2,:);
% Use sign to indicate curvature direction
crv( orientation > 0.0 ) = crv( orientation > 0.0 ) * -1.0;


end

