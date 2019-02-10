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

histogram(reshape(cflux_Series,[n*m*180,1]))

lb = -1.4e-6;
ub = 1.4e-6;
nlvls = 85;

A = isnan(A);
z = linspace(lb,ub,nlvls);
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XC,YC,cflux_Series(:,:,1),'LineStyle','none','LevelList',z);
colorbar('eastoutside');
hold on
contour(XC,YC,0+A,'Color','k')
caxis([lb ub])
axis(coords)
title('Carbon Flux in mole/m2/sec')
xlabel('Latitude')
ylabel('Longitude')
acc_movie
text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
acc_plots
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('cflux.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 7;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:180
    numdate = numdate + 1;
    contourf(XC,YC,cflux_Series(:,:,ii),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title('Carbon Flux in mole/m2/sec')
    xlabel('Latitude')
    ylabel('Longitude')
    acc_movie
    text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
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

%% OFLUX loop
uu = 4;

oflux_Series = zeros(n,m,180);
numdate = 735235;

for ii=1:4
    char = ['diag_airsea.00000000',num2str(24*ii)];
    temp = rdmds(char);
    oflux_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=5:41
    char = ['diag_airsea.0000000',num2str(24*ii)];
    temp = rdmds(char);
    oflux_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=42:180
    char = ['diag_airsea.000000',num2str(24*ii)];
    temp = rdmds(char);
    oflux_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

clear char
clear temp

oflux_Series = permute(oflux_Series,[2,1,3]);
A = oflux_Series(:,:,31);

[m,n,l] = size(oflux_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (oflux_Series(ii,jj,kk)==0)
                oflux_Series(ii,jj,kk) = NaN;
            end
        end
        if (A(ii,jj)==0)
            A(ii,jj)=NaN;
        end
    end
end

figure()
histogram(reshape(oflux_Series,[n*m*180,1]))

lb = -6e-6;
ub = 6e-6;
nlvls = 49;

A = isnan(A);
z = linspace(lb,ub,nlvls);
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XC,YC,oflux_Series(:,:,1),'LineStyle','none','LevelList',z);
colorbar('eastoutside');
hold on
contour(XC,YC,0+A,'Color','k')
caxis([lb ub])
axis(coords)
title('Oxygen Flux in mole/m2/sec')
xlabel('Latitude')
ylabel('Longitude')
acc_movie
text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
acc_plots
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('oflux.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 7;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:180
    numdate = numdate + 1;    
    contourf(XC,YC,oflux_Series(:,:,ii),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title('Oxygen Flux in mole/m2/sec')
    xlabel('Latitude')
    ylabel('Longitude')
    acc_movie
    text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    hold off
end

close(vidObj);
close all


clear oflux_Series

time = toc();
fprintf('Time to create OFLUX movies: %g\n',time)
%% end CFLUX

toc()