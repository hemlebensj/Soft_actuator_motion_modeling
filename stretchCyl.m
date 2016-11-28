%Find the stretch of the actuator as pressure increases over time graph 
function[horizontal_average,P] = stretchCyl(XYZ)
% Import the points to correspond the top and bottom ones  
%Find the average between each horizontal point 

nFrames = size(XYZ,3);

top_one = zeros(1,1,nFrames);
top_two = zeros(1,1,nFrames);
bottom_one = zeros(1,1,nFrames);
bottom_two = zeros(1,1,nFrames);
middle_average_one = zeros(1,1,nFrames);
middle_average_two = zeros(1,1,nFrames);
horizontal_average = zeros(1,1,nFrames); 
%Assign the points to new labels 
for j = 1:3
    for k = 1:nFrames
        top_one(1,1,k) = XYZ(2,j,k);
        top_two(1,1,k) = XYZ(4,j,k); 
        bottom_one(1,1,k) = XYZ(1,j,k);
        bottom_two(1,1,k)= XYZ(3,j,k); 
    end 
end 
for s = 1:nFrames
    middle_average_one(1,1,s) = (top_one(1,1,s)+top_two(1,1,s))/2;
    middle_average_two(1,1,s) = (bottom_one(1,1,s)+bottom_two(1,1,s))/2; 
end 

%Find the distance of the vertical between the average of the horizontal
%points 
% for n = 1:nFrames
%     horizontal_average(1,1,n) = (middle_average_one(1,1,n)+middle_average_two(1,1,n))/2;
% end 

%New values for the relative strain 
for n = 1:nFrames
   original = (middle_average_one(1,1,1)+ middle_average_two(1,1,1))/2;
   next = ((middle_average_one(1,1,n) + middle_average_two(1,1,n))/2); 
   horizontal_average(1,1,n) = (next - original) /(original); 
end 


P = zeros(nFrames,1);
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
P(3121:nFrames,:) = linspace(1.3,1.35,(nFrames-3121+1));
    

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
horizontal_average = reshape(horizontal_average, [1,nFrames]);


plot(P, horizontal_average)
% title('Pressure verse extension of the five chamber actuator');
% xlabel('Pressure');
% ylabel('Extension in Millimeters');
    %Need to get this smoothed out, will try again after looking into the
    %data 
end 











