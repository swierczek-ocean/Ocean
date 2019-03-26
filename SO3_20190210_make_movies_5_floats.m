
clear
close all
clc

tic()
acc_settings
load Obs
load mask
load BGCObs
mask = permute(mask,[2,1,3]);

XC = rdmds('XC');
YC = rdmds('YC');
HC = rdmds('hFacC');
XC = XC(:,end);
YC = YC(end,:);

XC = XC(6:187);
YC = YC(6:127);
HC = HC(6:187,6:127,:);

vl = [4,16,27,30,36,41];
depth_names = [20,135,350,500,1000,1800];
coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
argo_depth = [10,33,52,58,69,78];
nn = 182;
mm = 122;
nlvls = 200;
str = '_bsose_ts_vl_';

strng = 'dawn';
cm = acc_colormap(strng);
cm = [Color(:,46)';flipud(cm);Color(:,46)'];
bgccolor = Color(:,38)';
argocolor = Color(:,24)';

qq=1;
numdate = 736665;
temp_str = num2str(vl(qq));
temp_name = ['UVEL',str,temp_str,'.bin'];
fid = fopen(temp_name,'r','b');
U = fread(fid,inf,'single');
NZ = length(U)/nn/mm;
U = reshape(U,[nn,mm,NZ]);
fclose(fid);
U = permute(U,[2,1,3]);

temp_name = ['VVEL',str,temp_str,'.bin'];
fid = fopen(temp_name,'r','b');
V = fread(fid,inf,'single');
NZ = length(V)/nn/mm;
V = reshape(V,[nn,mm,NZ]);
fclose(fid);
V = permute(V,[2,1,3]);

U = sqrt(U.^2 + V.^2);

ub = 1.5;
lb = -0.05;
osz = 220;
sz = 160;
bsz = 2.2*sz;
obsz = 2.2*osz;

