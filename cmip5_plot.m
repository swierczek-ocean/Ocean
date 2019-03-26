
clear
close all
clc

lw = 2.2; 
ms = 9;
acc_settings

str = 'total_heat_flux_zonal_ave_Argentine_Basin.nc';
ncdisp(str)

ESM2M = ncread(str,'ESM2M_ARGENTINEBASIN');
ESM2Mlat = ncread(str,'RLAT1_50');

ESM2G = ncread(str,'ESM2G_ARGENTINEBASIN');
ESM2Glat = ncread(str,'RLAT11_52');

CANESM2 = ncread(str,'CANESM2_ARGENTINEBASIN');
CANESM2lat = ncread(str,'LAT1_62');

GFDL = ncread(str,'GFDL_CM3_ARGENTINEBASIN');
GFDLlat = ncread(str,'RLAT1_50');

FGOALSG2 = ncread(str,'FGOALSG2_ARGENTINEBASIN');
FGOALSG2lat = ncread(str,'LAT41_47');

CSIROMK360 = ncread(str,'CSIROMK360_ARGENTINEBASIN');
CSIROMK360lat = ncread(str,'LAT1_61');

GISSE2RCC = ncread(str,'GISSE2RCC_ARGENTINEBASIN');
GISSE2RCClat = ncread(str,'LAT11_58');

ERA_INTERIM = ncread(str,'ERA_INTERIM_CORRECT_ARGENTINEBASIN');
ERA_INTERIMlat = ncread(str,'LAT1_78');

CFSR = ncread(str,'CFSR_ARGENTINEBASIN');
CFSRlat = ncread(str,'LAT11_116');

coords = [-70 -32.5 -48 54];
X = linspace(-70,-32.5,100);
Y = zeros(1,100);


figure()
set(gcf, 'Position', [1, 1, 1600, 900])
h1 = plot(ERA_INTERIMlat,ERA_INTERIM,'LineWidth',lw,'Color',Color(:,37));
hold on
h2 = plot(CFSRlat,CFSR,'--','LineWidth',lw,'Color',Color(:,37));
plot(GISSE2RCClat,GISSE2RCC,'o','MarkerSize',ms,'Color',Color(:,9));
h3 = plot(GISSE2RCClat,GISSE2RCC,'LineWidth',lw,'Color',Color(:,9));
plot(CSIROMK360lat,CSIROMK360,'^','MarkerSize',ms,'Color',Color(:,11));
h4 = plot(CSIROMK360lat,CSIROMK360,'LineWidth',lw,'Color',Color(:,11));
plot(FGOALSG2lat,FGOALSG2,'d','MarkerSize',ms,'Color',Color(:,39));
h5 = plot(FGOALSG2lat,FGOALSG2,'LineWidth',lw,'Color',Color(:,39));
plot(GFDLlat,GFDL,'s','MarkerSize',ms,'Color',Color(:,16));
h6 = plot(GFDLlat,GFDL,'LineWidth',lw,'Color',Color(:,16));
plot(CANESM2lat,CANESM2,'v','MarkerSize',ms,'Color',Color(:,19));
h7 = plot(CANESM2lat,CANESM2,'LineWidth',lw,'Color',Color(:,19));
plot(ESM2Glat,ESM2G,'p','MarkerSize',ms,'Color',Color(:,3));
h8 = plot(ESM2Glat,ESM2G,'LineWidth',lw,'Color',Color(:,3));
plot(ESM2Mlat,ESM2M,'h','MarkerSize',ms,'Color',Color(:,30));
h9 = plot(ESM2Mlat,ESM2M,'LineWidth',lw,'Color',Color(:,30));
plot(X,Y,'Color','k')
axis(coords)
xtickformat('degrees')
title('zonally averaged heat flux 70W to 10W (W/m^2), ERA Interim & CFSR vs. CMIP5 models','FontWeight','Normal')
acc_plots
acc_movie
legend([h1(1),h2(1),h3(1),h4(1),h5(1),h6(1),h7(1),h8(1),h9(1)],'ERA Interim','CFSR','GISSE2RCC','CSIROMK360','FGOALSG2','GFDL CM3','CANESM2','ESM2G','ESM2M')
legend('Location','southeast')
hold off
print('CMIP5','-djpeg')









