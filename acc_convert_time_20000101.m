function output_num = acc_convert_time_20000101(num)
%% converts argument of seconds since 2000-01-01 to matlab datenum
%%

ref_date = datenum('20000101','yyyymmdd');
num = num/86400;
output_num = ref_date + num;

end

