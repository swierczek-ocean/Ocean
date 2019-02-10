




acc_colors
strng = 'topo';
cm = acc_colormap(strng);
set(0,'DefaultFigureVisible','on')
sz = 190;
clear strng
close all


lb = 0;
ub = 20;
A = poissrnd(10,50,80);
z = linspace(lb,ub,50);





set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(A,'LineStyle','none','LevelList',z);
colorbar('eastoutside');
hold on
caxis([lb ub])
acc_movie
acc_plots





















