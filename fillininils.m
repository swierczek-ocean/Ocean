%Smooth a 2D field with a gaussian filter
%Matt Mazloff
%November 2005
% it can handle nans
%and can also jst do special regions

function Qout = fillininils(nlong,nlat,Q,siz,std)

%Smooth2Dfnc(nlong,nlat,long,lat,Q,overlap)

%Make gaussian filter

%siz = [7 7];%[5 5]; %MUST BE ODD!!!!!!
%std = 1.5%.67; 

[x,y] = meshgrid(-(siz(2)-1)/2:(siz(2)-1)/2, -(siz(1)-1)/2:(siz(1)-1)/2);
h = exp(-(x.*x + y.*y)/(2*std*std));
h = h/sum(h(:));

% figure(1)
% contourf(h); colorbar; grid on
% h

    iext = (siz(1)-1)/2;
    jext = (siz(2)-1)/2;
    Qol = zeros(nlong+2*iext,nlat+2*jext);
    Qol(iext+1:nlong+iext,jext+1:nlat+jext)=Q;
    %make overlap
    Qol(1:iext,jext+1:nlat+jext)= Q(nlong-iext+1:nlong,:);
    Qol(nlong+iext+1:nlong+2*iext,jext+1:nlat+jext)= Q(1:iext,:);
    
    Qol(:,1:jext)= zeros(size(Qol(:,1:jext)));  
    Qol(:,nlat+jext+1:nlat+2*jext)=  zeros(size(Qol(:,nlat+jext+1:nlat+2*jext)));
    br = zeros(siz);
    Qout = zeros([nlong,nlat]);
    Qout = Q;
    
%NOW find zeros
[I,J] = find(Qol == 0);

%don't worry about zeros in overlap regions
tempi = I; tempj = J;
tempj((I<iext+1) | (I > nlong+iext) | (J<jext+1) | (J > nlat+jext)) = [];
tempi((I<iext+1) | (I > nlong+iext) | (J<jext+1) | (J > nlat+jext)) = [];
J = tempj; 
I = tempi; clear tempi tempj

N = length(I);

% size(Qol)
% min(I)
% max(I)
% min(J)
% max(J)

for k = 1:N
    br = Qol(I(k)-iext:I(k)+iext,J(k)-jext:J(k)+jext).*h;
    num = sum(br(:));
    den = sum(h(br~=0));
    if den>0
        Qout(I(k)-iext,J(k)-jext) = num./den;    
    end
end

return







