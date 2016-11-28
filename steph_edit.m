%Steph paper edits 

%Find the stretch of the actuator as pressure increases over time graph 
function[horizontal_average,P] = steph_edit()
% Import the points to correspond the top and bottom ones  
%Find the average between each horizontal point 
filename = 'Best motion Take 2016-02-19 04.26.29 PM.csv';
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


% nFrames = size(XYZ,3);
% 
% top_one = zeros(1,1,nFrames);
% top_two = zeros(1,1,nFrames);
% bottom_one = zeros(1,1,nFrames);
% bottom_two = zeros(1,1,nFrames);
% middle_average_one = zeros(1,1,nFrames);
% middle_average_two = zeros(1,1,nFrames);
% horizontal_average = zeros(1,1,nFrames); 
% %Assign the points to new labels 
% for j = 1:3
%     for k = 1:nFrames
%         top_one(1,1,k) = XYZ(2,j,k);
%         top_two(1,1,k) = XYZ(4,j,k); 
%         bottom_one(1,1,k) = XYZ(1,j,k);
%         bottom_two(1,1,k)= XYZ(3,j,k); 
%     end 
% end 
nFrames = size(X_close_top,1); 
middle_average_one = zeros(nFrames,1); 
middle_average_two = zeros(nFrames,1); 
horizontal_average = zeros(nFrames,1); 

for s = 1:nFrames
    middle_average_one(s) = (Y_away_top(s)+Y_away_ridge(s))/2;
    middle_average_two(s) = (Y_close_top(s)+Y_close_ridge(s))/2; 
end 

%Find the distance of the vertical between the average of the horizontal
%points 
% for n = 1:nFrames
%     horizontal_average(1,1,n) = (middle_average_one(1,1,n)+middle_average_two(1,1,n))/2;
% end 

%New values for the relative strain 
original = (middle_average_one(1)- middle_average_two(1));
for n = 1:nFrames
   next = ((middle_average_one(n) - middle_average_two(n))); 
   horizontal_average(n) = abs(next - original) /(original); 
end 

nFrames = size(X_away_top); 
P = zeros(nFrames(1),1);
    %P = reshape(P, [nFrames,1]); 
    %Pressure increase after 2 seconds
P(1:240,:) = linspace(0,0.1,240);
    %Pressure increase after 4 seconds 
P(241:480,:) = linspace(0.1,0.2,240);
    %Pressure increase after 6 seconds
P(481:720,:) = linspace(0.2,0.3,240);
    %Pressure increase after 8 seconds 
P(721:960,:) = linspace(0.3,0.4,240);
    %Pressure increase after 10 seconds 
P(961:1200,:) = linspace(0.4,0.5,240);
    %Pressure increase after 12 seconds 
P(1201:1440,:) = linspace(0.5,0.6,240);
    %Pressure increase after 14 seconds 
P(1441:1680,:) = linspace(0.6,0.7,240);
    %Pressure increase after 16 seconds 
P(1681:1920,:) = linspace(0.7,0.8,240);
    %Pressure increase after 18 seconds 
P(1921:2160,:) = linspace(0.8,0.9,240);
    %Pressure increase after 20 seconds 
P(2161:2400,:) = linspace(0.9,1,240);
    %Pressure increase after 22 seconds
P(2401:2640,:) = linspace(1,1.1,240);
    %Pressure increase after 24 seconds 
P(2641:2880,:) = linspace(1.1,1.2,240);
    %Pressure increase after 26 seconds 
P(2881:3120,:) = linspace(1.2,1.3,240);    
    %Pressure increase after 28 seconds to the end
P(3121:size(horizontal_average,1),:) = linspace(1.3,1.35,(size(horizontal_average,1)-3121+1));
    

% P = zeros(nFrames,1);
%     %P = reshape(P, [nFrames,1]); 
%     %Pressure increase after 2 seconds
% P(1:412,:) = linspace(0,0.1,412);
%     %Pressure increase after 4 seconds 
% P(413:824,:) = linspace(0.1,0.2,412);
%     %Pressure increase after 6 seconds
% P(825:1236,:) = linspace(0.2,0.3,412);
%     %Pressure increase after 8 seconds 
% P(1237:1648,:) = linspace(0.3,0.4,412);
%     %Pressure increase after 10 seconds 
% P(1649:2060,:) = linspace(0.4,0.5,412);
%     %Pressure increase after 12 seconds 
% P(2061:2472,:) = linspace(0.5,0.6,412);
%     %Pressure increase after 14 seconds 
% P(2473:2884,:) = linspace(0.6,0.7,412);
%     %Pressure increase after 16 seconds 
% P(2885:3296,:) = linspace(0.7,0.8,412);
%     %Pressure increase after 18 seconds 
% P(3297:3708,:) = linspace(0.8,0.9,412);
%     %Pressure increase after 20 seconds 
% P(3709:4120,:) = linspace(0.9,1,412);
%     %Pressure increase after 22 seconds
% P(4121:nFrames,:) = 1;

%Plot the graph as the stretch/extension as time/pressure changes
horizontal_average = reshape(horizontal_average, [1,size(horizontal_average)]);


plot(P, horizontal_average)
 title('Pressure verse relative strain of the five chamber actuator');
 xlabel('Pressure');
 ylabel('Strain');
    %Need to get this smoothed out, will try again after looking into the
    %data 
end 











