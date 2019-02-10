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

lbc = -1.9e-6;
ubc = 1.9e-6;
ubb = 5.7e-6;
nlvls = 305;

z = linspace(lbc,ubb,nlvls);
coords = [ceil(XC(1))-360 floor(XC(end))-360 ceil(YC(1)) floor(YC(end))];
latlim = [YC(1) YC(end)];
lonlim = [XC(1) XC(end)];

[XC,YC] = meshgrid(XC,YC);

[latgrat,longrat,elev] = satbath(10,latlim,lonlim-360);
elev = elev+2;
landindex = find(elev>-1);
land = zeros(size(elev));
land2 = zeros(size(elev));
land(landindex) = elev(landindex);
land = acc_scale(land,lbc,ubc)+0.03*(ubc-lbc);
land2(landindex) = land(landindex);

cm1 = acc_colormap('terr');
cm2 = [cm;cm1];

F = cflux_Series(:,:,1)+flipud(land2);
A = find(F>ubc);
shore = zeros(size(F));
shore(A)=1;

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm2)
M = contourf(XC-360,YC,F,'LineStyle','none','LevelList',z);
hold on
cbar = colorbar('eastoutside');
set(cbar,'YLim',[lbc ubc]);
caxis([lbc ubb])
axis(coords)
contour(XC-360,YC,flipud(elev),'Color','k','LineWidth',6,'LevelList',[-1,-1])
title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
xtickformat('degrees')
ytickformat('degrees')

acc_plots
acc_movie
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('cflux5.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 7;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:180
    numdate = numdate + 1;
    contourf(XC-360,YC,cflux_Series(:,:,ii)+flipud(land2),'LineStyle','none','LevelList',z);
    hold on
    contour(XC-360,YC,flipud(elev),'Color','k','LineWidth',6,'LevelList',[-1,-1])
    cbar = colorbar('eastoutside');
    set(cbar,'YLim',[lbc ubc]);
    caxis([lbc ubb])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
    acc_movie
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    hold off
end

close(vidObj);
close all


clear cflux_Series

time = toc();
fprintf('Time to create CFLUX movies: %g\n',time)
%% end CFLUX