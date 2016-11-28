% [X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
%     X_close_ridge, Y_close_ridge, Z_close_ridge] = PlotforSteph();
% 
% 
% [cylinder_points, mocap_points] = Cylinder(X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
%     X_close_ridge, Y_close_ridge, Z_close_ridge);


% P = zeros(4525,1);
%     %P = reshape(P, [4525,1]); 
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
% P(4121:4525,:) = 1;

[im, X,Y] = Curvature_Steph;
values = [X,Y];
csvwrite('Middlelinepoints_Two.csv',values);
type Middlelinepoints_Two.csv


% ts = [0:1:4524];
% [P,X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
%     X_close_ridge, Y_close_ridge, Z_close_ridge] = PlotforSteph();
% % x = linspace(0.02571,0.02711, 472);
% % x = reshape(x,[472,1]); 
% interp_area = X_away_top((2000:2300),:);
% range = linspace(-0.043,-0.045,301);
% X_away_top((2000:2300),:) = interp1(interp_area, range,'pchip'); 
% figure(2)
% plot(ts, X_away_top); 


% ts = [0:1:4524];
% [P,X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
%     X_close_ridge, Y_close_ridge, Z_close_ridge] = PlotforSteph();
% % x = linspace(0.02571,0.02711, 472);
% % x = reshape(x,[472,1]); 
% interp_area = X_close_ridge((1912:3705),:);
% range = linspace(-0.03507,-0.03541,1794);
% X_close_ridge((1912:3705),:) = interp1(interp_area, range,'pchip'); 
% figure(2)
% plot(ts, X_close_ridge); 
% v = sin(x);
% figure 
% vq = interp1(x,v,x);
% plot(x,v,'o',xq,vq,':.');








