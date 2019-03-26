close all
clear
clc

tic()

acc_settings

depth = [20,30,40,60,90,130,180,250,350,500,750,1000,1500];
depth2 = [30,60,90,130,180,250,350,500,750,1000,1500];

load Obs_20
load Obs_30
load Obs_40
load Obs_60
load Obs_90
load Obs_130
load Obs_180
load Obs_250
load Obs_350
load Obs_500
load Obs_750
load Obs_1000
load Obs_1500

theta_ts = zeros(13,396);
salt_ts = zeros(13,396);
numdate = 736665;

for jj=1:396
    theta_ts(:,jj) = [Obs_20(jj,4);Obs_30(jj,4);Obs_40(jj,4);Obs_60(jj,4);...
        Obs_90(jj,4);Obs_130(jj,4);Obs_180(jj,4);Obs_250(jj,4);...
        Obs_350(jj,4);Obs_500(jj,4);Obs_750(jj,4);Obs_1000(jj,4);Obs_1500(jj,4)];
    salt_ts(:,jj) = [Obs_20(jj,5);Obs_30(jj,5);Obs_40(jj,5);Obs_60(jj,5);...
        Obs_90(jj,5);Obs_130(jj,5);Obs_180(jj,5);Obs_250(jj,5);...
        Obs_350(jj,5);Obs_500(jj,5);Obs_750(jj,5);Obs_1000(jj,5);Obs_1500(jj,5)];
end

lbt = min(min(theta_ts));
ubt = max(max(theta_ts));
lbs = min(min(salt_ts));
ubs = max(max(salt_ts));
tlim = [lbt-1 ubt+1];
slim = [lbs-1 ubs+1];

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
subplot(1,2,1);
plot(theta_ts(:,1),depth,'LineWidth',2.2,'Color',Color(:,11))
hold on
plot(theta_ts(:,1),depth,'o','MarkerSize',8,'Color',Color(:,11))
plot(theta_ts(:,1),depth,'o','MarkerSize',7,'Color',Color(:,11))
plot(theta_ts(:,1),depth,'o','MarkerSize',6,'Color',Color(:,11))
xlim(tlim)
yticks(depth2)
grid on
xlabel('Celsius')
title(['potential temperature vs. depth on ',datestr(numdate,'yyyy mmm dd')],'FontWeight','Normal')
acc_movie
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1)-0.035;
bottom = outerpos(2) + ti(2)+0.02;
ax_width = outerpos(3) + 0.06;
ax_height = outerpos(4) - ti(2) - ti(4) - 0.03;
ax.Position = [left bottom ax_width ax_height];
set(gca,'YDir','reverse');
hold off

subplot(1,2,2);
plot(salt_ts(:,1),depth,'LineWidth',2.2,'Color',Color(:,9))
hold on
plot(salt_ts(:,1),depth,'o','MarkerSize',8,'Color',Color(:,9))
plot(salt_ts(:,1),depth,'o','MarkerSize',7,'Color',Color(:,9))
plot(salt_ts(:,1),depth,'o','MarkerSize',6,'Color',Color(:,9))
xlim(slim)
yticks(depth2)
grid on
xlabel('psu')
title(['practical salinity vs. depth on ',datestr(numdate,'yyyy mmm dd')],'FontWeight','Normal')
acc_movie
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1);
bottom = outerpos(2) + ti(2)+0.02;
ax_width = outerpos(3) + 0.03;
ax_height = outerpos(4) - ti(2) - ti(4) - 0.03;
ax.Position = [left bottom ax_width ax_height];
set(gca,'YDir','reverse');
hold off

set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('THETA_SALT_PROF.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 12;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:396
    numdate = numdate + 1;

    
    subplot(1,2,1);
    plot(theta_ts(:,ii),depth,'LineWidth',2.2,'Color',Color(:,11))
    hold on
    plot(theta_ts(:,ii),depth,'o','MarkerSize',8,'Color',Color(:,11))
    plot(theta_ts(:,ii),depth,'o','MarkerSize',7,'Color',Color(:,11))
    plot(theta_ts(:,ii),depth,'o','MarkerSize',6,'Color',Color(:,11))
    xlim(tlim)
    yticks(depth2)
    grid on
    xlabel('Celsius')
    title(['potential temperature vs. depth on ',datestr(numdate,'yyyy mmm dd')],'FontWeight','Normal')
    acc_movie
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.035;
    bottom = outerpos(2) + ti(2)+0.02;
    ax_width = outerpos(3) + 0.06;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.03;
    ax.Position = [left bottom ax_width ax_height];
    set(gca,'YDir','reverse');
    hold off
    
    subplot(1,2,2);
    plot(salt_ts(:,ii),depth,'LineWidth',2.2,'Color',Color(:,9))
    hold on
    plot(salt_ts(:,ii),depth,'o','MarkerSize',8,'Color',Color(:,9))
    plot(salt_ts(:,ii),depth,'o','MarkerSize',7,'Color',Color(:,9))
    plot(salt_ts(:,ii),depth,'o','MarkerSize',6,'Color',Color(:,9))
    xlim(slim)
    yticks(depth2)
    grid on
    xlabel('psu')
    title(['practical salinity vs. depth on ',datestr(numdate,'yyyy mmm dd')],'FontWeight','Normal')
    acc_movie
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1);
    bottom = outerpos(2) + ti(2)+0.02;
    ax_width = outerpos(3) + 0.03;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.03;
    ax.Position = [left bottom ax_width ax_height];
    set(gca,'YDir','reverse');
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);
close all



















toc()
