
clear
close all
clc

tic()

str = 'bsose_i122_2013to2017_monthly_SSH.nc';

% ncdisp(str);

XCb = ncread(str,'XC');
YCb = ncread(str,'YC');
n = 363;
m = 244;
z = 52;

XC = rdmds('XC');
YC = rdmds('YC');
HC = rdmds('hFacC');
HS = rdmds('hFacS');
HW = rdmds('hFacW');
XC = XC(:,end);
YC = YC(end,:);
lox = find(XC>289.99,1);
hix = find(XC>350,1)+1;
loy = find(YC>-59.3,1)-1;
hiy = find(YC>-32,1)-1;
% XC(1)
% XC(end)
XC = XC(lox:hix);
% XC(1)
% XC(end)
% YC(1)
% YC(end)
YC = YC(loy:hiy);
% YC(1)
% YC(end)
[XC,YC] = meshgrid(XC,YC);

loxb = find(XCb>289.99,1)-1;
hixb = find(XCb>350,1)+1;
loyb = find(YCb>-59.3,1);
hiyb = find(YCb>-32,1)+1;
XCb = XCb(loxb:hixb);
% XCb(1)
% XCb(end)
YCb = YCb(loyb:hiyb);
% YCb(1)
% YCb(end)
[XCb,YCb] = meshgrid(XCb,YCb);

XCb = XCb';
YCb = YCb';
XC = XC';
YC = YC';

nn = 192;
mm = 132;
zz = 52;

%% Theta

