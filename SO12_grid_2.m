

XG = XG(:,end);
YG = YG(end,:);
XC = XC(:,end);
YC = YC(end,:);

lox = find(XG>288.6,1);
hix = find(XG>351.58,1);

loy = find(YG>-59.68,1);
hiy = find(YG>-30.6,1);



figure()
colormap(bone)
surf(-Depth(lox:hix,loy:hiy)')

YG12 = YG(loy:hiy);
XG12 = XG(lox:hix);
YC12 = YC(loy:hiy);
XC12 = XC(lox:hix);