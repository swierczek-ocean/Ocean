clear
close all
clc

tic()
format short g

fl_str = '../SOCCOM/VIZ_SO_2016_PFL.nc';
ncdisp(fl_str);
names_temp = ncread(fl_str,'prof_descr');
names_temp = names_temp';
names_temp = names_temp(:,5:9);
names = zeros(size(names_temp,1),1);

for kk=1:size(names_temp,1)
    if names_temp(kk,5)=='L'
        names(kk) = str2double(names_temp(kk,1:4));
    else
        names(kk) = str2double(names_temp(kk,:));
    end
end

depth = ncread(fl_str,'prof_depth');
O2 = ncread(fl_str,'prof_O2');
NO3 = ncread(fl_str,'prof_NO3');
CHL = ncread(fl_str,'prof_CHL');
PH = ncread(fl_str,'prof_PH');
DIC_LIAR = ncread(fl_str,'prof_DIC_LIAR');
DIC_MLR = ncread(fl_str,'prof_DIC_MLR');
DIC_CANY = ncread(fl_str,'prof_DIC_CANY');
ALK_LIAR = ncread(fl_str,'prof_ALK_LIAR');
ALK_MLR = ncread(fl_str,'prof_ALK_MLR');
ALK_CANY = ncread(fl_str,'prof_ALK_CANY');
PCO_LIAR = ncread(fl_str,'prof_PCO_LIAR');
PCO_MLR = ncread(fl_str,'prof_PCO_MLR');
PCO_CANY = ncread(fl_str,'prof_PCO_CANY');
lon = ncread(fl_str,'prof_lon');
lat = ncread(fl_str,'prof_lat');
date = ncread(fl_str,'prof_YYYYMMDD');
for ii=1:length(date)
    date(ii) = datenum(num2str(date(ii)),'yyyymmdd');
end
% RC = rdmds('RC');
% RC = squeeze(RC);
% RC = -RC;

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>736664);
D = A.*B.*C;
n_obs = sum(D);

