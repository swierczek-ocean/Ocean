

X = [0,1];
Y = [0,1];
L = [X;Y];
L = L==1;

Z1 = [0,2;0,2];

Z2 = [NaN,2;NaN,2];

[X,Y] = ndgrid(X,Y);



F = griddedInterpolant(X,Y,Z1,'spline');
F(0.5,0.5)



F = griddedInterpolant(X,Y,Z2,'spline');
F(0.5,0.5)

Z2 = fillmissing(Z2,'constant',2)

F = griddedInterpolant(X,Y,Z2,'spline');
F(0.5,0.5)



% Q = randn(9,9);
% Q(1,1:4) = NaN;
% Q(2,1:3) = NaN;
% Q(3,1:2) = NaN;
% Q(4,1) = NaN;
% Q(8,9) = NaN;
% Q(9,8:9) = NaN;
% Q(5,5) = NaN;

format short g

% Q
% 
% Q = fillmissing(Q,'linear')


Q = [NaN,NaN,NaN,1,2;NaN,NaN,4,NaN,6;NaN,7,NaN,9,10;11,12,13,NaN,NaN;NaN,15,16,17,NaN]

fillmissingstan(Q)


Q = [NaN,NaN,NaN,1,2;NaN,NaN,4,5,6;NaN,7,8,9,10;11,12,13,14,NaN;NaN,15,16,17,NaN]

fillmissingstan(Q)

