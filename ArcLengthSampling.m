function [X, Y] = ArcLengthSampling( xs, ys, n )
% Resample the polyline to be arc-length
%   Use interp1 to do so

vxs = xs(2:end) - xs(1:end-1);
vys = ys(2:end) - ys(1:end-1);

lens = sqrt( vxs.^2 + vys.^2 );

lenSum = zeros( 1, size(xs, 2) );
lenSum(1) = 0;
for k = 2:length(lenSum)
    lenSum(k) = lenSum(k-1) + lens(k-1);
    if lens(k-1) < 1e-16
        lenSum(k) = lenSum(k) + 1e-16;
    end
end
lenSum = lenSum ./ lenSum(end);

ts = linspace( 0,1, n );

X = interp1( lenSum, xs, ts, 'linear' );
Y = interp1( lenSum, ys, ts, 'linear' );

% len = sum(lens);
% 
% dStep = len / n;
% X = zeros(1,n+1);
% Y = zeros(1,n+1);
% 
% X(1) = xs(1);
% Y(1) = ys(1);
% X(end) = xs(end);
% Y(end) = ys(end);
% 
% dAlong = 0;
% dLeft = dStep;
% iSeg = 1;
% iPt = 2;
% while iSeg <= length(lens);
%     if lens(iSeg) - dAlong > dLeft
%         dAlong = dAlong + dLeft;
%         dPerc = dAlong / lens(iSeg);
%         X(iPt) = (1 - dPerc) * xs(iSeg) + dPerc * xs(iSeg+1);
%         Y(iPt) = (1 - dPerc) * ys(iSeg) + dPerc * ys(iSeg+1);
%         iPt = iPt + 1;
%         dLeft = dStep;
%     else
%         dLeft = dLeft - (lens(iSeg) - dAlong);
%         iSeg = iSeg + 1;
%         dAlong = 0;
%     end
end
%     double dAlong = 0.0, dLeft = dStep;
%     int iSeg = 0;
%     
%     crvOut.AddPoint( m_apt[0] );
%     while ( iSeg < m_apt.num() - 1 ) {
%         if ( adDist[iSeg] - dAlong > dLeft ) {
%             dAlong += dLeft;
%             crvOut.AddPoint( Lerp( m_apt[iSeg], m_apt[iSeg+1], dAlong / adDist[iSeg] ) );
%             dLeft = dStep;
%         } else {
%             dLeft -= adDist[iSeg] - dAlong;
%             ASSERT( dLeft >= 0.0 );
%             iSeg++;
%             dAlong = 0.0;
%         }
%     }
% 
% end