O2_Obs_Array1 = zeros(n_obs,101);
NO3_Obs_Array1 = zeros(n_obs,101);
CHL_Obs_Array1 = zeros(n_obs,101);
PH_Obs_Array1 = zeros(n_obs,101);
DIC_LIAR_Obs_Array1 = zeros(n_obs,101);
DIC_MLR_Obs_Array1 = zeros(n_obs,101);
DIC_CANY_Obs_Array1 = zeros(n_obs,101);
ALK_LIAR_Obs_Array1 = zeros(n_obs,101);
ALK_MLR_Obs_Array1 = zeros(n_obs,101);
ALK_CANY_Obs_Array1 = zeros(n_obs,101);
PCO_LIAR_Obs_Array1 = zeros(n_obs,101);
PCO_MLR_Obs_Array1 = zeros(n_obs,101);
PCO_CANY_Obs_Array1 = zeros(n_obs,101);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      O2_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          O2(:,ii)',names(ii)];
      NO3_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          NO3(:,ii)',names(ii)]; 
      CHL_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          CHL(:,ii)',names(ii)];
      PH_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          PH(:,ii)',names(ii)];
      DIC_LIAR_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_LIAR(:,ii)',names(ii)];
      DIC_MLR_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_MLR(:,ii)',names(ii)];
      DIC_CANY_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_CANY(:,ii)',names(ii)];
      ALK_LIAR_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_LIAR(:,ii)',names(ii)];
      ALK_MLR_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_MLR(:,ii)',names(ii)];
      ALK_CANY_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_CANY(:,ii)',names(ii)];
      PCO_LIAR_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_LIAR(:,ii)',names(ii)];
      PCO_MLR_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_MLR(:,ii)',names(ii)];
      PCO_CANY_Obs_Array1(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_CANY(:,ii)',names(ii)];
      counter = counter + 1;
   end
end

O2_Obs_Array1(O2_Obs_Array1==-9999) = NaN;
NO3_Obs_Array1(NO3_Obs_Array1==-9999) = NaN;
CHL_Obs_Array1(CHL_Obs_Array1==-9999) = NaN;
PH_Obs_Array1(PH_Obs_Array1==-9999) = NaN;
DIC_LIAR_Obs_Array1(DIC_LIAR_Obs_Array1==-9999) = NaN;
DIC_MLR_Obs_Array1(DIC_MLR_Obs_Array1==-9999) = NaN;
DIC_CANY_Obs_Array1(DIC_CANY_Obs_Array1==-9999) = NaN;
ALK_LIAR_Obs_Array1(ALK_LIAR_Obs_Array1==-9999) = NaN;
ALK_MLR_Obs_Array1(ALK_MLR_Obs_Array1==-9999) = NaN;
ALK_CANY_Obs_Array1(ALK_CANY_Obs_Array1==-9999) = NaN;
PCO_LIAR_Obs_Array1(PCO_LIAR_Obs_Array1==-9999) = NaN;
PCO_MLR_Obs_Array1(PCO_MLR_Obs_Array1==-9999) = NaN;
PCO_CANY_Obs_Array1(PCO_CANY_Obs_Array1==-9999) = NaN;

O2_Obs_Array1 = sortrows(O2_Obs_Array1);
NO3_Obs_Array1 = sortrows(NO3_Obs_Array1);
CHL_Obs_Array1 = sortrows(CHL_Obs_Array1);
PH_Obs_Array1 = sortrows(PH_Obs_Array1);
DIC_LIAR_Obs_Array1 = sortrows(DIC_LIAR_Obs_Array1);
DIC_MLR_Obs_Array1 = sortrows(DIC_MLR_Obs_Array1);
DIC_CANY_Obs_Array1 = sortrows(DIC_CANY_Obs_Array1);
ALK_LIAR_Obs_Array1 = sortrows(ALK_LIAR_Obs_Array1);
ALK_MLR_Obs_Array1 = sortrows(ALK_MLR_Obs_Array1);
ALK_CANY_Obs_Array1 = sortrows(ALK_CANY_Obs_Array1);
PCO_LIAR_Obs_Array1 = sortrows(PCO_LIAR_Obs_Array1);
PCO_MLR_Obs_Array1 = sortrows(PCO_MLR_Obs_Array1);
PCO_CANY_Obs_Array1 = sortrows(PCO_CANY_Obs_Array1);

fl_str = '../SOCCOM/VIZ_SO_2017_PFL.nc';
ncdisp(fl_str);
depth = ncread(fl_str,'prof_depth');
names_temp = ncread(fl_str,'prof_descr');
names_temp = names_temp';
names_temp = names_temp(:,5:9);
names = zeros(size(names_temp,1),1);

for kk=1:size(names_temp,1)
    if names_temp(kk,5)=='L'
        names(kk) = str2double(names_temp(kk,1:4));
    else
        names(kk) = str2double(names_temp(kk,:));
    end
end

O2 = ncread(fl_str,'prof_O2');
NO3 = ncread(fl_str,'prof_NO3');
CHL = ncread(fl_str,'prof_CHL');
PH = ncread(fl_str,'prof_PH');
DIC_LIAR = ncread(fl_str,'prof_DIC_LIAR');
DIC_MLR = ncread(fl_str,'prof_DIC_MLR');
DIC_CANY = ncread(fl_str,'prof_DIC_CANY');
ALK_LIAR = ncread(fl_str,'prof_ALK_LIAR');
ALK_MLR = ncread(fl_str,'prof_ALK_MLR');
ALK_CANY = ncread(fl_str,'prof_ALK_CANY');
PCO_LIAR = ncread(fl_str,'prof_PCO_LIAR');
PCO_MLR = ncread(fl_str,'prof_PCO_MLR');
PCO_CANY = ncread(fl_str,'prof_PCO_CANY');
lon = ncread(fl_str,'prof_lon');
lat = ncread(fl_str,'prof_lat');
date = ncread(fl_str,'prof_YYYYMMDD');
for ii=1:length(date)
    date(ii) = datenum(num2str(date(ii)),'yyyymmdd');
end
% RC = rdmds('RC');
% RC = squeeze(RC);
% RC = -RC;

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>736664);
D = A.*B.*C;
n_obs = sum(D);

O2_Obs_Array2 = zeros(n_obs,101);
NO3_Obs_Array2 = zeros(n_obs,101);
CHL_Obs_Array2 = zeros(n_obs,101);
PH_Obs_Array2 = zeros(n_obs,101);
DIC_LIAR_Obs_Array2 = zeros(n_obs,101);
DIC_MLR_Obs_Array2 = zeros(n_obs,101);
DIC_CANY_Obs_Array2 = zeros(n_obs,101);
ALK_LIAR_Obs_Array2 = zeros(n_obs,101);
ALK_MLR_Obs_Array2 = zeros(n_obs,101);
ALK_CANY_Obs_Array2 = zeros(n_obs,101);
PCO_LIAR_Obs_Array2 = zeros(n_obs,101);
PCO_MLR_Obs_Array2 = zeros(n_obs,101);
PCO_CANY_Obs_Array2 = zeros(n_obs,101);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      O2_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          O2(:,ii)',names(ii)];
      NO3_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          NO3(:,ii)',names(ii)]; 
      CHL_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          CHL(:,ii)',names(ii)];
      PH_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PH(:,ii)',names(ii)];
      DIC_LIAR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_LIAR(:,ii)',names(ii)];
      DIC_MLR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_MLR(:,ii)',names(ii)];
      DIC_CANY_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_CANY(:,ii)',names(ii)];
      ALK_LIAR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_LIAR(:,ii)',names(ii)];
      ALK_MLR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_MLR(:,ii)',names(ii)];
      ALK_CANY_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_CANY(:,ii)',names(ii)];
      PCO_LIAR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_LIAR(:,ii)',names(ii)];
      PCO_MLR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_MLR(:,ii)',names(ii)];
      PCO_CANY_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_CANY(:,ii)',names(ii)];
      counter = counter + 1;
   end