z = linspace(lb,ub,nlvls);
z = [-100000,z,9999998];
dtstr_t = str2double(datestr(numdate,'yyyymmdd'));
Obs_Array_t = THETA_Obs(THETA_Obs(:,1)==dtstr_t,[2,3,argo_depth(qq)]);
SOCCOM_t = O2_Obs(O2_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XC,YC,U(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
scatter(Obs_Array_t(:,1),Obs_Array_t(:,2),osz,'k','filled')
scatter(Obs_Array_t(:,1),Obs_Array_t(:,2),sz,argocolor,'filled')
scatter(SOCCOM_t(:,1),SOCCOM_t(:,2),bsz,'k','filled','d')
scatter(SOCCOM_t(:,1),SOCCOM_t(:,2),obsz,bgccolor,'filled','d')
caxis([lb ub])
axis(coords)
xtickformat('degrees')
ytickformat('degrees')
title('Argo & BGC Argo float profiles','FontWeight','Normal')
acc_movie
acc_plots
text(292,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',28,'Color','w')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('FLOATS_2017.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 12;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:NZ
    numdate = numdate + 1;
    dtstr_t = str2double(datestr(numdate,'yyyymmdd'));
    Obs_Array_t = THETA_Obs(THETA_Obs(:,1)==dtstr_t,[2,3,argo_depth(qq)]);
    SOCCOM_t = O2_Obs(O2_Obs(:,1)==numdate,[2,3,argo_depth(qq)]);
    
    dtstr_y1 = str2double(datestr(numdate-1,'yyyymmdd'));
    Obs_Array_y1 = THETA_Obs(THETA_Obs(:,1)==dtstr_y1,[2,3,argo_depth(qq)]);
    SOCCOM_y1 = O2_Obs(O2_Obs(:,1)==numdate-1,[2,3,argo_depth(qq)]);

    if ii>2
        dtstr_y2 = str2double(datestr(numdate-2,'yyyymmdd'));
        Obs_Array_y2 = THETA_Obs(THETA_Obs(:,1)==dtstr_y2,[2,3,argo_depth(qq)]);
        SOCCOM_y2 = O2_Obs(O2_Obs(:,1)==numdate-2,[2,3,argo_depth(qq)]);
    end
    if ii>3
        dtstr_y3 = str2double(datestr(numdate-3,'yyyymmdd'));
        Obs_Array_y3 = THETA_Obs(THETA_Obs(:,1)==dtstr_y3,[2,3,argo_depth(qq)]);
        SOCCOM_y3 = O2_Obs(O2_Obs(:,1)==numdate-3,[2,3,argo_depth(qq)]);
    end
    if ii<NZ
        dtstr_t1 = str2double(datestr(numdate+1,'yyyymmdd'));
        Obs_Array_t1 = THETA_Obs(THETA_Obs(:,1)==dtstr_t1,[2,3,argo_depth(qq)]);
        SOCCOM_t1 = O2_Obs(O2_Obs(:,1)==numdate+1,[2,3,argo_depth(qq)]);
    end
    if ii<NZ-1
        dtstr_t2 = str2double(datestr(numdate+2,'yyyymmdd'));
        Obs_Array_t2 = THETA_Obs(THETA_Obs(:,1)==dtstr_t2,[2,3,argo_depth(qq)]);
        SOCCOM_t2 = O2_Obs(O2_Obs(:,1)==numdate+2,[2,3,argo_depth(qq)]);
    end
    if ii<NZ-2
        dtstr_t3 = str2double(datestr(numdate+3,'yyyymmdd'));
        Obs_Array_t3 = THETA_Obs(THETA_Obs(:,1)==dtstr_t3,[2,3,argo_depth(qq)]);
        SOCCOM_t3 = O2_Obs(O2_Obs(:,1)==numdate+3,[2,3,argo_depth(qq)]);
    end
    
    contourf(XC,YC,U(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,vl(qq)),'Color','k')
    scatter(Obs_Array_t(:,1),Obs_Array_t(:,2),osz,'k','filled')
    scatter(Obs_Array_t(:,1),Obs_Array_t(:,2),sz,argocolor,'filled')
    scatter(SOCCOM_t(:,1),SOCCOM_t(:,2),obsz,'k','filled','d')
    scatter(SOCCOM_t(:,1),SOCCOM_t(:,2),bsz,bgccolor,'filled','d')
    
    scatter(Obs_Array_y1(:,1),Obs_Array_y1(:,2),0.80*osz,'k','filled')
    scatter(Obs_Array_y1(:,1),Obs_Array_y1(:,2),0.80*sz,argocolor,'filled')
    scatter(SOCCOM_y1(:,1),SOCCOM_y1(:,2),0.80*obsz,'k','filled','d')
    scatter(SOCCOM_y1(:,1),SOCCOM_y1(:,2),0.80*bsz,bgccolor,'filled','d')
    if ii>2
        scatter(Obs_Array_y2(:,1),Obs_Array_y2(:,2),0.60*osz,'k','filled')
        scatter(Obs_Array_y2(:,1),Obs_Array_y2(:,2),0.60*sz,argocolor,'filled')
        scatter(SOCCOM_y2(:,1),SOCCOM_y2(:,2),0.60*obsz,'k','filled','d')
        scatter(SOCCOM_y2(:,1),SOCCOM_y2(:,2),0.60*bsz,bgccolor,'filled','d')
    end
    if ii>3
        scatter(Obs_Array_y3(:,1),Obs_Array_y3(:,2),0.40*osz,'k','filled')
        scatter(Obs_Array_y3(:,1),Obs_Array_y3(:,2),0.40*sz,argocolor,'filled')
        scatter(SOCCOM_y3(:,1),SOCCOM_y3(:,2),0.40*obsz,'k','filled','d')
        scatter(SOCCOM_y3(:,1),SOCCOM_y3(:,2),0.40*bsz,bgccolor,'filled','d')
    end
    if ii<NZ
        scatter(Obs_Array_t1(:,1),Obs_Array_t1(:,2),0.80*osz,'k','filled')
        scatter(Obs_Array_t1(:,1),Obs_Array_t1(:,2),0.80*sz,argocolor,'filled')
        scatter(SOCCOM_t1(:,1),SOCCOM_t1(:,2),0.80*obsz,'k','filled','d')
        scatter(SOCCOM_t1(:,1),SOCCOM_t1(:,2),0.80*bsz,bgccolor,'filled','d')
    end
    if ii<NZ-1
        scatter(Obs_Array_t2(:,1),Obs_Array_t2(:,2),0.60*osz,'k','filled')
        scatter(Obs_Array_t2(:,1),Obs_Array_t2(:,2),0.60*sz,argocolor,'filled')
        scatter(SOCCOM_t2(:,1),SOCCOM_t2(:,2),0.60*obsz,'k','filled','d')
        scatter(SOCCOM_t2(:,1),SOCCOM_t2(:,2),0.60*bsz,bgccolor,'filled','d')
    end
    if ii<NZ-2
        scatter(Obs_Array_t3(:,1),Obs_Array_t3(:,2),0.40*osz,'k','filled')
        scatter(Obs_Array_t3(:,1),Obs_Array_t3(:,2),0.40*sz,argocolor,'filled')
        scatter(SOCCOM_t3(:,1),SOCCOM_t3(:,2),0.40*obsz,'k','filled','d')
        scatter(SOCCOM_t3(:,1),SOCCOM_t3(:,2),0.40*bsz,bgccolor,'filled','d')
    end
    caxis([lb ub])
    axis(coords)
    title('Argo & BGC Argo float profiles','FontWeight','Normal')
    xtickformat('degrees')
    ytickformat('degrees')
    acc_movie
    text(292,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',28,'Color','w')
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    hold off
end

close(vidObj);
close all
clear z U