clear 
close all
clc

tic()

acc_settings
acc_colors


load mask12

load XY

pxe = 0.9;
lb = 0.0001;
ub = 1.49;
nlvls = 100;
z = linspace(lb,ub,nlvls);
% z = [z,1.55,1.65,1.75,1.85,2,3,4,5,100];
z = [z,linspace(ub,2.5,30),100];
cm = acc_colormap('fire');
cm = cm.^pxe;
cm = cm(2:end,:);
thingy = 0.9923:0.0001:1;
cm = [flipud(cm);[ones(78,2),thingy'];Color(:,46)'];

% temp_name = 'SPEED_bsose_10.bin';
% fid = fopen(temp_name,'r','b');
% Utemp = fread(fid,inf,'single');
% Utemp = reshape(Utemp,[2160,588,10]);
% fclose(fid);

stru = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Uvel.nc';
strv = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Vvel.nc';
strt = '/data/SOSE/SOSE/SO6/ITER122/bsose_i122_2013to2017_1day_Theta.nc';

hFacC = ncread(strt,'hFacC',[1,1,1],[2160,588,1]);
coords = [0 360 -78 -30];


UV = ncread(stru,'UVEL',[1,1,1,1],[2160,588,1,1]);
VV = ncread(strv,'VVEL',[1,1,1,1],[2160,588,1,1]);
U = sqrt(UV.^2+VV.^2);
U(hFacC==0)=200;
U(U>1.47)=1.48;
clear UV VV




figure()
set(gcf, 'Position', [1, 1, 1900, 700])
colormap(cm)
contourf(XC6(1:end),YC6(1:end),U','LineStyle','none','LevelList',z);
%     cbar = colorbar('eastoutside');
%     set(cbar,'XLim',[lb ub]);
hold on
contour(XC12,YC12,mask12(:,:,1),'Color','k')
axis(coords)
caxis([lb ub])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
%     xtickformat('degrees')
%     ytickformat('degrees')
acc_movie
acc_plots_no_labels
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('BSOSE_Surf_Currents.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 18;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

clear U




for ii=2:1826
    
    UV = ncread(stru,'UVEL',[1,1,1,ii],[2160,588,1,1]);
    VV = ncread(strv,'VVEL',[1,1,1,ii],[2160,588,1,1]);
    U = sqrt(UV.^2+VV.^2);
    U(hFacC==0)=200;
    U(U>1.47)=1.48;
    clear UV VV
    
    
    contourf(XC6(1:end),YC6(1:end),U','LineStyle','none','LevelList',z);
    %     cbar = colorbar('eastoutside');
    %     set(cbar,'XLim',[lb ub]);
    hold on
    contour(XC12,YC12,mask12(:,:,1),'Color','k')
    axis(coords)
    caxis([lb ub])
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    %     xtickformat('degrees')
    %     ytickformat('degrees')
    acc_movie
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    % acc_plots_no_labels
    hold off
    % print(['acc_',num2str(ii)],'-djpeg')
    clear U
    fprintf('on iteration %g \n',ii)
    ii
end

close(vidObj);




toc()