end

O2_Obs_Array2(O2_Obs_Array2==-9999) = NaN;
NO3_Obs_Array2(NO3_Obs_Array2==-9999) = NaN;
CHL_Obs_Array2(CHL_Obs_Array2==-9999) = NaN;
PH_Obs_Array2(PH_Obs_Array2==-9999) = NaN;
DIC_LIAR_Obs_Array2(DIC_LIAR_Obs_Array2==-9999) = NaN;
DIC_MLR_Obs_Array2(DIC_MLR_Obs_Array2==-9999) = NaN;
DIC_CANY_Obs_Array2(DIC_CANY_Obs_Array2==-9999) = NaN;
ALK_LIAR_Obs_Array2(ALK_LIAR_Obs_Array2==-9999) = NaN;
ALK_MLR_Obs_Array2(ALK_MLR_Obs_Array2==-9999) = NaN;
ALK_CANY_Obs_Array2(ALK_CANY_Obs_Array2==-9999) = NaN;
PCO_LIAR_Obs_Array2(PCO_LIAR_Obs_Array2==-9999) = NaN;
PCO_MLR_Obs_Array2(PCO_MLR_Obs_Array2==-9999) = NaN;
PCO_CANY_Obs_Array2(PCO_CANY_Obs_Array2==-9999) = NaN;

O2_Obs_Array2 = sortrows(O2_Obs_Array2);
NO3_Obs_Array2 = sortrows(NO3_Obs_Array2);
CHL_Obs_Array2 = sortrows(CHL_Obs_Array2);
PH_Obs_Array2 = sortrows(PH_Obs_Array2);
DIC_LIAR_Obs_Array2 = sortrows(DIC_LIAR_Obs_Array2);
DIC_MLR_Obs_Array2 = sortrows(DIC_MLR_Obs_Array2);
DIC_CANY_Obs_Array2 = sortrows(DIC_CANY_Obs_Array2);
ALK_LIAR_Obs_Array2 = sortrows(ALK_LIAR_Obs_Array2);
ALK_MLR_Obs_Array2 = sortrows(ALK_MLR_Obs_Array2);
ALK_CANY_Obs_Array2 = sortrows(ALK_CANY_Obs_Array2);
PCO_LIAR_Obs_Array2 = sortrows(PCO_LIAR_Obs_Array2);
PCO_MLR_Obs_Array2 = sortrows(PCO_MLR_Obs_Array2);
PCO_CANY_Obs_Array2 = sortrows(PCO_CANY_Obs_Array2);

O2_Obs = [O2_Obs_Array1;O2_Obs_Array2];
NO3_Obs = [NO3_Obs_Array1;NO3_Obs_Array2];
CHL_Obs = [CHL_Obs_Array1;CHL_Obs_Array2];
PH_Obs = [PH_Obs_Array1;PH_Obs_Array2];
DIC_LIAR_Obs = [DIC_LIAR_Obs_Array1;DIC_LIAR_Obs_Array2];
DIC_MLR_Obs = [DIC_MLR_Obs_Array1;DIC_MLR_Obs_Array2];
DIC_CANY_Obs = [DIC_CANY_Obs_Array1;DIC_CANY_Obs_Array2];
ALK_LIAR_Obs = [ALK_LIAR_Obs_Array1;ALK_LIAR_Obs_Array2];
ALK_MLR_Obs = [ALK_MLR_Obs_Array1;ALK_MLR_Obs_Array2];
ALK_CANY_Obs = [ALK_CANY_Obs_Array1;ALK_CANY_Obs_Array2];
PCO_LIAR_Obs = [PCO_LIAR_Obs_Array1;PCO_LIAR_Obs_Array2];
PCO_MLR_Obs = [PCO_MLR_Obs_Array1;PCO_MLR_Obs_Array2];
PCO_CANY_Obs = [PCO_CANY_Obs_Array1;PCO_CANY_Obs_Array2];

clear counter A B C D n_obs ii jj *Array1 *Array2 O2 NO3 CHL PH DIC_LIAR DIC_MLR DIC_CANY
clear ALK_LIAR ALK_MLR ALK_CANY PCO_LIAR PCO_MLR PCO_CANY depth date fl_str lat lon
save BGCObs

toc()