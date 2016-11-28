%% Call a single data set

clear
close all

%fnameOrig = 'Manual Smooth of Data 2016-02-09 06.04.27 PM.csv';
fnameBetter = 'Best with last video taken on camera Take 2016-02-19 05.16.csv';

%fname2DGridOrig = 'Middlelinepoints.csv';
fname2DMarkerOrig = 'bwActuatorImageTracking.mat';

fname2DGridBetter = 'Middlelinepoints_Two.csv';
% 
%   Black(top2)    Blue(side2)
%  Green(top1)   Red(side1)
% top1 = 2;
% top2 = 4;
% side1 = 1;
% side2 = 3;

% Mapping from actual order to above order
% top1, top2, side1, side2
orderOrig = [ 2, 4, 1, 3];
%ProcessAndAlign( fnameOrig, fname2DMarkerOrig, fname2DGridOrig, 0.0125, 0.03, 5, 0.3, orderOrig );

ProcessAndAlign( fnameBetter, fname2DMarkerOrig, fname2DGridBetter, 0.0125, 0.025, 4, 0.5, orderOrig );
