clear
close all
clc
tic()

depth = ncread('USGO_SO_2013_PFL_D.nc','prof_depth');
process_floats
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
Q = [2,4,7,12,20,31,35,38,41];
deep = [6,10,16,26,40,58,67,72,78];


%% Temp loop
uu = 1;


for qq=1:9
    Temp_Series = zeros(n,m,180);
    numdate = 735235;
    if (qq==3)||(qq==4)
        for ii=1:4
            char = ['diag_state.00000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = (temp(lox:hix,loy:hiy,Q(qq),uu)+temp(lox:hix,loy:hiy,Q(qq)+1,uu))./2;
        end
        
        for ii=5:41
            char = ['diag_state.0000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = (temp(lox:hix,loy:hiy,Q(qq),uu)+temp(lox:hix,loy:hiy,Q(qq)+1,uu))./2;
        end
        
        for ii=42:180
            char = ['diag_state.000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = (temp(lox:hix,loy:hiy,Q(qq),uu)+temp(lox:hix,loy:hiy,Q(qq)+1,uu))./2;
        end
    else
        for ii=1:4
            char = ['diag_state.00000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        end
        
        for ii=5:41
            char = ['diag_state.0000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        end
        
        for ii=42:180
            char = ['diag_state.000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        end
    end
    
    
    
    clear char
    clear temp
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series(:,:,31);
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj)=NaN;
            end
        end
    end
    
    if (qq<5)
        lb = -2;
        ub = 28;
        nlvls = 61;
    elseif (qq==5)
        lb = -3;
        ub = 19;
        nlvls = 45;
    elseif (qq==6)
        lb = -4;
        ub = 14;
        nlvls = 37;
    elseif (qq==7)
        lb = -2;
        ub = 8;
        nlvls = 31;
    elseif (qq>7)
        lb = -2;
        ub = 7;
        nlvls = 28;        
    end
        
    A = isnan(A);
    z = linspace(lb,ub,nlvls);
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    dtstr = str2num(datestr(numdate,'yyyymmdd'));
    Obs_Array = Temp_Obs_Array(Temp_Obs_Array(:,1)==dtstr,[2,3,deep(qq)]);
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cm)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    scatter(Obs_Array(:,1),Obs_Array(:,2),sz,Obs_Array(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    title(['MITgcm vs. Argo temperature at depth ',num2str(ceil(RC(Q(qq)))),' m (degrees C)'])
    xlabel('Latitude')
    ylabel('Longitude')
    acc_movie
    text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
    acc_plots
    hold off
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    vidObj = VideoWriter(['THETA_OBS_',num2str(ceil(RC(Q(qq)))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 4.5;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:180
        numdate = numdate + 1;
        dtstr = str2num(datestr(numdate,'yyyymmdd'));
        Obs_Array = Temp_Obs_Array(Temp_Obs_Array(:,1)==dtstr,[2,3,deep(qq)]);
        
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        colorbar('eastoutside');
        hold on
        scatter(Obs_Array(:,1),Obs_Array(:,2),sz,Obs_Array(:,3),'filled')
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['MITgcm vs. Argo temperature at depth ',num2str(ceil(RC(Q(qq)))),' m (degrees C)'])
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
end

clear Temp_Series

time = toc();
fprintf('Time to create TEMP movies: %g\n',time)
%% end TEMP


%% Salt loop
uu = 2;

for qq=9:-1:1
    Temp_Series = zeros(n,m,180);
    numdate = 735235;
    if (qq==3)||(qq==4)
        for ii=1:4
            char = ['diag_state.00000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = (temp(lox:hix,loy:hiy,Q(qq),uu)+temp(lox:hix,loy:hiy,Q(qq)+1,uu))./2;
        end
        
        for ii=5:41
            char = ['diag_state.0000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = (temp(lox:hix,loy:hiy,Q(qq),uu)+temp(lox:hix,loy:hiy,Q(qq)+1,uu))./2;
        end
        
        for ii=42:180
            char = ['diag_state.000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = (temp(lox:hix,loy:hiy,Q(qq),uu)+temp(lox:hix,loy:hiy,Q(qq)+1,uu))./2;
        end
    else
        for ii=1:4
            char = ['diag_state.00000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        end
        
        for ii=5:41
            char = ['diag_state.0000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        end
        
        for ii=42:180
            char = ['diag_state.000000',num2str(24*ii)];
            temp = rdmds(char);
            Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,Q(qq),uu);
        end
    end
    clear char
    clear temp
    
    Temp_Series = permute(Temp_Series,[2,1,3]);
    A = Temp_Series(:,:,31);
    
    [m,n,l] = size(Temp_Series);
    
    for ii=1:m
        for jj=1:n
            for kk=1:l
                if (Temp_Series(ii,jj,kk)==0)
                    Temp_Series(ii,jj,kk) = NaN;
                end
            end
            if (A(ii,jj)==0)
                A(ii,jj)=NaN;
            end
        end
    end
    
    if (qq<3)
        lb = 29;
        ub = 37;
        nlvls = 17;
    elseif (qq==3)
        lb = 30;
        ub = 37;
        nlvls = 15;
    elseif (qq>3)&&(qq<6)
        lb = 32;
        ub = 37;
        nlvls = 16;
    elseif (qq>5)
        lb = 34;
        ub = 35;
        nlvls = 31;
    end
        
    A = isnan(A);
    z = linspace(lb,ub,nlvls);
    coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
    dtstr = str2num(datestr(numdate,'yyyymmdd'));
    Obs_Array = Salt_Obs_Array(Salt_Obs_Array(:,1)==dtstr,[2,3,deep(qq)]);
    
    figure()
    set(gcf, 'Position', [1, 1, 1600, 900])
    colormap(cm)
    contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    scatter(Obs_Array(:,1),Obs_Array(:,2),sz,Obs_Array(:,3),'filled')
    caxis([lb ub])
    axis(coords)
    title(['MITgcm vs. Argo salinity ',num2str(ceil(RC(Q(qq)))),' m (psu)'])
    xlabel('Latitude')
    ylabel('Longitude')
    acc_movie
    text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
    acc_plots
    hold off
    set(gca, 'nextplot','replacechildren', 'Visible','on');
    vidObj = VideoWriter(['SALT_OBS_',num2str(ceil(RC(Q(qq)))),'m.avi']);
    vidObj.Quality = 100;
    vidObj.FrameRate = 4.5;
    open(vidObj);
    writeVideo(vidObj, getframe(gcf));
    
    for ii=2:180
        numdate = numdate + 1;
        dtstr = str2num(datestr(numdate,'yyyymmdd'));
        Obs_Array = Salt_Obs_Array(Salt_Obs_Array(:,1)==dtstr,[2,3,deep(qq)]);
        
        contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
        colorbar('eastoutside');
        hold on
        scatter(Obs_Array(:,1),Obs_Array(:,2),sz,Obs_Array(:,3),'filled')
        contour(XC,YC,0+A,'Color','k')
        caxis([lb ub])
        axis(coords)
        title(['MITgcm vs. Argo salinity at depth ',num2str(ceil(RC(Q(qq)))),' m (psu)'])
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
end

clear Temp_Series

time = toc();
fprintf('Time to create Salt movies: %g\n',time)
%% end Salt

%% sea surface height
Temp_Series = zeros(n,m,180);
numdate = 735235;
uu = 1;

for ii=1:4
    char = ['diag_surf.00000000',num2str(24*ii)];
    temp = rdmds(char);
    Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=5:41
    char = ['diag_surf.0000000',num2str(24*ii)];
    temp = rdmds(char);
    Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end

for ii=42:180
    char = ['diag_surf.000000',num2str(24*ii)];
    temp = rdmds(char);
    Temp_Series(:,:,ii) = temp(lox:hix,loy:hiy,uu);
end
clear char
clear temp

Temp_Series = permute(Temp_Series,[2,1,3]);
% A = Temp_Series(:,:,4);

[m,n,l] = size(Temp_Series);

for ii=1:m
    for jj=1:n
        for kk=1:l
            if (Temp_Series(ii,jj,kk)==0)
                Temp_Series(ii,jj,kk) = NaN;
            end
        end
%         if (A(ii,jj)==0)
%             A(ii,jj)=NaN;
%         end
    end
end

lb = -2;
ub = 2;
nlvls = 41;

% A = isnan(A);
z = linspace(lb,ub,nlvls);
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
dtstr = str2double(datestr(numdate,'yyyymmdd'));

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XC,YC,Temp_Series(:,:,1),'LineStyle','none','LevelList',z);
colorbar('eastoutside');
hold on

contour(XC,YC,0+A,'Color','k')

caxis([lb ub])
axis(coords)
title('sea surface height anomaly (m)')
xlabel('Latitude')
ylabel('Longitude')
acc_movie
text(293,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',16);
acc_plots
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('SSH.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 7;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:180
    numdate = numdate + 1;
    
    contourf(XC,YC,Temp_Series(:,:,ii),'LineStyle','none','LevelList',z);
    colorbar('eastoutside');
    hold on
    contour(XC,YC,0+A,'Color','k')
    caxis([lb ub])
    axis(coords)
    title('sea surface height anomaly (m)')
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

clear Temp_Series

time = toc();
fprintf('Time to create SSH movies: %g\n',time)
%% sea surface height


toc()