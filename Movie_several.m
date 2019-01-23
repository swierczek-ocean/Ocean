tic()
clear
load('SSU.mat')
load('SSV.mat')
load('SSU_avg.mat')
SSU = permute(SSU,[2,1,3]);
SSV = permute(SSV,[2,1,3]);

[m,n,l] = size(SSU);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (SSU(ii,jj,kk)==0)
                SSU(ii,jj,kk) = NaN;
                SSV(ii,jj,kk) = NaN;
            end
        end
    end
end

mag = sqrt(SSU.^2 + SSV.^2);

lb = 0;
ub = 2.5;
colormap(bone)
A = isnan(SSU_avg);
z = linspace(lb,ub,10);

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
contourf(x,y,mag(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'm/s';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['sea surface speed for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SSV.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 18;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,mag(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'm/s';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['sea surface speed for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SSV movie: %g\n',time)



tic()
clear
load('TAUX.mat')
load('TAUY.mat')
load('SSU_avg.mat')
TAUX = permute(TAUX,[2,1,3]);
TAUY = permute(TAUY,[2,1,3]);

[m,n,l] = size(TAUX);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (TAUX(ii,jj,kk)==0)
                TAUX(ii,jj,kk) = NaN;
                TAUY(ii,jj,kk) = NaN;
            end
        end
    end
end

mag = sqrt(TAUX.^2 + TAUY.^2);

colormap(bone)
lb = 0;
ub = 0.5;
A = isnan(SSU_avg);
z = linspace(lb,ub,10);

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(bone)
contourf(x,y,mag(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'N/m/m';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['wind stress for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('TAU.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 18;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,mag(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'N/m/m';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['wind stress for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create TAU movie: %g\n',time)


tic()
clear
load('SSH.mat')
load('SST_avg.mat')
SSH = permute(SSH,[2,1,3]);

[m,n,l] = size(SSH);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                SSH(ii,jj,kk) = NaN;
            end
        end
    end
end

A = isnan(SST_avg);
lb = -2;
ub = 2;
z = linspace(lb,ub,10);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap1)
contourf(x,y,SSH(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'm';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['sea surface height anomaly for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SSH.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,SSH(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'm';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['sea surface height anomaly for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SSH movie: %g\n',time)


tic()
clear
load('SST.mat')
load('SST_avg.mat')
SST = permute(SST,[2,1,3]);

[m,n,l] = size(SST);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                SST(ii,jj,kk) = NaN;
            end
        end
    end
end

A = isnan(SST_avg);
lb = -2;
ub = 31;
z = linspace(lb,ub,15);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap1)
contourf(x,y,SST(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'degrees C';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['sea surface temperature for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SST.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,SST(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'degrees C';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['sea surface temperature for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SST movie: %g\n',time)


tic()
clear
load('CFLUX.mat')
load('SST_avg.mat')
CFLUX = permute(CFLUX,[2,1,3]);
CFLUX = 86400.*CFLUX;
[m,n,l] = size(CFLUX);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                CFLUX(ii,jj,kk) = NaN;
            end
        end
    end
end

A = isnan(SST_avg);
lb = -0.06;
ub = 0.06;
z = linspace(lb,ub,15);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap1)
contourf(x,y,CFLUX(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'mol/m/m/day';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['vertical CO2 flux for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('CFLUX.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,CFLUX(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'mol/m/m/day';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['vertical CO2 flux for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create CFLUX movie: %g\n',time)


tic()
clear
load('OFLUX.mat')
load('SST_avg.mat')
OFLUX = permute(OFLUX,[2,1,3]);
OFLUX = 86400.*OFLUX;
[m,n,l] = size(OFLUX);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                OFLUX(ii,jj,kk) = NaN;
            end
        end
    end
end

A = isnan(SST_avg);
lb = -0.2;
ub = 0.2;
z = linspace(lb,ub,15);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap1)
contourf(x,y,OFLUX(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'mol/m/m/day';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['vertical oxygen flux for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('OFLUX.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,OFLUX(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'mol/m/m/day';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['vertical oxygen flux for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create OFLUX movie: %g\n',time)


tic()
clear
load('TFLUX.mat')
load('SST_avg.mat')
TFLUX = permute(TFLUX,[2,1,3]);
[m,n,l] = size(TFLUX);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                TFLUX(ii,jj,kk) = NaN;
            end
        end
    end
end

lb = -525;
ub = 525;
A = isnan(SST_avg);
z = linspace(lb,ub,15);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap1)
contourf(x,y,TFLUX(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'W/m/m';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['vertical temperature flux for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('TFLUX.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,TFLUX(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'W/m/m';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['vertical temperature flux for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create TFLUX movie: %g\n',time)


tic()
clear
load('SFLUX.mat')
load('SST_avg.mat')
SFLUX = permute(SFLUX,[2,1,3]);
[m,n,l] = size(SFLUX);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                SFLUX(ii,jj,kk) = NaN;
            end
        end
    end
end

lb = -0.012;
ub = 0.012;
A = isnan(SST_avg);
z = linspace(lb,ub,15);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap1)
contourf(x,y,SFLUX(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'g/m/m/s';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['vertical salt flux for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SFLUX.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,SFLUX(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'g/m/m/s';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['vertical salt flux for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SFLUX movie: %g\n',time)


tic()
clear
load('SSS.mat')
load('SST_avg.mat')
SSS = permute(SSS,[2,1,3]);
[m,n,l] = size(SSS);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                SSS(ii,jj,kk) = NaN;
            end
        end
    end
end

lb = 30;
ub = 37;
A = isnan(SST_avg);
z = linspace(lb,ub,15);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(colormap3)
contourf(x,y,SSS(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'psu';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['sea surface salinity for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SSS.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,SSS(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'psu';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['sea surface salinity for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SSS movie: %g\n',time)


tic()
clear
load('SIarea.mat')
load('SST_avg.mat')
SIarea = permute(SIarea,[2,1,3]);
[m,n,l] = size(SIarea);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                SIarea(ii,jj,kk) = NaN;
            end
        end
    end
end

lb = 0;
ub = 0.8;
A = isnan(SST_avg);
z = linspace(lb,ub,10);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(flipud(colormap5))
contourf(x,y,SIarea(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(x,y,0+A,'Color','k')
title(['sea ice area for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SIarea.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,SIarea(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(x,y,0+A,'Color','k')
    title(['sea ice area for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SIarea movie: %g\n',time)


tic()
clear
load('SIheff.mat')
load('SST_avg.mat')
SIheff = permute(SIheff,[2,1,3]);
[m,n,l] = size(SIheff);

for ii=1:m
    for jj=1:n
        if isnan(SST_avg(ii,jj))==1
            for kk=1:l
                SIheff(ii,jj,kk) = NaN;
            end
        end
    end
end

lb = 0;
ub = 1;
A = isnan(SST_avg);
z = linspace(lb,ub,10);
ACC_Colormaps

set(gcf, 'Position', [25, 25, 1600, 900])
colormap(flipud(colormap5))
contourf(x,y,SIheff(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'm';
caxis([lb ub])
hold on
contour(x,y,0+A,'Color','k')
title(['sea ice effective thickness for ',datestr(t(1),'yyyy-mm')])
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SIheff.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 16;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:366
    contourf(x,y,SIheff(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'm';
    caxis([lb ub])
    hold on
    contour(x,y,0+A,'Color','k')
    title(['sea ice effective thickness for ',datestr(t(ii),'yyyy-mm')])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);

clear
time = toc();
fprintf('Time to create SIarea movie: %g\n',time)

