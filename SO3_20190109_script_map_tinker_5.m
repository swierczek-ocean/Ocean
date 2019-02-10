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

[m,n,l] = size(cflux_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (cflux_Series(ii,jj,kk)==0)
                cflux_Series(ii,jj,kk) = 101;
            end
        end
    end
end

% histogram(reshape(cflux_Series,[n*m*180,1]))

lb = -1.8e-6;
ub = 1.8e-6;
nlvls = 145;

z = linspace(lb,ub,nlvls);
z = [-2.4e-6,z,2e-6,100];
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];

cm = [cm;Color(:,46)'];

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XC,YC,cflux_Series(:,:,1),'LineStyle','none','LevelList',z);
colorbar('eastoutside');
hold on
caxis([lb ub])
axis(coords)
title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
xtickformat('degrees')
ytickformat('degrees')
acc_movie
acc_plots
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('cflux_grey.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 7;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:180
    numdate = numdate + 1;
    contourf(XC,YC,cflux_Series(:,:,ii),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    caxis([lb ub])
    axis(coords)
    title(['Carbon Flux in mole/m^2/sec on ',datestr(numdate,'yyyy mmm dd')])
    xtickformat('degrees')
    ytickformat('degrees')
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