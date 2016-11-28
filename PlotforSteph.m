%Plotting Steph's Mocap Video Data
function [P,X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
    X_close_ridge, Y_close_ridge, Z_close_ridge] = PlotforSteph()
%filename = 'Manual Smooth of Data 2016-02-09 06.04.27 PM.csv';
%filename = 'Actuator Edit Take Two 2016-02-09 06.04.27 PM.csv';
filename = 'Best motion Take 2016-02-19 04.26.29 PM.csv';
%M = zeros(1,2623);
RNG = [9, 5, 9, 23];
%M = csvread(filename,10,10,[10,10,12,12]);
%M = csvread(filename, 9, 5, 2623);
time = csvread(filename, 9, 1, [9 1 4533 1]); 
ts = [0:1:4524];

X_away_top = csvread(filename, 9, 2, [9 2 4533 2]); 
valid = X_away_top ~=0; 
X_away_top(~valid)=interp1(ts(valid),X_away_top(valid),ts(~valid));

Y_away_top = csvread(filename, 9, 3, [9 3 4533 3]);
valid = Y_away_top ~=0; 
Y_away_top(~valid)=interp1(ts(valid),Y_away_top(valid),ts(~valid));

Z_away_top = csvread(filename, 9, 4, [9 4 4533 4]);
valid = Z_away_top ~=0; 
Z_away_top(~valid)=interp1(ts(valid),Z_away_top(valid),ts(~valid));

X_away_ridge = csvread(filename, 9, 5, [9 5 4533 5]); 
valid = X_away_ridge ~=0; 
X_away_ridge(~valid)=interp1(ts(valid),X_away_ridge(valid),ts(~valid));

Y_away_ridge = csvread(filename, 9, 6, [9 6 4533 6]);
valid = Y_away_ridge ~=0; 
Y_away_ridge(~valid)=interp1(ts(valid),Y_away_ridge(valid),ts(~valid));

Z_away_ridge = csvread(filename, 9, 7, [9 7 4533 7]);
valid = Z_away_ridge ~=0; 
Z_away_ridge(~valid)=interp1(ts(valid),Z_away_ridge(valid),ts(~valid));

X_close_top = csvread(filename, 9, 8, [9 8 4533 8]); 
valid = X_close_top ~=0; 
X_close_top(~valid)=interp1(ts(valid),X_close_top(valid),ts(~valid));

Y_close_top = csvread(filename, 9, 9, [9 9 4533 9]);
valid = Y_close_top ~=0; 
Y_close_top(~valid)=interp1(ts(valid),Y_close_top(valid),ts(~valid));

Z_close_top = csvread(filename, 9, 10, [9 10 4533 10]);
valid = Z_close_top ~=0; 
Z_close_top(~valid)=interp1(ts(valid),Z_close_top(valid),ts(~valid));

X_close_ridge = csvread(filename, 9, 11, [9 11 4533 11]); 
valid = X_close_ridge ~=0; 
X_close_ridge(~valid)=interp1(ts(valid),X_close_ridge(valid),ts(~valid));

Y_close_ridge = csvread(filename, 9, 12, [9 12 4533 12]);
valid = Y_close_ridge ~=0; 
Y_close_ridge(~valid)=interp1(ts(valid),Y_close_ridge(valid),ts(~valid));

Z_close_ridge = csvread(filename, 9, 13, [9 13 4533 13]);
valid = Z_close_ridge ~=0; 
Z_close_ridge(~valid)=interp1(ts(valid),Z_close_ridge(valid),ts(~valid));

P = zeros(4525,1);
    %P = reshape(P, [4525,1]); 
    %Pressure increase after 2 seconds
P(1:412,:) = linspace(0,0.1,412);
    %Pressure increase after 4 seconds 
P(413:824,:) = linspace(0.1,0.2,412);
    %Pressure increase after 6 seconds
P(825:1236,:) = linspace(0.2,0.3,412);
    %Pressure increase after 8 seconds 
P(1237:1648,:) = linspace(0.3,0.4,412);
    %Pressure increase after 10 seconds 
P(1649:2060,:) = linspace(0.4,0.5,412);
    %Pressure increase after 12 seconds 
P(2061:2472,:) = linspace(0.5,0.6,412);
    %Pressure increase after 14 seconds 
P(2473:2884,:) = linspace(0.6,0.7,412);
    %Pressure increase after 16 seconds 
P(2885:3296,:) = linspace(0.7,0.8,412);
    %Pressure increase after 18 seconds 
P(3297:3708,:) = linspace(0.8,0.9,412);
    %Pressure increase after 20 seconds 
P(3709:4120,:) = linspace(0.9,1,412);
    %Pressure increase after 22 seconds
P(4121:4525,:) = 1;
    
   
    
%plot3(X_away_top,Y_away_top, P)
%plot3(P, X_away_top, Y_away_top)
%magnitude= dist([X_away_top, Y_away_top]);
%mags = sqrt((X_away_top(1) - X_away_top).^2 + (Y_away_top(1) - Y_away_top).^2);
%plot(P,mags);
%xlabel('Pressure');
%ylabel('Magnitude of movement for X and Y');
%hold on 
plot(ts, X_close_ridge); 

%plot(time,P,'g')
%plot(P, X_away_top, 'r');

title('Magnitude of movement in X,Y-direction verses Time')
%plot(P, Y_away_top,'g');
end 


