



X = unifrnd(0,10,10,1);
Y = unifrnd(0,10,10,1);

points = [X';Y'];

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
plot(X,Y,'LineWidth',2.1)
hold on
fnplt(cscvn(points),'g',2.4)
points = fnplt(cscvn(points),'g',2.4);
scatter(points(1,end),points(2,end),200,'b','filled')
hold off




