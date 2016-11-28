function matRot = BestRotation( pts1, pts2 )

%% Find the rotation that best takes pts2 to pts1
ARot = pts1' * pts2; % dot product of all points
[URot S VRot] = svd( ARot );
matRot = ( URot * VRot' );
