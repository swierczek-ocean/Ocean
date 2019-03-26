
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

coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
argo_depth = [10,33,52,58,69,78];
nn = 182;
mm = 122;


cm = [Color(:,8)';Color(:,36)'];
bgccolor = Color(:,3)';
argocolor = Color(:,11)';


ub = 1.5;
lb = -0.05;
osz = 200;
sz = 140;
bsz = 2.2*sz;
obsz = 2.2*osz;

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XCm,YCm,mask(:,:,1))
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
scatter(THETA_Obs(:,2),THETA_Obs(:,3),osz,'k','filled')
h1 = scatter(THETA_Obs(:,2),THETA_Obs(:,3),sz,argocolor,'filled');
scatter(O2_Obs(:,2),O2_Obs(:,3),obsz,'k','filled','d')
h2 = scatter(O2_Obs(:,2),O2_Obs(:,3),bsz,bgccolor,'filled','d');
caxis([lb ub])
axis(coords)
xtickformat('degrees')
ytickformat('degrees')
title('Argo & BGC Argo float profiles during 2017','FontWeight','Normal')
acc_movie
acc_plots
legend([h1(1),h2(1)],'Argo profiles','BGC Argo profiles')
legend('Location','northwest')
hold off
print('floats_plot','-dpng')

