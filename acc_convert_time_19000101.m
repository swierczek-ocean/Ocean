function output_num = acc_convert_time_19000101(num)
%% converts argument of seconds since 1900-01-01 to matlab datenum
%%

ref_date = datenum('19000101','yyyymmdd');
num = num/86400;
output_num = ref_date + num;

end

