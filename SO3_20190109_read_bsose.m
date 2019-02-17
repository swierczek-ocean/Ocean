
clear
close all
clc

tic()
str = 'bsose_i122_2013to2017_monthly_SSH.nc';

ncdisp(str);

XC = ncread(str,'XC');
YC = ncread(str,'YC');
timeb = ncread(str,'time');


acc_settings
% XC = rdmds('XC');
% YC = rdmds('YC');
% RC = rdmds('RC');
% RC = squeeze(RC);
% RC = -RC;
% XC = XC(:,end);
% YC = YC(end,:);
lox = find(XC>289.99,1);
hix = find(XC>350,1);
loy = find(YC>-59.3,1);
hiy = find(YC>-32,1);
XC = XC(lox:hix);
YC = YC(loy:hiy);

% loxb = find(XCb>289.99,1);
% hixb = find(XCb>350,1);
% XCb = XCb(loxb:2:hixb);
% loyb = find(YCb>-59.3,1);
% hiyb = find(YCb>-32,1);
% YCb = YCb(loyb:2:hiyb);

% loxb = find(XCb>289.99,2);
% hixb = find(XCb>350,2);
% loxb = loxb(2);
% hixb = hixb(2);
% XCb = XCb(loxb:2:hixb);
% loyb = find(YCb>-59.3,2);
% hiyb = find(YCb>-32,2);
% loyb = loyb(2);
% hiyb = hiyb(2);
% YCb = YCb(loyb:2:hiyb);


% [XC,XCb]
% [YC',YCb]
TFLUX = ncread(str,'TFLUX',[lox,loy,1],[361,243,1])

toc()
