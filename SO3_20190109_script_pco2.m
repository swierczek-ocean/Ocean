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



%% PCO2
uu = 2;

pco2_Series = zeros(n,m,180);
numdate = 735235;

for ii=1:4
    char = ['diag_surf.00000000',num2str(24*ii)];
    temp = rdmds(char);
    pco2_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=5:41
    char = ['diag_surf.0000000',num2str(24*ii)];
    temp = rdmds(char);
    pco2_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=42:180
    char = ['diag_surf.000000',num2str(24*ii)];
    temp = rdmds(char);
    pco2_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end
clear char
clear temp

pco2_Series = permute(pco2_Series,[2,1,3]);
A = pco2_Series(:,:,31);

[m,n,l] = size(pco2_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (pco2_Series(ii,jj,kk)==0)
                pco2_Series(ii,jj,kk) = NaN;
            end
        end
        if (A(ii,jj)==0)
            A(ii,jj)=NaN;
        end
    end
end

histogram(reshape(pco2_Series,[181*122*180,1]))

lb = 2.9e-4;
ub = 4.6e-4;
nlvls = 69;

A = isnan(A);
z = linspace(lb,ub,nlvls);
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XC,YC,pco2_Series(:,:,1),'LineStyle','none','LevelList',z);
colorbar('eastoutside');
hold on
contour(XC,YC,0+A,'Color','k')
caxis([lb ub])
axis(coords)
title('pCO2 in atm')
xlabel('Latitude')
ylabel('Longitude')
acc_movie
text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
acc_plots
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('pco2grays.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 8;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:180
    numdate = numdate + 1;
    contourf(XC,YC,pco2_Series(:,:,ii),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title('pCO2 in atm')
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


clear pco2_Series

time = toc();
fprintf('Time to create PCO2 movies: %g\n',time)
%% end PCO2


toc()