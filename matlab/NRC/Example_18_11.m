% script Example_18_11

clear; bs=[1]; as=[1 6 5]; h=.2; g.T=2;
[bz,az]=C2Dzoh(bs,as,h), m=length(bz)-1, n=length(az)-1

ell=n-m, yz=az, xz=PolyConv(bz,[1 zeros(1,ell-1) -1]),
g.t='Minimal-prototype deadbeat controller of stable plant';
figure(1), ResponseTFripple(bs,as,yz,xz,h,1,g), print -depsc MinimalTimeDeadbeat.eps

% end script Example_18_11