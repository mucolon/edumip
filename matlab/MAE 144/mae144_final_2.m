%% Problem 2
close all; clear, clc
mae144_final_var
% mae144_final_1g
% G2(s)=b(s)/a(s)
b2=k*Vb*GR/(R*Iw);
a2=[1 k^2*GR^2/(R*Iw) 0];
pG2=-a2(2);
G2=tf(b2,a2);
% D2(s)=K*y(s)/x(s)
% D2_lead=(s+z)/(s+p)    z<p
% D2_lag=(s+z)/(s+p)    p<z
p2lead0=-50; % upper bound
Wg2=1.8/tD2;  % target D2 frequency [rad/s]
zeta2=.695;
a21=-2*zeta2*Wg2;
p2lag0=a21-p2lead0;
if p2lag0 > 0
    while p2lag0>0
        p2lead0=p2lead0+0.1;
        p2lag0=a21-p2lead0;
        if p2lag0<0
            p2lag=a21-p2lead0; % lower bound
            p2lead=p2lead0;   % upper bound
            break
        end
    end
else
    p2lag=p2lag0;
    p2lead=p2lead0;
end
% sqrt(pz)=Wg2
z2lead=Wg2^2/p2lead;  % lower bound
z2lag=p2lag*1.05;  % upper bound pG2-pG2/1.19;
y2lead=[1 -z2lead];
x2lead=[1 -p2lead];
y2lag=[1 -z2lag];
x2lag=[1 -p2lag];
D2lead=tf(y2lead,x2lead);
D2lag=tf(y2lag,x2lag);
D2y=PolyConv(y2lead,y2lag);
D2x=PolyConv(x2lead,x2lag);
D2=tf(D2y,D2x);

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)]
L2_num=PolyConv(D2y,b2);
L2_den=PolyConv(D2x,a2);
L2=tf(L2_num,L2_den);

% initial D2(s)
[mag_Wg20, phase_Wg20]=bode(L2,Wg2);  % [abs amplitute]
gain20=20*log10(mag_Wg20);          % [dB]
K2=10^((1-gain20)/20);
roots2=rlocus(L2,0);
poles2=rlocus(L2,K2);

% improved D2(s)
D21=K2*D2; % controller transfer function
[D21y,D21x]=tfdata(D21,'v');

% L2(s)
L21_num=PolyConv(K2*D2y,b2);
L21_den=PolyConv(D2x,a2);
L21=tf(L21_num,L21_den);
% L21=L21*T1;
% [L2t1n,L2t1d]=tfdata(L21,'v');

% sanity check
[mag_Wg2, phase_Wg2]=bode(L21,Wg2);  % [abs amplitute]
gain2=20*log10(mag_Wg2)           % [dB]
phase_Wg2;
% [mag_Wg12, phase_Wg1]=bode(L21,Wg1);  % [abs amplitute]
% gain21=20*log10(mag_Wg1)           % [dB]
% poles21=rlocus(L21,K2)

% D2(s) bode
figure(6)
bode(D21)
title('D2(s) Bode')

% bode plots
figure(7)
bode(...G2,'k--',D21,'r',...
    L21)%...,'g-.',D2lead,'b',D2lag,'m')
% legend('L2(s)')%...'G2(s)','D2(s)',
%     'L2(s)')...,'D2Lead(s)','D2Lag(s)','Location','Best')
title('L2(s) Bode Plot')

% L2(s) root locus
figure(8)
rlocus(L21)
title('L2(s) Root Locus')

% closed-loop transfer function w/o L1(s)
T2_num=L21_num;
T2_den=PolyAdd(L21_num,L21_den);
T2=tf(T2_num,T2_den);
% % closed-loop transfer function w/ L1(s)
% T12num=L2t1n;
% T12den=PolyAdd(L2t1n,L2t1d);
% T12=tf(T12num,T12den);

% step response
figure(9)
step(T2,0:tD2/1000:1)
title('T2(s) Step Response')

% figure(10)
% step(T12,0:tD2/1000:1)
% title('T12(s) Step Response')
% linearSystemAnalyzer('step',T2,0:tD2/1000:1)    % assuming gain of 1 in inner loop
% linearSystemAnalyzer('step',T12,0:tD2/1000:1)   % gain of 1 in inner loop

% tustin's approx w/ prewarping
[b2z,a2z]=C2DTustin(D21y,D21x,tD2,Wg2); b2z_roots=Roots(b2z); a2z_roots=Roots(a2z); mag2=abs(a2z_roots);

% D2 discrete time
D2z=tf(b2z,a2z,tD2);
D2zNum=b2z/b2z(1)
D2zDen=a2z/b2z(1)