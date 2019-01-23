close all
clear
clc
tic()
ACC_Colors

delY1= [0.069501, 0.069898, 0.070297, 0.070698, 0.071101, 0.071506, 0.071913, 0.072323, 0.072735, 0.073149,...
0.073565, 0.073984, 0.074404, 0.074828, 0.075253, 0.075681, 0.07611, 0.076543, 0.076977, 0.077414,...
0.077853, 0.078295, 0.078739, 0.079185, 0.079634, 0.080085, 0.080538, 0.080994, 0.081453, 0.081913,...
0.082377, 0.082842, 0.08331, 0.083781, 0.084254, 0.084729, 0.085207, 0.085688, 0.086171, 0.086656,...
0.087144, 0.087635, 0.088128, 0.088624, 0.089122, 0.089623, 0.090127, 0.090633, 0.091142, 0.091653,...
0.092167, 0.092683, 0.093203, 0.093725, 0.094249, 0.094777, 0.095307, 0.095839, 0.096375, 0.096913,...
0.097454, 0.097997, 0.098543, 0.099092, 0.099644, 0.1002, 0.10076, 0.10132, 0.10188, 0.10245,...
0.10301, 0.10358, 0.10416, 0.10474, 0.10532, 0.1059, 0.10648, 0.10707, 0.10766, 0.10826,...
0.10886, 0.10946, 0.11006, 0.11066, 0.11127, 0.11188, 0.1125, 0.11312, 0.11374, 0.11436,...
0.11499, 0.11562, 0.11625, 0.11688, 0.11752, 0.11816, 0.11881, 0.11946, 0.12011, 0.12076,...
0.12142, 0.12208, 0.12274, 0.1234, 0.12407, 0.12474, 0.12542, 0.12609, 0.12678, 0.12746,...
0.12815, 0.12884, 0.12953, 0.13022, 0.13092, 0.13163, 0.13233, 0.13304, 0.13375, 0.13446,...
0.13518, 0.1359, 0.13663, 0.13735, 0.13808, 0.13881, 0.13955, 0.14029, 0.14103, 0.14178,...
0.14252, 0.14327, 0.14403, 0.14479, 0.14555, 0.14631, 0.14708, 0.14785, 0.14862, 0.14939,...
0.15017, 0.15095, 0.15174, 0.15253, 0.15332, 0.15411, 0.15491, 0.15571, 0.15651, 0.15731,...
0.15812, 0.15893, 0.15975, 0.16056, 0.16138, 0.16221, 0.16303, 0.16386, 0.16469, 0.16553,...
0.16636, 0.1672, 0.16805, 0.16889, 0.16974, 0.17059, 0.17145, 0.1723, 0.17316, 0.17403,...
0.17489, 0.17576, 0.17663, 0.1775, 0.17838, 0.17925, 0.18013, 0.18102, 0.1819, 0.18279,...
0.18368, 0.18457, 0.18547, 0.18637, 0.18727, 0.18817, 0.18908, 0.18998, 0.19089, 0.1918,...
0.19272, 0.19363, 0.19455, 0.19547, 0.19639, 0.19732, 0.19824, 0.19917, 0.2001, 0.20103,...
0.20197, 0.2029, 0.20384, 0.20478, 0.20572, 0.20666, 0.20761, 0.20855, 0.2095, 0.21045,...
0.2114, 0.21235, 0.2133, 0.21426, 0.21521, 0.21617, 0.21713, 0.21809, 0.21905, 0.22001,...
0.22097, 0.22193, 0.2229, 0.22386, 0.22483, 0.22579, 0.22676, 0.22773, 0.22869, 0.22966,...
0.23063, 0.2316, 0.23257, 0.23354, 0.23451, 0.23548, 0.23645, 0.23742, 0.23839, 0.23936,...
0.24032, 0.24129, 0.24226, 0.24323, 0.2442, 0.24516, 0.24613, 0.2471, 0.24806, 0.24902,...
0.24999, 0.25095, 0.25191, 0.25287, 0.25382, 0.25478, 0.25574, 0.25669, 0.25764, 0.25859,...
0.25954, 0.26049, 0.26143, 0.26237, 0.26331, 0.26425, 0.26519, 0.26612, 0.26705, 0.26798,...
0.26891, 0.26983, 0.27075, 0.27167, 0.27258, 0.27349, 0.2744, 0.27531, 0.27621, 0.2771,...
0.278, 0.27889, 0.27978, 0.28066, 0.28154, 0.28241, 0.28328, 0.28415, 0.28501, 0.28587,...
0.28672, 0.28757, 0.28841, 0.31134, 0.37844, 0.45999, 0.55913, 0.67962, 0.82608, 1.0041,...
1.2205, 1.4835, 1.8189, 2, 2, 2, 2, 2, 2, 2,...
2, 2, 2, 2, 2];


