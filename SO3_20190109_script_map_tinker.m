clear
close all
clc
tic()


acc_settings
XC = rdmds('XC');
YC = rdmds('YC');
RC = rdmds('RC');
RC = squeeze(RC);
RC = -RC;
XC = XC(:,end);
YC = YC(end,:);
lox = find(XC>289.99,1);
hix = find(XC>350,1);
loy = find(YC>-59.3,1);
hiy = find(YC>-32,1);
XC = XC(lox:hix);
YC = YC(loy:hiy);
n = length(XC);
m = length(YC);


%% CFLUX loop
uu = 3;

cflux_Series = zeros(n,m,180);
numdate = 735235;

for ii=1:4
    char = ['diag_airsea.00000000',num2str(24*ii)];
    temp = rdmds(char);
    cflux_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=5:41
    char = ['diag_airsea.0000000',num2str(24*ii)];
    temp = rdmds(char);
    cflux_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=42:180
    char = ['diag_airsea.000000',num2str(24*ii)];
    temp = rdmds(char);
    cflux_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end
clear char
clear temp

cflux_Series = permute(cflux_Series,[2,1,3]);
A = cflux_Series(:,:,31);

[m,n,l] = size(cflux_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (cflux_Series(ii,jj,kk)==0)
                cflux_Series(ii,jj,kk) = NaN;
            end
        end
        if (A(ii,jj)==0)
            A(ii,jj)=NaN;
        end
    end
end

% histogram(reshape(cflux_Series,[n*m*180,1]))

lb = -1.9e-6;
ub = 1.9e-6;
nlvls = 115;

A = isnan(A);
z = linspace(lb,ub,nlvls);
coords = [ceil(XC(1))-360 floor(XC(end))-360 ceil(YC(1)) floor(YC(end))];
latlim = [ceil(YC(1)) floor(YC(end))];
lonlim = [ceil(XC(1)) floor(XC(end))];

[XC,YC] = meshgrid(XC,YC);

[latgrat,longrat,elev] = satbath(5,latlim,lonlim-360);%,[122 181]);
elev = elev+10;
landindex = find(elev>-1);
land = zeros(size(elev));
land(landindex) = elev(landindex);
[n,m] = size(land);
for ii=1:n
    for jj=1:m
        if land(ii,jj)==0
            land(ii,jj) = NaN;
        end
    end
end


set(gcf, 'Position', [1, 1, 1600, 900])
ax = axesm('pcarree','MapLatLimit',latlim,'MapLonLimit',lonlim);
% setm(gcm, 'MapPosition', [1, 1, 1600, 900])
ax = worldmap(latlim,lonlim);
landa = shaperead('landareas', 'UseGeoCoords', true);
geoshow(ax, landa, 'FaceColor', Color(:,10))
rivers = shaperead('worldrivers', 'UseGeoCoords', true);
geoshow(rivers, 'Color', 'blue','LineWidth',2.5)

figure()
zland = linspace(0,2500,125);
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(acc_colormap('terr'))
contourf(longrat-360,latgrat,land,'LineStyle','none','LevelList',zland);

lbl = 0;
ubl = 1800;

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
ax1 = axes;
colormap(acc_colormap('terr'))
contourf(longrat-360,latgrat,land,'LineStyle','none','LevelList',zland);
colorbar(ax1,'eastoutside');
caxis([lbl ubl])
hold on
% fill(longrat-360,latgrat,0+isnan(land),'FaceAlpha',0);
acc_plots
% contour(XC,YC,0+A,'Color','k','linewidth',0.1)
ax2 = axes;
colormap(cm)
contourf(XC-360,YC,cflux_Series(:,:,1),'LineStyle','none','LevelList',z);
% fill(XC-360,YC,0+A,'FaceAlpha',0);
linkaxes([ax1,ax2])
%%Hide the top axes
ax1.Visible = 'off';
ax1.XTick = [];
ax1.YTick = [];
%%Give each one its own colormap
colormap(ax1,acc_colormap('elev'))
colormap(ax2,cm)
colorbar(ax2,'eastoutside');
caxis([lb ub])
axis(coords)
title(['Carbon Flux in mole/m2/sec on ',datestr(numdate,'yyyy mmm dd')])
xtickformat('degrees')
ytickformat('degrees')
acc_movie
acc_plots
hold off













% set(gca, 'nextplot','replacechildren', 'Visible','on');
% vidObj = VideoWriter('cflux.avi');
% vidObj.Quality = 100;
% vidObj.FrameRate = 7;
% open(vidObj);
% writeVideo(vidObj, getframe(gcf));

% for ii=2:180
%     numdate = numdate + 1;
%     contourf(XC,YC,cflux_Series(:,:,ii),'LineStyle','none','LevelList',z);
%     colorbar('eastoutside');
%     hold on
%     contour(XC,YC,0+A,'Color','k')
%     caxis([lb ub])
%     axis(coords)
%     title('Carbon Flux in mole/m2/sec')
%     xlabel('Latitude')
%     ylabel('Longitude')
%     acc_movie
%     text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
%     drawnow()
%     writeVideo(vidObj, getframe(gcf));
%     hold off
% end
% 
% close(vidObj);
% close all


clear cflux_Series

time = toc();
fprintf('Time to create CFLUX movies: %g\n',time)
%% end CFLUX