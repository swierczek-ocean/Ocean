clear 
close all
clc

tic()

acc_settings
acc_colors


load mask12

load XY

pxe = 1;
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

for ii=2:2
    temp_name = 'SPEED_bsose_10.bin';
    fid = fopen(temp_name,'r','b');
    Utemp = fread(fid,inf,'single');
    Utemp = reshape(Utemp,[2160,588,10]);
    fclose(fid);
    
    U = Utemp(:,:,ii)';
    U(U>1.47)=1.48;
    U(isnan(U))=200;
    coords = [0 360 -78 -30];
    
    figure()
    set(gcf, 'Position', [1, 1, 1900, 600])
    colormap(cm)
    contourf(XC6(1:end),YC6(1:end),U,'LineStyle','none','LevelList',z);
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
    acc_plots
    hold off
    % print(['acc_',num2str(ii)],'-djpeg')
end






toc()






