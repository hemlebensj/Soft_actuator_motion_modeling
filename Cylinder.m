%Cylinder to create modeling of the actuator with the mocap dots on it
function [cylinder_points, mocap_points] = Cylinder(X_away_top, Y_away_top, Z_away_top, X_away_ridge, Y_away_ridge, Z_away_ridge, X_close_top, Y_close_top, Z_close_top,...
    X_close_ridge, Y_close_ridge, Z_close_ridge)
% Make the hgtransform and the surface; parent the surface to the hgtransform
%for i = 1:size(X_away_top,1)
for i = 1:3
    [x,y,z] = cylinder(0.0125);
    [p,q,r] = sphere;
    h = hgtransform;
    figure(1);
    ax1 = axes;
    surf(ax1,x,y,z, 'Parent', h, 'FaceColor', 'y');
    xlabel('Length in millimeters');
    ylabel('Height in millimeters');
    view(3)
    %ax2 = axes;
    %surf(p*0.5,q*0.5,r*0.5);
    plot3(ax1,-0.0400,0.0273,0.0780,'Marker','o','MarkerSize',4,'MarkerFaceColor','b','MarkerEdgeColor','b' );
    hold on
    
    %linkprop([ax1,ax2],{'CameraPosition','CameraUpVector'});
    view(3)
    linkprop(ax1,{'CameraPosition','CameraUpVector'});
    % ax2.Visible = 'off';
    ax1.Visible ='off';
    % ax2.XTick = [];
    % ax2.YTick = [];
    view(3)
    % Make it taller
    set(h, 'Matrix', makehgtform('scale', [1 1 10]))
    %set(h, 'Matrix', makehgtform('scale', [0 0.01 0.03]))
    % Tip it over and make it taller
    %set(h, 'Matrix', makehgtform('xrotate', pi/2, 'scale', [1 1 10]))
    set(h, 'Matrix', makehgtform('xrotate', pi/2, 'scale', [0.001 0.01 0.03]))
end
end


