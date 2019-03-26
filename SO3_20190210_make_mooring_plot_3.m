str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG040-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_30 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG042-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_60 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG043-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_90 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG044-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_130 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG045-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_180 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG046-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_250 = [time,lat,lon+360,theta,salt];


str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG047-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_350 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOG048-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_500 = [time,lat,lon+360,theta,salt];

str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOH049-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_750 = [time,lat,lon+360,theta,salt];


str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOH050-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

% depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_1000 = [time,lat,lon+360,theta,salt];


str3 = '../OOI_Data/deployment0003_GA03FLMA-RIM01-02-CTDMOH051-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';

ncdisp(str3)

pres = ncread(str3,'ctdmo_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdmo_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = acc_convert_time_19000101(time(ii));
end

Obs_1500 = [time,lat,lon+360,theta,salt];

tlim = [2 17];
lw = 1.3; 
acc_settings
coords = [datenum('20161101','yyyymmdd') datenum('20171231','yyyymmdd') 2 18];


figure()
set(gcf, 'Position', [1, 1, 1900, 1100])
h1 = plot(Obs_30(:,1),Obs_30(:,4),'LineWidth',lw,'Color',Color(:,9));
hold on
h2 = plot(Obs_60(:,1),Obs_60(:,4),'LineWidth',lw,'Color',Color(:,3));
h3 = plot(Obs_90(:,1),Obs_90(:,4),'LineWidth',lw,'Color',Color(:,12));
h4 = plot(Obs_130(:,1),Obs_130(:,4),'LineWidth',lw,'Color',Color(:,33));
h5 = plot(Obs_180(:,1),Obs_180(:,4),'LineWidth',lw,'Color',Color(:,13));
h6 = plot(Obs_250(:,1),Obs_250(:,4),'LineWidth',lw,'Color',Color(:,34));
h7 = plot(Obs_350(:,1),Obs_350(:,4),'LineWidth',lw,'Color',Color(:,11));
h8 = plot(Obs_500(:,1),Obs_500(:,4),'LineWidth',lw,'Color',Color(:,35));
h9 = plot(Obs_750(:,1),Obs_750(:,4),'LineWidth',lw,'Color',Color(:,18));
h10 = plot(Obs_1000(:,1),Obs_1000(:,4),'LineWidth',lw,'Color',Color(:,6));
h11 = plot(Obs_1500(:,1),Obs_1500(:,4),'LineWidth',lw,'Color',Color(:,32));

dateFormat = 'yyyy mmm';
datetick('x',dateFormat)
title('Global Argentine Basin subsurface flanking mooring A potential temperature during deployment 3','FontWeight','Normal')
axis(coords)
acc_plots
acc_movie
legend([h1(1),h2(1),h3(1),h4(1),h5(1),h6(1),h7(1),h8(1),h9(1),h10(1),h11(1)],'30m','60m','90m','130m','180m','250m','350m','500m','750m','1000m','1500m')
legend('Location','northwest')
hold off
print('THETA_TS','-djpeg')







lw = 1.3; 
acc_settings
coords = [datenum('20161101','yyyymmdd') datenum('20171231','yyyymmdd') 34.1 35.4];


figure()
set(gcf, 'Position', [1, 1, 1900, 1100])
% h1 = plot(Obs_30(:,1),Obs_30(:,5),'LineWidth',lw,'Color',Color(:,9));

h2 = plot(Obs_60(:,1),Obs_60(:,5),'LineWidth',lw,'Color',Color(:,3));
hold on
% h3 = plot(Obs_90(:,1),Obs_90(:,5),'LineWidth',lw,'Color',Color(:,12));
% h4 = plot(Obs_130(:,1),Obs_130(:,5),'LineWidth',lw,'Color',Color(:,33));
% h5 = plot(Obs_180(:,1),Obs_180(:,5),'LineWidth',lw,'Color',Color(:,13));
h6 = plot(Obs_250(:,1),Obs_250(:,5),'LineWidth',lw,'Color',Color(:,34));
% h7 = plot(Obs_350(:,1),Obs_350(:,5),'LineWidth',lw,'Color',Color(:,11));
h8 = plot(Obs_500(:,1),Obs_500(:,5),'LineWidth',lw,'Color',Color(:,35));
% h9 = plot(Obs_750(:,1),Obs_750(:,5),'LineWidth',lw,'Color',Color(:,18));
% h10 = plot(Obs_1000(:,1),Obs_1000(:,5),'LineWidth',lw,'Color',Color(:,6));
% h11 = plot(Obs_1500(:,1),Obs_1500(:,5),'LineWidth',lw,'Color',Color(:,32));

dateFormat = 'yyyy mmm';
datetick('x',dateFormat)
title('Global Argentine Basin subsurface flanking mooring A practical salinity during deployment 3','FontWeight','Normal')
axis(coords)
acc_plots
acc_movie
% legend([h1(1),h2(1),h3(1),h4(1),h5(1),h6(1),h7(1),h8(1),h9(1),h10(1),h11(1)],'30m','60m','90m','130m','180m','250m','350m','500m','750m','1000m','1500m')
legend([h2(1),h6(1),h8(1)],'60m','250m','500m')
legend('Location','best')
hold off
print('SALT_TS','-djpeg')