fid = fopen('THETA_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
% contourf(U(:,:,1),100)
fclose(fid);
THETA = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    THETA(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    THETA(ii,6:127,:) = THETA(6,6:127,:); 
    THETA(6:187,ii,:) = THETA(6:187,6,:);
    THETA(187+ii,6:127,:) = THETA(187,6:127,:); 
    THETA(6:187,127+ii,:) = THETA(6:187,127,:);
end

figure()
contourf(THETA(:,:,3)',100)

Logic = THETA==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of theta mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(THETA(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                THETA(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    THETA(ii,6:127,:) = THETA(6,6:127,:); 
    THETA(6:187,ii,:) = THETA(6:187,6,:);
    THETA(187+ii,6:127,:) = THETA(187,6:127,:); 
    THETA(6:187,127+ii,:) = THETA(6:187,127,:);
end

figure()
contourf(THETA(:,:,3)',100)
counter

fid = fopen('THETA_init_restr_20161216.bin','w','b');
fwrite(fid,THETA,'single');
fclose(fid);

clear THETA

%% Theta

%% Salt

fid = fopen('SALT_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
SALT = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    SALT(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    SALT(ii,6:127,:) = SALT(6,6:127,:); 
    SALT(6:187,ii,:) = SALT(6:187,6,:);
    SALT(187+ii,6:127,:) = SALT(187,6:127,:); 
    SALT(6:187,127+ii,:) = SALT(6:187,127,:);
end

Logic = SALT==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of salt mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(SALT(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                SALT(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    SALT(ii,6:127,:) = SALT(6,6:127,:); 
    SALT(6:187,ii,:) = SALT(6:187,6,:);
    SALT(187+ii,6:127,:) = SALT(187,6:127,:); 
    SALT(6:187,127+ii,:) = SALT(6:187,127,:);
end

figure()
contourf(SALT(:,:,3)',100)
counter

fid = fopen('SALT_init_restr_20161216.bin','w','b');
fwrite(fid,SALT,'single');
fclose(fid);

clear SALT

%% Salt

%% Uvel

fid = fopen('UVEL_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
UVEL = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    UVEL(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    UVEL(ii,6:127,:) = UVEL(6,6:127,:); 
    UVEL(6:187,ii,:) = UVEL(6:187,6,:);
    UVEL(187+ii,6:127,:) = UVEL(187,6:127,:); 
    UVEL(6:187,127+ii,:) = UVEL(6:187,127,:);
end

% figure()
% contourf(UVEL(:,:,3)',100)

% Logic = UVEL==0&HC~=0;
% 
% num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
% fprintf('number of uvel mistakes = %g \n',num_mistakes)
% counter = 0;
% 
% for ii=6:187
%     for jj=6:127
%         for kk=1:zz
%             if Logic(ii,jj,kk)==1
%                 temp_sum_1 = sum(sum(sum(UVEL(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
%                 if temp_sum_1==0
%                    return
%                 end
%                 UVEL(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
%                 counter = counter + 1;
%             end
%         end
%     end
% end
% 
% 
% for ii=1:5
%     UVEL(ii,6:127,:) = UVEL(6,6:127,:); 
%     UVEL(6:187,ii,:) = UVEL(6:187,6,:);
%     UVEL(187+ii,6:127,:) = UVEL(187,6:127,:); 
%     UVEL(6:187,127+ii,:) = UVEL(6:187,127,:);
% end
% 
% figure()
% contourf(UVEL(:,:,3)',100)
% counter

fid = fopen('UVEL_init_restr_20161216.bin','w','b');
fwrite(fid,UVEL,'single');
fclose(fid);

clear UVEL

%% Uvel

%% Vvel

fid = fopen('VVEL_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
VVEL = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    VVEL(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    VVEL(ii,6:127,:) = VVEL(6,6:127,:); 
    VVEL(6:187,ii,:) = VVEL(6:187,6,:);
    VVEL(187+ii,6:127,:) = VVEL(187,6:127,:); 
    VVEL(6:187,127+ii,:) = VVEL(6:187,127,:);
end


% figure()
% contourf(VVEL(:,:,3)',100)
% 
% Logic = VVEL==0&HC~=0;
% 
% num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
% fprintf('number of vvel mistakes = %g \n',num_mistakes)
% counter = 0;
% 
% for ii=6:187
%     for jj=6:127
%         for kk=1:zz
%             if Logic(ii,jj,kk)==1
%                 temp_sum_1 = sum(sum(sum(VVEL(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
%                 if temp_sum_1==0
%                    return
%                 end
%                 VVEL(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
%                 counter = counter + 1;
%             end
%         end
%     end
% end
% 
% 
% for ii=1:5
%     VVEL(ii,6:127,:) = VVEL(6,6:127,:); 
%     VVEL(6:187,ii,:) = VVEL(6:187,6,:);
%     VVEL(187+ii,6:127,:) = VVEL(187,6:127,:); 
%     VVEL(6:187,127+ii,:) = VVEL(6:187,127,:);
% end
% 
% figure()
% contourf(VVEL(:,:,3)',100)
% counter

fid = fopen('VVEL_init_restr_20161216.bin','w','b');
fwrite(fid,VVEL,'single');
fclose(fid);

clear VVEL

%% Vvel

%% DIC

fid = fopen('DIC_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
DIC = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    DIC(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    DIC(ii,6:127,:) = DIC(6,6:127,:); 
    DIC(6:187,ii,:) = DIC(6:187,6,:);
    DIC(187+ii,6:127,:) = DIC(187,6:127,:); 
    DIC(6:187,127+ii,:) = DIC(6:187,127,:);
end

figure()
contourf(DIC(:,:,3)',100)

Logic = DIC==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of dic mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(DIC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                DIC(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    DIC(ii,6:127,:) = DIC(6,6:127,:); 
    DIC(6:187,ii,:) = DIC(6:187,6,:);
    DIC(187+ii,6:127,:) = DIC(187,6:127,:); 
    DIC(6:187,127+ii,:) = DIC(6:187,127,:);
end

figure()
contourf(DIC(:,:,3)',100)
counter

fid = fopen('DIC_init_restr_20161216.bin','w','b');
fwrite(fid,DIC,'single');
fclose(fid);

clear DIC

%% DIC

%% Alk

fid = fopen('Alk_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
Alk = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    Alk(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    Alk(ii,6:127,:) = Alk(6,6:127,:); 
    Alk(6:187,ii,:) = Alk(6:187,6,:);
    Alk(187+ii,6:127,:) = Alk(187,6:127,:); 
    Alk(6:187,127+ii,:) = Alk(6:187,127,:);
end

figure()
contourf(Alk(:,:,3)',100)

Logic = Alk==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of alk mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(Alk(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                Alk(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    Alk(ii,6:127,:) = Alk(6,6:127,:); 
    Alk(6:187,ii,:) = Alk(6:187,6,:);
    Alk(187+ii,6:127,:) = Alk(187,6:127,:); 
    Alk(6:187,127+ii,:) = Alk(6:187,127,:);
end

figure()
contourf(Alk(:,:,3)',100)
counter

fid = fopen('Alk_init_restr_20161216.bin','w','b');
fwrite(fid,Alk,'single');
fclose(fid);

clear Alk

%% Alk

%% O2

fid = fopen('O2_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
O2 = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    O2(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    O2(ii,6:127,:) = O2(6,6:127,:); 
    O2(6:187,ii,:) = O2(6:187,6,:);
    O2(187+ii,6:127,:) = O2(187,6:127,:); 
    O2(6:187,127+ii,:) = O2(6:187,127,:);
end

figure()
contourf(O2(:,:,3)',100)

Logic = O2==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of o2 mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(O2(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                O2(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    O2(ii,6:127,:) = O2(6,6:127,:); 
    O2(6:187,ii,:) = O2(6:187,6,:);
    O2(187+ii,6:127,:) = O2(187,6:127,:); 
    O2(6:187,127+ii,:) = O2(6:187,127,:);
end

figure()
contourf(O2(:,:,3)',100)
counter

fid = fopen('O2_init_restr_20161216.bin','w','b');
fwrite(fid,O2,'single');
fclose(fid);

clear O2

%% O2

%% NO3

fid = fopen('NO3_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
NO3 = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    NO3(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    NO3(ii,6:127,:) = NO3(6,6:127,:); 
    NO3(6:187,ii,:) = NO3(6:187,6,:);
    NO3(187+ii,6:127,:) = NO3(187,6:127,:); 
    NO3(6:187,127+ii,:) = NO3(6:187,127,:);
end

figure()
contourf(NO3(:,:,3)',100)

Logic = NO3==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of no3 mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(NO3(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                NO3(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    NO3(ii,6:127,:) = NO3(6,6:127,:); 
    NO3(6:187,ii,:) = NO3(6:187,6,:);
    NO3(187+ii,6:127,:) = NO3(187,6:127,:); 
    NO3(6:187,127+ii,:) = NO3(6:187,127,:);
end

figure()
contourf(NO3(:,:,3)',100)
counter

fid = fopen('NO3_init_restr_20161216.bin','w','b');
fwrite(fid,NO3,'single');
fclose(fid);

clear NO3

%% NO3

%% PO4

fid = fopen('PO4_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
PO4 = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    PO4(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    PO4(ii,6:127,:) = PO4(6,6:127,:); 
    PO4(6:187,ii,:) = PO4(6:187,6,:);
    PO4(187+ii,6:127,:) = PO4(187,6:127,:); 
    PO4(6:187,127+ii,:) = PO4(6:187,127,:);
end

figure()
contourf(PO4(:,:,3)',100)

Logic = PO4==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of po4 mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(PO4(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                PO4(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    PO4(ii,6:127,:) = PO4(6,6:127,:); 
    PO4(6:187,ii,:) = PO4(6:187,6,:);
    PO4(187+ii,6:127,:) = PO4(187,6:127,:); 
    PO4(6:187,127+ii,:) = PO4(6:187,127,:);
end

figure()
contourf(PO4(:,:,3)',100)
counter

fid = fopen('PO4_init_restr_20161216.bin','w','b');
fwrite(fid,PO4,'single');
fclose(fid);

clear PO4

%% PO4

%% Fe

fid = fopen('Fe_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
Fe = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    Fe(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    Fe(ii,6:127,:) = Fe(6,6:127,:); 
    Fe(6:187,ii,:) = Fe(6:187,6,:);
    Fe(187+ii,6:127,:) = Fe(187,6:127,:); 
    Fe(6:187,127+ii,:) = Fe(6:187,127,:);
end

figure()
contourf(Fe(:,:,3)',100)

Logic = Fe==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of fe mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(Fe(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                Fe(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    Fe(ii,6:127,:) = Fe(6,6:127,:); 
    Fe(6:187,ii,:) = Fe(6:187,6,:);
    Fe(187+ii,6:127,:) = Fe(187,6:127,:); 
    Fe(6:187,127+ii,:) = Fe(6:187,127,:);
end

figure()
contourf(Fe(:,:,3)',100)
counter

fid = fopen('Fe_init_restr_20161216.bin','w','b');
fwrite(fid,Fe,'single');
fclose(fid);

clear Fe

%% Fe

%% DON

fid = fopen('DON_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
DON = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    DON(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    DON(ii,6:127,:) = DON(6,6:127,:); 
    DON(6:187,ii,:) = DON(6:187,6,:);
    DON(187+ii,6:127,:) = DON(187,6:127,:); 
    DON(6:187,127+ii,:) = DON(6:187,127,:);
end

figure()
contourf(DON(:,:,3)',100)

Logic = DON==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of don mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(DON(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                DON(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    DON(ii,6:127,:) = DON(6,6:127,:); 
    DON(6:187,ii,:) = DON(6:187,6,:);
    DON(187+ii,6:127,:) = DON(187,6:127,:); 
    DON(6:187,127+ii,:) = DON(6:187,127,:);
end

figure()
contourf(DON(:,:,3)',100)
counter


fid = fopen('DON_init_restr_20161216.bin','w','b');
fwrite(fid,DON,'single');
fclose(fid);

clear DON

%% DON


%% DOP

fid = fopen('DOP_init_restr_20161216.bin','r','b');
U = fread(fid,inf,'single');
U = reshape(U,[n,m,z]);
fclose(fid);
DOP = zeros(192,132,52);

for jj=1:z
    F = griddedInterpolant(XCb,YCb,U(:,:,jj));
    DOP(6:187,6:127,jj) = F(XC,YC); 
end

for ii=1:5
    DOP(ii,6:127,:) = DOP(6,6:127,:); 
    DOP(6:187,ii,:) = DOP(6:187,6,:);
    DOP(187+ii,6:127,:) = DOP(187,6:127,:); 
    DOP(6:187,127+ii,:) = DOP(6:187,127,:);
end

figure()
contourf(DOP(:,:,3)',100)

Logic = DOP==0&HC~=0;

num_mistakes = sum(reshape(Logic,[nn*mm*zz,1]));
fprintf('number of dop mistakes = %g \n',num_mistakes)
counter = 0;

for ii=6:187
    for jj=6:127
        for kk=1:zz
            if Logic(ii,jj,kk)==1
                temp_sum_1 = sum(sum(sum(DOP(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1).*HC(ii-1:ii+1,jj-1:jj+1,kk-1:kk+1))));
                if temp_sum_1==0
                   return
                end
                DOP(ii,jj,kk) = temp_sum_1/(sum(sum(HC(ii-1:ii+1,jj-1:jj+1,kk))));
                counter = counter + 1;
            end
        end
    end
end


for ii=1:5
    DOP(ii,6:127,:) = DOP(6,6:127,:); 
    DOP(6:187,ii,:) = DOP(6:187,6,:);
    DOP(187+ii,6:127,:) = DOP(187,6:127,:); 
    DOP(6:187,127+ii,:) = DOP(6:187,127,:);
end

figure()
contourf(DOP(:,:,3)',100)
counter

fid = fopen('DOP_init_restr_20161216.bin','w','b');
fwrite(fid,DOP,'single');
fclose(fid);

clear DOP

%% DOP






toc()