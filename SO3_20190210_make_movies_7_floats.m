
clear
close all
clc

tic()
acc_settings
load mask
load BGCObs
mask = permute(mask,[2,1,3]);

XC = rdmds('XC');
YC = rdmds('YC');
HC = rdmds('hFacC');
XC = XC(:,end);
YC = YC(end,:);

XC = XC(6:187);
YC = YC(6:127);
HC = HC(6:187,6:127,:);

coords = [ceil(XC(1)) floor(XC(end)) ceil(YC(1)) floor(YC(end))];
argo_depth = [10,33,52,58,69,78];
nn = 182;
mm = 122;

fn = unique(O2_Obs(:,101));
num_floats = length(fn);

cm = [Color(:,8)';Color(:,36)'];
bgccolor = Color(:,3)';
argocolor = Color(:,11)';
color_array = [Color(:,3)';Color(:,30)';Color(:,16)';Color(:,22)';Color(:,11)';Color(:,47)';...
    Color(:,39)';Color(:,7)';Color(:,32)';Color(:,13)';Color(:,9)';Color(:,10)';Color(:,33)'];

ub = 1.5;
lb = -0.05;
osz = 230;
sz = 140;
bsz = 2.2*sz;
obsz = 2.2*osz;
numdate = 736665;
swit = zeros(num_floats,1);
counter = zeros(num_floats,1);
time = numdate:(numdate+395);

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
contourf(XCm,YCm,mask(:,:,1))
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')

for jj=1:num_floats
    name = fn(jj);
    temp_Obs = O2_Obs(O2_Obs(:,101)==name,:);
    T = temp_Obs(:,1);
    swit(jj) = T(1);
    if T(1)==numdate
        X = temp_Obs(1,2);
        Y = temp_Obs(1,3);
        scatter(X,Y,obsz,'k','filled','d')
        scatter(X,Y,bsz,color_array(jj,:),'filled','d')
    end
end

caxis([lb ub])
axis(coords)
xtickformat('degrees')
ytickformat('degrees')
title('BGC Argo float profiles','FontWeight','Normal')
acc_movie
acc_plots
text(292,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',28,'Color','w')
hold off
set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('BGC_FLOATS_2017.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 14;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for jj=2:395
    numdate = numdate + 1;
    
    contourf(XCm,YCm,mask(:,:,1))
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    
    for ii=1:num_floats
        if swit(ii)<numdate
            name = fn(ii);
            temp_Obs = O2_Obs(O2_Obs(:,101)==name,:);
            T = temp_Obs(:,1);
            ind = find(T>numdate,1)-1;
            if isempty(ind)==1
                
                counter(ii) = counter(ii) + 1;
                continue
            end
            diff_days =  min(abs(numdate-T(ind)),abs(numdate-T(ind+1)));
            diff_days_2 = abs(numdate-T(ind+1));
            diff_days_3 = T(ind+1)-T(ind);
            if ind<10
                X = temp_Obs(1:ind+1,2);
                Y = temp_Obs(1:ind+1,3);
            else
                X = temp_Obs(ind-9:ind+1,2);
                Y = temp_Obs(ind-9:ind+1,3);
            end
            
            points = [X';Y'];
            % fnplt(cscvn(points(:,1:end-1)),'w',2.4)
            points = fnplt(cscvn(points));
            ind1 = find(points(1,:)==X(end-1));
            ind2 = find(points(1,:)==X(end));
            ind1 = ind1(end);
            ind2 = ind2(end);
            diff = ind2-ind1;
            sub = round(diff*diff_days_2/diff_days_3);
            % fnplt(cscvn(points(:,end-sub)),2.2,'w')
            plot(points(1,1:end-sub),points(2,1:end-sub),'LineWidth',2.8,'Color',color_array(ii,:))
            % plot(values(1,:),values(2,:),'LineWidth',2.2,'Color','w');
            % plot(X,Y,'LineWidth',2.1,'Color','w')
            if diff_days>3
                scatter(points(1,end-sub),points(2,end-sub),0.3*obsz,'k','filled','d')
                scatter(points(1,end-sub),points(2,end-sub),0.3*bsz,color_array(ii,:),'filled','d')
                text(points(1,end-sub),points(2,end-sub),[num2str(fn(ii)),'  '],'HorizontalAlignment','right','FontSize',16)
            elseif diff_days==3
                scatter(points(1,end-sub),points(2,end-sub),0.40*obsz,'k','filled','d')
                scatter(points(1,end-sub),points(2,end-sub),0.40*bsz,color_array(ii,:),'filled','d')     
                text(points(1,end-sub),points(2,end-sub),[num2str(fn(ii)),'  '],'HorizontalAlignment','right','FontSize',16)
            elseif diff_days==2
                scatter(points(1,end-sub),points(2,end-sub),0.60*obsz,'k','filled','d')
                scatter(points(1,end-sub),points(2,end-sub),0.60*bsz,color_array(ii,:),'filled','d')  
                text(points(1,end-sub),points(2,end-sub),[num2str(fn(ii)),'  '],'HorizontalAlignment','right','FontSize',16)
            elseif diff_days==1
                scatter(points(1,end-sub),points(2,end-sub),0.85*obsz,'k','filled','d')
                scatter(points(1,end-sub),points(2,end-sub),0.85*bsz,color_array(ii,:),'filled','d')   
                text(points(1,end-sub),points(2,end-sub),[num2str(fn(ii)),'  '],'HorizontalAlignment','right','FontSize',16)
            elseif diff_days==0
                scatter(points(1,end-sub),points(2,end-sub),obsz,'k','filled','d')
                scatter(points(1,end-sub),points(2,end-sub),bsz,color_array(ii,:),'filled','d')  
                text(points(1,end-sub),points(2,end-sub),[num2str(fn(ii)),'  '],'HorizontalAlignment','right','FontSize',16)
            end
        end
    end
    caxis([lb ub])
    axis(coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('BGC Argo float profiles','FontWeight','Normal')
    acc_movie
    
    text(292,-37.5,datestr(numdate,'yyyy mmm dd'),'FontSize',28,'Color','w')
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    hold off
end

close(vidObj)