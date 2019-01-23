clear
close all
clc

%% SST
tic()
ACC_Colors
ACC_Colormaps
vv = 1;
cl = 1;
XC = rdmds('XC');
YC = rdmds('YC');
Temp_Series = zeros(192,132,60);

for ii=1:4
   char = ['diag_state.00000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

for ii=5:41
   char = ['diag_state.0000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

for ii=42:60
   char = ['diag_state.000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

Temp_Series = permute(Temp_Series,[2,1,3]);
A = Temp_Series(:,:,1);

[m,n,l] = size(Temp_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (Temp_Series(ii,jj,kk)==0)
                Temp_Series(ii,jj,kk) = NaN;
                A(ii,jj) = NaN;
            end
        end
    end
end

lb = -2;
ub = 32;
A = isnan(A);
z = linspace(lb,ub,10);

XC = XC(:,end);
YC = YC(end,:);

set(gcf, 'Position', [20, 20, 1200, 900])
colormap(colormap3)
contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'C';
caxis([lb ub])
hold on
contour(XC,YC,0+A,'Color','k','LineWidth',cl)
title('sea surface temperature')
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SST.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 6;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:60
    contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'C';
    caxis([lb ub])
    hold on
    contour(XC,YC,0+A,'Color','k','LineWidth',cl)
    title('sea surface temperature')
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);


time = toc();
fprintf('Time to create SST movie: %g\n',time)
clear
%% end SST

%% SST
tic()
ACC_Colors
ACC_Colormaps
vv = 2;
cl = 1;
XC = rdmds('XC');
YC = rdmds('YC');
Temp_Series = zeros(192,132,12);

for ii=1:4
   char = ['diag_state.00000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

for ii=5:41
   char = ['diag_state.0000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

for ii=42:60
   char = ['diag_state.000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

Temp_Series = permute(Temp_Series,[2,1,3]);
A = Temp_Series(:,:,1);

[m,n,l] = size(Temp_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (Temp_Series(ii,jj,kk)==0)
                Temp_Series(ii,jj,kk) = NaN;
                A(ii,jj) = NaN;
            end
        end
    end
end

lb = 29;
ub = 41;
A = isnan(A);
z = linspace(lb,ub,12);

XC = XC(:,end);
YC = YC(end,:);

set(gcf, 'Position', [20, 20, 1200, 900])
colormap(colormap3)
contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'psu';
caxis([lb ub])
hold on
contour(XC,YC,0+A,'Color','k','LineWidth',cl)
title('sea surface salinity')
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('SSS.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 6;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:60
    contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'psu';
    caxis([lb ub])
    hold on
    contour(XC,YC,0+A,'Color','k','LineWidth',cl)
    title('sea surface salinity')
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);


time = toc();
fprintf('Time to create SSS movie: %g\n',time)
clear
%% end SSS

%% WVEL
tic()
ACC_Colors
ACC_Colormaps
vv = 5;
cl = 1;
XC = rdmds('XC');
YC = rdmds('YC');
Temp_Series = zeros(192,132,12);

for ii=1:4
   char = ['diag_state.00000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,5,vv);
end

for ii=5:41
   char = ['diag_state.0000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,5,vv);
end

for ii=42:60
   char = ['diag_state.000000',num2str(24*ii)];
   temp = rdmds(char);
   Temp_Series(:,:,ii) = temp(:,:,5,vv);
end

Temp_Series = permute(Temp_Series,[2,1,3]);
A = Temp_Series(:,:,1);

[m,n,l] = size(Temp_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (Temp_Series(ii,jj,kk)==0)
                Temp_Series(ii,jj,kk) = NaN;
                A(ii,jj) = NaN;
            end
        end
    end
end

lb = -2;
ub = 2;
A = isnan(A);
z = linspace(lb,ub,11);

XC = XC(:,end);
YC = YC(end,:);

set(gcf, 'Position', [20, 20, 1200, 900])
colormap(colormap1)
contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
c = colorbar('southoutside');
c.Label.String = 'm/s';
caxis([lb ub])
hold on
contour(XC,YC,0+A,'Color','k','LineWidth',cl)
title('vertical velocity')
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');

vidObj = VideoWriter('WVEL.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 6;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:60
    contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
    c = colorbar('southoutside');
    c.Label.String = 'm/s';
    caxis([lb ub])
    hold on
    contour(XC,YC,0+A,'Color','k','LineWidth',cl)
    title('vertical velocity')
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);


time = toc();
fprintf('Time to create WVEL movie: %g\n',time)
clear
%% end WVEL

%% WVEL STD
delZ = [4.2, 5, 5.9, 6.9, 8.5, 9.5, 10, 10, 10, 10, 10, 10,...
    10, 10, 10, 10, 13, 17, 20, 20, 20, 20,...
    20, 20, 22, 30, 38, 45, 50, 50, 53, 72,...
    100, 100, 100, 100, 100, 150, 200, 200, 200, 220,...
    300, 380, 400, 400, 400, 400, 400, 400, 400, 400];

tic()
ACC_Colors
ACC_Colormaps
vv = 5;
cl = 1;
XC = rdmds('XC');
YC = rdmds('YC');

%% first slide

Temp_Series = zeros(192,132,12);

for ii=1:4
    char = ['diag_state.00000000',num2str(24*ii)];
    temp = rdmds(char);
    Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

for ii=5:41
    char = ['diag_state.0000000',num2str(24*ii)];
    temp = rdmds(char);
    Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

for ii=42:60
    char = ['diag_state.000000',num2str(24*ii)];
    temp = rdmds(char);
    Temp_Series(:,:,ii) = temp(:,:,1,vv);
end

Temp_Series = permute(Temp_Series,[2,1,3]);
A = Temp_Series(:,:,1);
WVELSTD = mean(Temp_Series,3);
[m,n] = size(WVELSTD);

for ii=1:m
    for ll=1:n
        if (WVELSTD(ii,ll)==0)
            WVELSTD(ii,ll) = NaN;
            A(ii,ll) = NaN;
        end
        
    end
end

lb = -0.05;
ub = 0.05;
A = isnan(A);
z = linspace(lb,ub,11);

XC = XC(:,end);
YC = YC(end,:);

figure()
set(gcf, 'Position', [20, 20, 1200, 900])
colormap(colormap1)
contourf(XC,YC,WVELSTD,'LevelList',z,'ShowText','on'); %,'LineStyle','none'
c = colorbar('southoutside');
c.Label.String = 'm/s';
caxis([lb ub])
hold on
% contour(XC,YC,0+A,'Color','k','LineWidth',cl)
title('mean vertical velocity at surface')
xlabel('Latitude')
ylabel('Longitude')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('WVEL_MEAN.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 3;
open(vidObj);
writeVideo(vidObj, getframe(gcf));
%% end first slide

for jj=2:52
    
    Temp_Series = zeros(192,132,12);
    
    for ii=1:4
        char = ['diag_state.00000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series(:,:,ii) = temp(:,:,jj,vv);
    end
    
    for ii=5:41
        char = ['diag_state.0000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series(:,:,ii) = temp(:,:,jj,vv);
    end
    
    for ii=42:60
        char = ['diag_state.000000',num2str(24*ii)];
        temp = rdmds(char);
        Temp_Series(:,:,ii) = temp(:,:,jj,vv);
    end
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series(:,:,1);
    WVELSTD = mean(Temp_Series,3);
    [m,n] = size(WVELSTD);
    
    for ii=1:m
        for ll=1:n
            if (WVELSTD(ii,ll)==0)
                WVELSTD(ii,ll) = NaN;
                A(ii,ll) = NaN;
            end
            
        end
    end
    
    lb = -0.05;
    ub = 0.05;
    A = isnan(A);
    z = linspace(lb,ub,11);
    
    XC = XC(:,end);
    YC = YC(end,:);
    
    contourf(XC,YC,WVELSTD,'LevelList',z,'ShowText','on'); %,'LineStyle','none'
    c = colorbar('southoutside');
    c.Label.String = 'm/s';
    caxis([lb ub])
    hold on
    % contour(XC,YC,0+A,'Color','k','LineWidth',0.2)
    title(['mean vertical velocity at depth ',num2str(sum(delZ(1:jj-1))),' m'])
    xlabel('Latitude')
    ylabel('Longitude')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    
end
close(vidObj);

toc()

%%