% script Example_18_13

clear; bs=[1]; as=[1 -6 5]; h=.2; g.T=2;
[bz,az]=C2Dzoh(bs,as,h), m=length(bz)-1, n=length(az)-1

ell=2*n-1, [xz,yz]=Diophantine(az,bz,[1 zeros(1,ell)]), gz=sum(PolyConv(bz,yz))
g.t='Ripple-free deadbeat controller of unstable plant';
figure(3), ResponseTFripple(bs,as,yz,xz,h,1/gz,g), print -depsc GeneralDeadbeat.eps

% end script Example_18_13