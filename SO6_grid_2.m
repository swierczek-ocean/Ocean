

XG = XG(:,end);
YG = YG(end,:);
XC = XC(:,end);
YC = YC(end,:);

lox = find(XG>288.6,1)-2;
hix = find(XG>351.58,1)+3;

loy = find(YG>-59.68,1)-1;
hiy = find(YG>-30.6,1)+2;



figure()
colormap(bone)
surf(-Depth(lox:hix,loy:hiy)')

YG6 = YG(loy:hiy);
XG6 = XG(lox:hix);
YC6 = YC(loy:hiy);
XC6 = XC(lox:hix);