% delY1= [0,0.16553,0.16636, 0.1672, 0.16805, 0.16889, 0.16974, 0.17059, 0.17145, 0.1723, 0.17316, 0.17403,...
% 0.17489, 0.17576, 0.17663, 0.1775, 0.17838, 0.17925, 0.18013, 0.18102, 0.1819, 0.18279,...
% 0.18368, 0.18457, 0.18547, 0.18637, 0.18727, 0.18817, 0.18908, 0.18998, 0.19089, 0.1918,...
% 0.19272, 0.19363, 0.19455, 0.19547, 0.19639, 0.19732, 0.19824, 0.19917, 0.2001, 0.20103,...
% 0.20197, 0.2029, 0.20384, 0.20478, 0.20572, 0.20666, 0.20761, 0.20855, 0.2095, 0.21045,...
% 0.2114, 0.21235, 0.2133, 0.21426, 0.21521, 0.21617, 0.21713, 0.21809, 0.21905, 0.22001,...
% 0.22097, 0.22193, 0.2229, 0.22386, 0.22483, 0.22579, 0.22676, 0.22773, 0.22869, 0.22966,...
% 0.23063, 0.2316, 0.23257, 0.23354, 0.23451, 0.23548, 0.23645, 0.23742, 0.23839, 0.23936,...
% 0.24032, 0.24129, 0.24226, 0.24323, 0.2442, 0.24516, 0.24613, 0.2471, 0.24806, 0.24902,...
% 0.24999, 0.25095, 0.25191, 0.25287, 0.25382, 0.25478, 0.25574, 0.25669, 0.25764, 0.25859,...
% 0.25954, 0.26049, 0.26143, 0.26237, 0.26331, 0.26425, 0.26519, 0.26612, 0.26705, 0.26798,...
% 0.26891, 0.26983, 0.27075, 0.27167, 0.27258, 0.27349, 0.2744, 0.27531, 0.27621, 0.2771,...
% 0.278, 0.27889, 0.27978, 0.28066, 0.28154, 0.28241, 0.28328, 0.28415, 0.28501, 0.28587,...
% 0.28672];
% 
% delY2 = [0,0.165946960449219,0.166778564453125,0.167625427246094,0.168468475341797,...
% 0.169315338134766,0.170166015625,0.1710205078125,0.171875,0.1727294921875,...
% 0.173595428466797,0.174461364746094,0.175323486328125,0.176197052001953,0.17706298828125,...
% 0.177940368652344,0.178813934326172,0.179691314697266,0.180576324462891,0.18145751953125,...
% 0.182346343994141,0.183235168457031,0.184123992919922,0.185020446777344,0.185920715332031,...
% 0.186817169189453,0.187721252441406,0.188625335693359,0.189529418945312,0.190437316894531,...
% 0.19134521484375,0.192256927490234,0.19317626953125,0.194091796875,0.19500732421875,...
% 0.195930480957031,0.196853637695312,0.197780609130859,0.198707580566406,0.199634552001953,...
% 0.200565338134766,0.201499938964844,0.202434539794922,0.203369140625,0.204311370849609,...
% 0.205249786376953,0.206188201904297,0.207134246826172,0.208080291748047,0.209026336669922,...
% 0.209976196289062,0.210922241210938,0.211875915527344,0.212825775146484,0.213779449462891,...
% 0.214736938476562,0.215686798095703,0.216651916503906,0.217609405517578,0.218570709228516,...
% 0.219528198242188,0.220493316650391,0.221446990966797,0.222415924072266,0.223381042480469,...
% 0.224342346191406,0.225311279296875,0.226276397705078,0.227245330810547,0.22821044921875,...
% 0.229171752929688,0.230148315429688,0.231113433837891,0.232086181640625,0.233055114746094,...
% 0.234024047851562,0.234992980957031,0.235965728759766,0.236934661865234,0.237907409667969,...
% 0.238872528076172,0.239841461181641,0.240806579589844,0.241771697998047,0.242748260498047,...
% 0.24371337890625,0.244678497314453,0.245647430419922,0.246612548828125,0.247581481933594,...
% 0.248538970947266,0.249504089355469,0.250473022460938,0.251430511474609,0.252388000488281,...
% 0.253345489501953,0.254299163818359,0.255260467529297,0.256214141845703,0.257167816162109,...
% 0.258113861083984,0.259063720703125,0.260017395019531,0.260959625244141,0.261898040771484,...
% 0.262840270996094,0.263778686523438,0.264720916748047,0.265655517578125,0.266586303710938,...
% 0.267513275146484,0.268444061279297,0.269371032714844,0.270290374755859,0.271209716796875,...
% 0.272125244140625,0.273036956787109,0.273944854736328,0.274852752685547,0.275760650634766,...
% 0.276653289794922,0.277549743652344,0.278446197509766,0.279335021972656,0.280220031738281,...
% 0.281101226806641,0.281974792480469,0.282844543457031,0.283714294433594,0.284580230712891,...
% 0.285440444946289,0.286294937133789,0.287145614624023];

YG = rdmds('YG');
YG = YG(469,:);
delY2 = YG(2:end)-YG(1:end-1);

YG(1:10)

Z1 = 2*ones(132,1);
Z2 = 1.1*Z1;

lb = 1;
ub = 20;
indices = lb:ub;

A = cumsum(delY1)-78;
B = cumsum(delY2)-78;

set(gcf, 'Position', [5, 5, 1280, 720])
h1 = plot(A(indices),Z1(indices),'.','MarkerSize',13,'Color',Color(:,9));
hold on
h2 = plot(B(indices),Z2(indices),'.','MarkerSize',13,'Color',Color(:,14));
axis([A(lb) A(ub+1) 0 4])
title('comparison of gridpoints 1-15')
legend([h1(1),h2(1)],'in SO3DiagBlng','in grid.nc')
hold off
print('comparison_grids_1','-djpeg')




