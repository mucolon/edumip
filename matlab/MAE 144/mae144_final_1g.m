%% Problem 1
close all; clear, clc
mae144_final_var
G1=tf([-k17 k16],[1 0 k15]);
figure(1)
rlocus(G1)
[b1,a1]=tfdata(G1,'v');
G1z=roots(b1);
G1p=roots(a1);
% p1glead0=-600; % upper bound
Wg1=1.8/tD1;    % target D1 frequency [rad/s]
Wg2=1.8/tD2;  % target D2 frequency [rad/s]
% zeta1=.5;
% a1g1=-2*zeta1*Wg1;
% p1glag0=a1g1-p1glead0;
% if p1glag0>0
%     while p1glag0>0
%         p1glead0=p1glead0+0.1;
%         p1glag0=a1g1-p1glead0;
%         if p1glag0<0
%             p1glag=a1g1-p1glead0; % lower bound
%             p1glead=p1glead0;   % upper bound
%             break
%         end
%     end
% else
%     p1glag=p1glag0;
%     p1glead=p1glead0;
% end
% sqrt(pz)=Wg1
% z1glead=Wg1^2/p1glead;  % lower bound
% z1glag=p1glag*1.05;  % upper bound
% y1glead=[1 -z1glead];
% x1glead=[1 -p1glead];
% y1glag=[1 -z1glag];
% x1glag=[1 -p1glag];
% D1glead=tf(y1glead,x1glead);
% D1glag=tf(y1glag,x1glag);
% D1gy=PolyConv(y1glead,y1glag);
% D1gx=PolyConv(x1glead,x1glag);
D1y=[1 -G1p(2)];
D1x=[1 600];
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
poles1=rlocus(L1,K1)
% improved D2(s)
D11=K1*D1; % controller transfer function
[D11y,D11x]=tfdata(D11,'v');
L11_num=PolyConv(K1*D1y,b1);
L11_den=PolyConv(D1x,a1);
L11=tf(L11_num,L11_den); % open-loop transfer function
% sanity check
[mag_Wg1, phase_Wg1]=bode(L11,Wg1);  % [abs amplitute]
gain1=20*log10(mag_Wg1)           % [dB]
phase_Wg1;
[mag_Wg2, phase_Wg12]=bode(L11,Wg2);
gain12=20*log10(mag_Wg2)
phase_Wg12;
% D1(s) bode
figure(2)
bode(D11)
title('D1(s) Bode')
% bode plots
figure(3)
bode(...G1,'k--',D11,'r',...
    L11)
%     D1lead,'b',D1lag,'m')
% legend(...'G1(s)','D1(s)',
%     'L1(s)','Location','Best')
%     'D1Lead(s)','D1Lag(s)',
title('L1(s) Bode Plot')
% L1(s) root locus
figure(4)
rlocus(L1)
title('L1(s) Root Locus')
% closed-loop transfer function
T1_num=L11_num;
T1_den=PolyAdd(L11_num,L11_den);
T1=tf(T1_num,T1_den);
% step response
figure(5)
step(T1,0:tD1/1000:.1)
% linearSystemAnalyzer('step',T,0:DT/1000:1)
title('T1(s) Step Response')
% linearSystemAnalyzer('step',T1,0:tD1/1000:1)
% tustin's approx w/ prewarping
[b1z,a1z]=C2DTustin(D11y,D11x,tD1,Wg1); b1z_roots=Roots(b1z); a1z_roots=Roots(a1z); mag1=abs(a1z_roots);
% D1 discrete time
D1z=tf(b1z,a1z,tD1);
D1zNum=b1z/b1z(1)
D1zDen=a1z/b1z(1)
Dk1z0=tf(b1z,a1z,tD1,'Variable','z^-1');
% loading problem 2
mae144_final_2
