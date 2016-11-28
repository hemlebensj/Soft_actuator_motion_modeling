function [  ] = CheckLengths( ptsCyl, ptsMarkers, cylHeight, nChambers, order )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% 
%   Black(top2)    Blue(side2)
%  Green(top1)   Red(side1)

top1 = order(1);
top2 = order(2);
side1 = order(3);
side2 = order(4);

lenH1c = sqrt( sum( (ptsCyl(:,top1) - ptsCyl(:,top2)).^2 ) );
lenH1m = sqrt( sum( (ptsMarkers(:,top1) - ptsMarkers(:,top2)).^2 ) );

lenH2c = sqrt( sum( (ptsCyl(:,side1) - ptsCyl(:,side2)).^2 ) );
lenH2m = sqrt( sum( (ptsMarkers(:,side1) - ptsMarkers(:,side2)).^2 ) );

fprintf('Height cyl %f diff %f, %0f\n', cylHeight, lenH1c - lenH1m, lenH2c-lenH2m );
expHeight = nChambers * 0.5 * (lenH1m + lenH2m) / (nChambers - 0.5 - 0.5); 
fprintf('To make match, cyl height would be %f\n', expHeight);

lenW1c = sqrt( sum( (ptsCyl(:,top1) - ptsCyl(:,side1)).^2 ) );
lenW1m = sqrt( sum( (ptsMarkers(:,top1) - ptsMarkers(:,side1)).^2 ) );

lenW2c = sqrt( sum( (ptsCyl(:,top2) - ptsCyl(:,side2)).^2 ) );
lenW2m = sqrt( sum( (ptsMarkers(:,top2) - ptsMarkers(:,side2)).^2 ) );

fprintf('Width diff %0f, %0f\n', lenW1c - lenW1m, lenW2c-lenW2m );
end

