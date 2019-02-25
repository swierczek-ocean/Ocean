fl_str = '../SOCCOM/VIZ_SO_2017_PFL.nc';
ncdisp(fl_str);
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
RC = rdmds('RC');
RC = squeeze(RC);
RC = -RC;

A = (lon<350)&(lon>289.99);
B = (lat<-32)&(lat>-59.3);
C = (date>20161130);
D = A.*B.*C;
n_obs = sum(D);

O2_Obs_Array2 = zeros(n_obs,100);
NO3_Obs_Array2 = zeros(n_obs,100);
CHL_Obs_Array2 = zeros(n_obs,100);
PH_Obs_Array2 = zeros(n_obs,100);
DIC_LIAR_Obs_Array2 = zeros(n_obs,100);
DIC_MLR_Obs_Array2 = zeros(n_obs,100);
DIC_CANY_Obs_Array2 = zeros(n_obs,100);
ALK_LIAR_Obs_Array2 = zeros(n_obs,100);
ALK_MLR_Obs_Array2 = zeros(n_obs,100);
ALK_CANY_Obs_Array2 = zeros(n_obs,100);
PCO_LIAR_Obs_Array2 = zeros(n_obs,100);
PCO_MLR_Obs_Array2 = zeros(n_obs,100);
PCO_CANY_Obs_Array2 = zeros(n_obs,100);
counter = 1;

for ii=1:length(A)
   if D(ii)==1
      O2_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          O2(:,ii)'];
      NO3_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          NO3(:,ii)']; 
      CHL_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          CHL(:,ii)'];
      PH_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PH(:,ii)'];
      DIC_LIAR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_LIAR(:,ii)'];
      DIC_MLR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_MLR(:,ii)'];
      DIC_CANY_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          DIC_CANY(:,ii)'];
      ALK_LIAR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_LIAR(:,ii)'];
      ALK_MLR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_MLR(:,ii)'];
      ALK_CANY_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          ALK_CANY(:,ii)'];
      PCO_LIAR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_LIAR(:,ii)'];
      PCO_MLR_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_MLR(:,ii)'];
      PCO_CANY_Obs_Array2(counter,:) = [date(ii),lon(ii),lat(ii),...
          PCO_CANY(:,ii)'];
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
