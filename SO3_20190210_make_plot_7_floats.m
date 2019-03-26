
clear
close all
clc

tic()
acc_settings
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

fn = unique(O2_Obs(:,101));
num_floats = length(fn);

cm = [Color(:,8)';Color(:,36)'];
bgccolor = Color(:,3)';
argocolor = Color(:,11)';
color_array = [Color(:,3)';Color(:,30)';Color(:,16)';Color(:,22)';Color(:,11)';Color(:,47)';...
    Color(:,39)';Color(:,7)';Color(:,32)';Color(:,13)';Color(:,9)';Color(:,10)';Color(:,33)'];

ub = 1.5;
lb = -0.05;
osz = 150;
sz = 90;
bsz = 2.2*sz;
obsz = 2.2*osz;

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XCm,YCm,mask(:,:,1))
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
for ii=1:num_floats
   name = fn(ii);
   temp_Obs = O2_Obs(O2_Obs(:,101)==name,:);
   T = temp_Obs(:,1);
   X = temp_Obs(:,2);
   Y = temp_Obs(:,3);
%    lll = length(T);
%    knots = [1:lll,lll+1];
%    curve = spmak(knots,[X';Y'])
%    values = fnval(curve,T);
%    fnplt(curve,'w',2.1);
   points = [X';Y'];
   % fnplt(cscvn(points),'w',2.4)
   points = fnplt(cscvn(points));
   plot(points(1,:),points(2,:),'LineWidth',2.8,'Color',color_array(ii,:))
   % plot(values(1,:),values(2,:),'LineWidth',2.2,'Color','w');
   % plot(X,Y,'LineWidth',2.1,'Color','w')    
end

for jj=1:num_floats
    name = fn(jj);
    temp_Obs = O2_Obs(O2_Obs(:,101)==name,:);
    X = temp_Obs(:,2);
    Y = temp_Obs(:,3);
    scatter(X,Y,obsz,'k','filled','d')
    scatter(X,Y,bsz,color_array(jj,:),'filled','d')
end
% scatter(O2_Obs(:,2),O2_Obs(:,3),obsz,'k','filled','d')
% scatter(O2_Obs(:,2),O2_Obs(:,3),bsz,bgccolor,'filled','d')
caxis([lb ub])
axis(coords)
xtickformat('degrees')
ytickformat('degrees')
title('BGC Argo float profiles during 2017','FontWeight','Normal')
acc_movie
acc_plots
hold off
print('bgc_floats_plot','-dpng')

