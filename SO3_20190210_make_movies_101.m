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

z = [z,linspace(ub,2.5,30),198];
cm = acc_colormap('fire');
% cm = cm.^pxe;
cm = cm(2:end,:);
thingy = 0.9923:0.0001:1;
cm = [flipud(cm);[ones(78,2),thingy'];Color(:,46)'];

temp_name = 'Currents1.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

coords = [0 360 -78 -30];







figure()
set(gcf, 'Position', [1, 1, 1900, 700])
colormap(cm)
contourf(XC6(1:end),YC6(1:end),U(:,:,1)','LineStyle','none','LevelList',z);
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
vidObj.FrameRate = 40;
open(vidObj);
writeVideo(vidObj, getframe(gcf));





for ii=2:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents2.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents3.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents4.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents5.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents6.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents7.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents8.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear U

temp_name = 'Currents9.bin';
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/2160/588;
U = reshape(U,[2160,588,NZ]);
fclose(fid);

for ii=1:NZ    
    
    contourf(XC6(1:end),YC6(1:end),U(:,:,ii)','LineStyle','none','LevelList',z);
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
    
    fprintf('on iteration %g \n',ii)
end

clear

close(vidObj);




toc()






