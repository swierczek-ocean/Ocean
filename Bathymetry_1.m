tic()
clc
clear
close all

lb = -6000;
ub = 0;
z = linspace(lb,ub,13);
v = [-6000:1000:0];
ACC_Colors
ACC_Colormaps

ncdisp('grid.nc');

XG = ncread('grid.nc','XG');
YG = ncread('grid.nc','YG');

X = XG(:,1);
Y = YG(1,:);

Bath = ncread('grid.nc','Depth');
Bath = -Bath';

cc = 9;
lw = 2.2;

loxx = find(X>289.99,1);
hixx = find(X>350,1);
loyy = find(Y>-59.3,1);
hiyy = find(Y>-32.1,1);

BathLine = Bath;

BathLine(loyy:hiyy,loxx) = Bath(loyy:hiyy,loxx)+10;
BathLine(loyy:hiyy,hixx) = Bath(loyy:hiyy,hixx)+10;
BathLine(loyy,loxx:hixx) = Bath(loyy,loxx:hixx)+10;
BathLine(hiyy,loxx:hixx) = Bath(hiyy,loxx:hixx)+10;


set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
contourf(X,Y,Bath,z)
hold on
line([290 290],[-59 -32],'Color',Color(:,cc),'LineWidth',lw)
line([350 350],[-59 -32],'Color',Color(:,cc),'LineWidth',lw)
line([290 350],[-32 -32],'Color',Color(:,cc),'LineWidth',lw)
line([290 350],[-59 -59],'Color',Color(:,cc),'LineWidth',lw)
c = colorbar('eastoutside');
xtickformat('degrees')
ytickformat('degrees')
caxis([lb ub])
zlabel('Depth')
title('Southern Hemisphere Ocean Bathymetry','FontWeight','Normal')
acc_plots
acc_movie
hold off
print('southern_hemisphere_ocean_bathymetry','-djpeg')


lox = find(X>290,1);
hix = find(X>350,1);
loy = find(Y>-59,1);
hiy = find(Y>-32,1);

figure()
set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
[C,h] = contourf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix),z);
clabel(C,h,v)
c = colorbar('eastoutside');
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Argentine Basin Bathymetry in [70,10] W x [59,32] S','FontWeight','Normal')
acc_plots
acc_movie
print('Argentine_Basin_bathymetry_window_small','-djpeg')


figure()
set(gcf, 'Position', [25, 25, 1600, 900])
colormap(flipud(bone))
s = surf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix));
s.EdgeColor = 'none';
axis([280 360 -70 -30 -15000 6000])
c = colorbar('eastoutside');
xtickformat('degrees')
ytickformat('degrees')
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Argentine Basin Bathymetry in [70,10] W x [59,32] S','FontWeight','Normal')
acc_plots
acc_movie
print('Argentine_Basin_bathymetry_window_small_surf','-djpeg')



lox = find(X>280,1);
hix = 1080;
loy = find(Y>-60,1);
hiy = 294;

figure()
set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
[C,h] = contourf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix),z);
hold on
clabel(C,h,v)
line([290 290],[-59 -32],'Color',Color(:,cc),'LineWidth',lw)
line([350 350],[-59 -32],'Color',Color(:,cc),'LineWidth',lw)
line([290 350],[-32 -32],'Color',Color(:,cc),'LineWidth',lw)
line([290 350],[-59 -59],'Color',Color(:,cc),'LineWidth',lw)
c = colorbar('eastoutside');
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Argentine Basin Bathymetry in [80,0] W x [60,30] S','FontWeight','Normal')
acc_plots
acc_movie
hold off
print('Argentine_Basin_bathymetry_window_large','-djpeg')

figure()
set(gcf, 'Position', [25, 25, 1600, 900])
s2 = surf(X(lox:hix),Y(loy:hiy),BathLine(loy:hiy,lox:hix));
hold on
s2.EdgeColor = 'none';
s2.FaceColor = Color(:,cc);
colormap(flipud(bone))
s = surf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix));
s.EdgeColor = 'none';
axis([280 360 -60 -30 -10000 3000])
c = colorbar('eastoutside');
xtickformat('degrees')
ytickformat('degrees')
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Argentine Basin Bathymetry in [80,0] W x [60,30] S','FontWeight','Normal')
acc_plots
acc_movie
hold off
print('Argentine_Basin_bathymetry_window_large_surf','-djpeg')


lox = find(X>280,1);
hix = 1080;
loy = find(Y>-70,1);
hiy = 294;


figure()
set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
[C,h] = contourf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix),z);
hold on
clabel(C,h,v)
line([290 290],[-59 -32],'Color',Color(:,cc),'LineWidth',lw)
line([350 350],[-59 -32],'Color',Color(:,cc),'LineWidth',lw)
line([290 350],[-32 -32],'Color',Color(:,cc),'LineWidth',lw)
line([290 350],[-59 -59],'Color',Color(:,cc),'LineWidth',lw)
c = colorbar('eastoutside');
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Argentine Basin Bathymetry in [80,0] W x [70,30] S','FontWeight','Normal')
acc_plots
acc_movie
hold off
print('Argentine_Basin_bathymetry_window_deep','-djpeg')

figure()
set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
[C,h] = contourf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix),z);
hold on
clabel(C,h,v)
c = colorbar('eastoutside');
caxis([lb ub])
xlabel('Latitude')
ylabel('Longitude')
zlabel('Depth')
title('Argentine Basin Bathymetry in [80,0] W x [70,30] S','FontWeight','Normal')
acc_plots
acc_movie
hold off
print('Argentine_Basin_bathymetry_window_deep2','-djpeg')




figure()
set(gcf, 'Position', [25, 25, 1600, 900])
s2 = surf(X(lox:hix),Y(loy:hiy),BathLine(loy:hiy,lox:hix));
hold on
s2.EdgeColor = 'none';
s2.FaceColor = Color(:,cc);
colormap(flipud(bone))
s = surf(X(lox:hix),Y(loy:hiy),Bath(loy:hiy,lox:hix));
s.EdgeColor = 'none';
% c = colorbar('eastoutside');
xtickformat('degrees')
ytickformat('degrees')
axis([280 360 -70 -30 -15000 6000])
caxis([lb ub])
% xlabel('Latitude')
% ylabel('Longitude')
% zlabel('Depth')
zticks([-6000 -4000 -2000 0])
title('Argentine Basin Bathymetry in [80,0] W x [70,30] S','FontWeight','Normal')
acc_movie
hold off
print('Argentine_Basin_bathymetry_window_deep_surf','-djpeg')

toc()