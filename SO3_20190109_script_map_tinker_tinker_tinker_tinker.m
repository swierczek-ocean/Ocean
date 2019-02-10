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
XC = XC-360;

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
[m,n,l] = size(cflux_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (cflux_Series(ii,jj,kk)==0)
                cflux_Series(ii,jj,kk) = NaN;
            end
        end
    end
end


lbc = -1.9e-6;
ubc = 1.9e-6;
nlvls = 153;

z = linspace(lbc,ubc,nlvls);
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
% latlim = [YC(1) YC(end)];
% lonlim = [XC(1) XC(end)];
latlim = [ceil(YC(1)) floor(YC(end))];
lonlim = [ceil(XC(1)) floor(XC(end))];

[XC,YC] = meshgrid(XC,YC);

% [latgrat,longrat,elev] = satbath(10,latlim,lonlim);
% elev = elev+5;
% landindex = find(elev>-1);
% land = zeros(size(elev));
% land2 = zeros(size(elev));
% land(landindex) = elev(landindex);
% land = acc_scale(land,lbc,ubc)+0.03*(ubc-lbc);
% land2(landindex) = land(landindex);



set(gcf, 'Position', [1, 1, 1600, 900])
ax = axesm('mercator','MapLatLimit',latlim,'MapLonLimit',lonlim,'Frame','on');
hAx=gca;          % retrieve the handle of the axes itself
pAx=get(hAx,'Position');  % and the position vector
set(hAx, 'Position', [0.1,0.1,0.8,0.8])
axis tight
% setm(gcm, 'MapPosition', [1, 1, 1600, 900])
% ax = worldmap(latlim,lonlim);
landa = shaperead('landareas', 'UseGeoCoords', true);
geoshow(ax, landa, 'FaceColor', Color(:,10))
rivers = shaperead('worldrivers', 'UseGeoCoords', true);
geoshow(rivers, 'Color', 'blue','LineWidth',2.5)
% geoshow(gca,ax,refvec,'DisplayType','texturemap');
% demcmap(ax)
colormap(cm)
contourfm(YC',XC',cflux_Series(:,:,1)','LineStyle','none','LevelList',z);
hold on
contourcbar('eastoutside');
caxis([lbc ubc])
% axis(coords)
% title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
% xtickformat('degrees')
% ytickformat('degrees')
% acc_movie
% acc_plots
hold off

% figure()
% set(gcf, 'Position', [1, 1, 1600, 900])
% colormap(cm)
% contourf(XC,YC,cflux_Series(:,:,1),'LineStyle','none','LevelList',z);
% hold on
% colorbar('eastoutside');
% caxis([lbc ubc])
% axis(coords)
% title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
% xtickformat('degrees')
% ytickformat('degrees')
% acc_movie
% acc_plots
% hold off








% set(gca, 'nextplot','replacechildren', 'Visible','on');
% vidObj = VideoWriter('cflux4.avi');
% vidObj.Quality = 100;
% vidObj.FrameRate = 7;
% open(vidObj);
% writeVideo(vidObj, getframe(gcf));
% 
% for ii=2:180
%     numdate = numdate + 1;
%     contourf(XC,YC,cflux_Series(:,:,ii)+flipud(land2),'LineStyle','none','LevelList',z);
%     hold on
%     cbar = colorbar('eastoutside');
%     set(cbar,'YLim',[lbc ubc]);
%     caxis([lbc ubb])
%     axis(coords)
%     xtickformat('degrees')
%     ytickformat('degrees')
%     title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
%     acc_movie
%     drawnow()
%     writeVideo(vidObj, getframe(gcf));
%     hold off
% end
% 
% close(vidObj);
% close all
% 
% 
% clear cflux_Series

time = toc();
fprintf('Time to create CFLUX movies: %g\n',time)
%% end CFLUX