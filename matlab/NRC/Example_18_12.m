% script Example_18_12

clear; bs=[1]; as=[1 6 5]; h=.2; g.T=2;
[bz,az]=C2Dzoh(bs,as,h), m=length(bz)-1, n=length(az)-1

ell=n, s=sum(bz); yz=az/s, xz=PolyAdd([1 zeros(1,ell)],-bz/s)
g.t='Ripple-free deadbeat controller of stable plant';
figure(2), ResponseTFripple(bs,as,yz,xz,h,1,g), print -depsc RippleFreeDeadbeat.eps

% end script Example_18_12
