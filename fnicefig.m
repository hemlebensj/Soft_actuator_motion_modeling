function fnicefigW15
% Dr. K. Levien, CHE 361, Oregon State University
% A function to make a Simulink or MATLAB Figure "nice" for copying.
% Set size of axis tic labels and axes thickness and plot lines.
 
set(0,'ShowHiddenHandles','on')

set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',25, ...
    'GridLineStyle',''), grid
 
% Set all line thicknesses to 2.
h1 = findobj(gca,'Type','line');
set(h1,'LineWidth',2)
 
% Set xlabel, ylabel and title font name and size.
h2 = get(gca,'Xlabel');
set(h2,'FontName','Times New Roman','FontSize',25)
%
h3 = get(gca,'Ylabel');
set(h3,'FontName','Times New Roman','FontSize',25)
%
h4 = get(gca,'Title');
set(h4,'FontName','Times New Roman','FontSize',25)

set(0,'ShowHiddenHandles','off')