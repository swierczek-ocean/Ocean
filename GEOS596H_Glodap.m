clear
close all
clc

tic()

acc_colors
acc_settings

str1 = '../SOCCOM/GLODAPv2.nc';

ncdisp(str1)

T = ncread(str1,'prof_T');
prof_depth = ncread(str1,'prof_depth');
lat = ncread(str1,'prof_lat');
lon = ncread(str1,'prof_lon');

[n,m] = size(T);

for ii=1:n
    for jj=1:m
        if T(ii,jj)==-9999
            T(ii,jj)=NaN;
        end
    end
end

logic_T = ~isnan(T);

list = sum(logic_T,2);


load mask12


cm1 = [Color(:,46)';1,1,1;cm];
lb = -2;
ub = 30;
nlvls = 129;
z = linspace(lb,ub,nlvls);
z = [z,39,40.5];



T_20m = T(1:7,:);

[n,m] = size(T_20m);
temp_t = zeros(1,m);

for ii=1:m
    temp_prof = T_20m(:,ii);
    temp_t(ii) = mean(temp_prof(~isnan(temp_prof)));
end

obs_array = [lat(~isnan(temp_t)),lon(~isnan(temp_t)),temp_t(~isnan(temp_t))'];
coords = [0 360 -78 -10];

figure()
set(gcf, 'Position', [1, 1, 1900, 900])
colormap(cm1)
contourf(XC12,YC12,mask12+40,'LineStyle','none','LevelList',z);
hold on
contour(XC12,YC12,mask12,'k')
scatter(obs_array(:,2),obs_array(:,1),160,obs_array(:,3),'filled')
axis(coords)



toc()


