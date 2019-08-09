%% Problem 1
close all; clear, clc
mae144_final_var
% mae144_final_2
G1=tf(k4*(sbar-Vb),[1 0 0]);
figure(1)
rlocus(G1)
[b1,a1]=tfdata(G1,'v');
G1z=roots(b1);
G1p=roots(a1);
Wlow=600;
Wg1=1.8/tD1;
y1notch=[1 0];
x1notch=1;
y1low=Wlow;
x1low=[1 Wlow];
D1notch=tf(y1notch,x1notch);
D1low=tf(y1low,x1low);
D1y=PolyConv(y1low,y1notch);
D1x=PolyConv(x1low,x1notch);
D1=tf(D1y,D1x);
% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)+K*b(s)*y(s)]
L1_num=PolyConv(D1y,b1);
L1_den=PolyConv(D1x,a1);
L1=tf(L1_num,L1_den);
% initial D2(s)
[mag_Wg10, phase_Wg10]=bode(L1,Wg1);  % [abs amplitute]
gain10=20*log10(mag_Wg10);          % [dB]
K1=10^((1-gain10)/20);
roots1=rlocus(L1,0);
poles1=rlocus(L1,K1);
% improved D2(s)
D11=K1*D1; % controller transfer function
[D11y,D11x]=tfdata(D11,'v');
L11_num=PolyConv(K1*D1y,b1);
L11_den=PolyConv(D1x,a1);
L11=tf(L11_num,L11_den); % open-loop transfer function
% sanity check
[mag_Wg1, phase_Wg1]=bode(L11,Wg1);  % [abs amplitute]
gain1=20*log10(mag_Wg1);           % [dB]
phase_Wg1;
% D1(s) bode
figure(2)
bode(D11)
title('D1(s) Bode')
% bode plots
figure(3)
bode(G1,'k--',D11,'r',...
    L11,'g-.',...
    D1notch,'m')
legend('G1(s)','D1(s)','L1(s)',...
    'D1Notch(s)','Location','Best')
title('Bodes')
% L1(s) root locus
figure(4)
rlocus(L1)
title('L1(s) Root Locus')
% closed-loop transfer function
T1_num=L11_num;
T1_den=PolyAdd(L11_num,L11_den);
T1=tf(T1_num,T1_den);
% step response
linearSystemAnalyzer('step',T1,0:tD1/1000:1)
% tustin's approx w/ prewarping
[b1z,a1z]=C2DTustin(D11y,D11x,tD1,Wg1); b1z_roots=Roots(b1z); a1z_roots=Roots(a1z); mag1=abs(a1z_roots);
% D1 discrete time
D1z=tf(b1z,a1z,tD1);
D1zNum=b1z/b1z(1)
D1zDen=a1z/b1z(1)
Dk1z0=tf(b1z,a1z,tD1,'Variable','z^-1');