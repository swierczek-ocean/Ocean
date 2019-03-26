

str3 = '../OOI_Data/deployment0003_GA02HYPM-WFP02-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20161030T000204-20171003T185635.nc';

ncdisp(str3)

pres = ncread(str3,'int_ctd_pressure');
time = ncread(str3,'internal_timestamp');
dissolved_oxygen = ncread(str3,'dissolved_oxygen');
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');

ind = find(pres>330 & pres<370);
lat = lat(ind);
lon = lon(ind);
time = time(ind);
pres = pres(ind);
dissolved_oxygen = dissolved_oxygen(ind);
depth = gsw_z_from_p(pres,lat);


for ii=1:length(time)
   time(ii) = str2double(datestr(acc_convert_time_19000101(time(ii)),'yyyymmdd'));
end



Obs_DO_350_temp = [time,lat,lon+360,dissolved_oxygen];
Obs_DO_350_temp = sortrows(Obs_DO_350_temp,1);

start_date = 20161130;

start = find(Obs_DO_350_temp(:,1)>start_date,1);

Obs_DO_350_temp = Obs_DO_350_temp(start:end,:);


% sample_p = pres(1:1000);
% sample_lat = lat(1:1000);
% 
% histogram(sample_p)
% 
% depth = gsw_z_from_p(pres(ind),lat(ind));
% figure
% histogram(depth)

Obs_DO_350 = zeros(307,4);
date = 736665;

for ii=1:307
    date_n = str2double(datestr(date,'yyyymmdd'));
    Obs_DO_350(ii,:) = mean(Obs_DO_350_temp(Obs_DO_350_temp(:,1)==date_n,:),1);
    date = date+1;
end

clearvars -except Obs_DO_350

save Obs_DO_350