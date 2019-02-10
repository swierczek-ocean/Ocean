function [array] = acc_scale(array,lb,ub)
low = min(min(array));
high = 0.8.*max(max(array));

diffin = high-low;
diffout = ub-lb;

array = array - low;
array = diffout.*array./diffin;
array = array + ub;

end

