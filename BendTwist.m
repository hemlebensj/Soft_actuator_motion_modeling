function [ angBend, angTwist ] = BendTwist( XYZ, timePt, order )
%Calculate the bend and twist between the ends of the cylinder
%   Detailed explanation goes here

% 
%   Black(top2)    Blue(side2)
%  Green(top1)   Red(side1)

top1 = order(1);
top2 = order(2);
side1 = order(3);
side2 = order(4);

% Vector connecting the two bottom and two top points
vecE1 = XYZ(side1, 1:3,timePt) - XYZ(top1, 1:3,timePt);
vecE2 = XYZ(side2, 1:3,timePt) - XYZ(top2, 1:3,timePt);

% Get rid of the x component
vecE1Bend = vecE1;
vecE1Bend(1) = 0;
vecE1Bend = vecE1Bend / sqrt(vecE1Bend*vecE1Bend');

vecE2Bend = vecE2;
vecE2Bend(1) = 0;
vecE2Bend = vecE2Bend / sqrt(vecE2Bend*vecE2Bend');

angBend = acos( dot( vecE1Bend, vecE2Bend ) );

% Get rid of the z component
vecE1Twist = vecE1;
vecE1Twist(3) = 0;
vecE1Twist = vecE1Twist / sqrt(vecE1Twist*vecE1Twist');

vecE2Twist = vecE2;
vecE2Twist(3) = 0;
vecE2Twist = vecE2Twist / sqrt(vecE2Twist*vecE2Twist');

angTwist = acos( dot( vecE1Twist, vecE2Twist ) );

end

