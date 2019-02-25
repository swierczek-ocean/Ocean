
% str1 = '../OOI_Data/deployment0003_GA01SUMO-SBD11-06-METBKA000-telemetered-metbk_a_dcl_instrument_20161027T014720.743000-20170324T223258.498000.nc';
% ncdisp(str1)
% str2 = '../OOI_Data/deployment0003_GA02HYPM-RIM01-02-CTDMOG039-recovered_inst-ctdmo_ghqr_instrument_recovered_20161029T221501-20180111T121501.nc';
% ncdisp(str2)
% pressure_temp = ncread(str2,'pressure_temp');

str3 = '../OOI_Data/deployment0003_GA02HYPM-WFP02-04-CTDPFL000-recovered_wfp-ctdpf_ckl_wfp_instrument_recovered_20161030T000003-20171003T185844.999253.nc';

ncdisp(str3)

pres = ncread(str3,'ctdpf_ckl_seawater_pressure');
time = ncread(str3,'internal_timestamp');
temp = ncread(str3,'ctdpf_ckl_seawater_temperature');
salt = ncread(str3,'practical_salinity');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

ind = find(pres>1800 & pres<1845);
lat = lat(ind);
lon = lon(ind);
time = time(ind);
pres = pres(ind);
temp = temp(ind);
salt = salt(ind);
depth = gsw_z_from_p(pres,lat);

SA = gsw_SA_from_SP(salt,pres,lon,lat);
theta = gsw_pt_from_t(SA,temp,pres);

for ii=1:length(time)
   time(ii) = str2double(datestr(acc_convert_time_19000101(time(ii)),'yyyymmdd'));
end



Obs_1800_temp = [time,lat,lon+360,theta,salt];
Obs_1800_temp = sortrows(Obs_1800_temp,1);

start_date = 20161130;

start = find(Obs_1800_temp(:,1)>start_date,1);

Obs_1800_temp = Obs_1800_temp(start:end,:);


% sample_p = pres(1:1000);
% sample_lat = lat(1:1000);
% 
% histogram(sample_p)
% 
% depth = gsw_z_from_p(pres(ind),lat(ind));
% figure
% histogram(depth)

Obs_1800 = zeros(307,5);
date = 736665;

for ii=1:307
    date_n = str2double(datestr(date,'yyyymmdd'));
    Obs_1800(ii,:) = mean(Obs_1800_temp(Obs_1800_temp(:,1)==date_n,:),1);
    date = date+1;
end

clearvars -except Obs_1800

save Obs_1800