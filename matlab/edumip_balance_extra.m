%% Variables
close all; clear, clc
Vb=7.4;     % nominal voltage [V]
Wf=1760;    % motor free run speed [rad/s]
sbar=0.003; % stall torque @ Vb [N*m]
G=35.56;    % gearbox ratio
Ww=Wf/G;    % max wheel speed [rad/s] ~ 50
Im=3.6e-8;  % motor armature inertia [kg*m^2]
r=34e-3;    % wheel radius [m]
Mw=27e-3;   % wheel mass [kg]
Mb=180e-3;  % MiP body mass [kg]
l=47.7e-3;  % center of MiP mass to wheel axle [m]
Ib=2.63e-4; % MiP body inertia [kg*m^2]
g=9.80665;  % gravitational accel [m^2/s]
k=Vb/Wf;    % motor constant [V*s = N*m/A]
Iw=(1/2)*Mw*r^2+Im*G^2;   % wheel inertia [kg*m^2]
R=k*Vb/sbar;    % motor resistance [ohm]
s=zpk(0,[],1);

freq1=200;  % inner loop frequency [Hz] 
freq2=20;   % outer loop frequency [Hz]
t1=1/freq1; % inner loop period [s]
t2=1/freq2; % outer loop period [s]

%% Inner Loop
G1=-74.1*s/(s^3+34.7*s^2-128.4*s-1555.4);
[G1z,G1p,G1k]=zpkdata(G1,'v');
[b1,a1]=tfdata(G1,'v'); % polynomial form
G1_num=zpk(tf(b1,1));   % zpk form
G1_den=zpk(tf(a1,1));

% G1(s) root locus
figure(1)
rlocus(G1)
title('G1(s)')
rootsG1=rlocus(G1,0);
polesG1=rlocus(G1/G1k,G1k);

% G1mod = -s/((s-polesG1(1))*(s-polesG1(2))*(s-polesG1(3)));
% figure(2)
% rlocus(-G1mod)
% title('G1(s) modified with its gain')

% sigma1=4.6/t2;
% zeta1=1;
% Wg1=sigma1/zeta1;
% Wg1=1.8/t1;
% a11=2*zeta1*Wg1;
% sig2=-2*sigma1;
% p1lead=sig2;

% p1lead0=-300; % upper bound
% p1lag0=sig2-p1lead0;
% if p1lag0 > 0
%     while p1lag0>0
%         p1lead0=p1lead0+0.1;
%         p1lag0=sig2-p1lead0;
%         if p1lag0<0
%             p1lag=sig2-p1lead0; % lower bound
%             p1lead=p1lead0;   % upper bound
%             break
%         end
%     end
% else
%     p1lag=p1lag0;
%     p1lead=p1lead0;
% end

% sqrt(pz)=Wg
% z1lead=rootsG1(3);
% p1lead=Wg1^2/z1lead;
% z1lead=Wg1^2/p1lead;  % lower bound
% z1lead=rootsG1(3);
% if z1lead < p1lead
%     disp('ERROR: D1lead is not behaving as intended.')
%     pause
% end
% p1lag=0;
% z1lag=1.1*p1lag;
p1lag=G1z;
z1lag=rootsG1(1);
% z1lag=z1lead-0.7*z1lead;  % upper bound
z1lead=rootsG1(3);
p1lead=-1840-rootsG1(2);%-Ww;
D1lead=(s-z1lead)/(s-p1lead);
D1lag=(s-z1lag)/(s-p1lag);
D1=D1lag*D1lead;%*D1zeros*D1low^2*(1200/(s+1200));
[y1,x1]=tfdata(D1,'v'); % polynomial form
D1_num=zpk(tf(y1,1));   % zpk form
D1_den=zpk(tf(x1,1));

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)]
L1_num=D1_num*G1_num/G1k;
L1_den=D1_den*G1_den;
L1=minreal(L1_num/L1_den);
[L1z,L1p,~]=zpkdata(L1,'v');
[by1,ax1]=tfdata(L1,'v'); % polynomial form
% L1_num=zpk(tf(by1,1));   % zpk form
L1_den=zpk(tf(ax1,1));
L1k=920^2;%819.2546;
L1_num=L1k;
D1k=L1k/G1k;
polesD1=rlocus(D1,D1k);
polesL1=rlocus(L1,L1k);

% D1(s) root locus
figure(2)
rlocus(D1)
title('D1(s)')
% L1(s) root locus
figure(3)
rlocus(L1)
title('L1(s)')

% % initial D2(s)
% [mag_Wg1i,phase_Wg1i]=bode(L1,Wg1);  % [abs amplitute]
% gain1i=20*log10(mag_Wg1i);          % [dB]
% K1=10^((1-gain1i)/20)
% rootsL1=rlocus(L1,0);
% polesL1=rlocus(L1,K1)

% % improved D2(s)
% D1f=K1*D1; % controller transfer function
% [y1f,x1f]=tfdata(D1f,'v');
% D1f_num=zpk(tf(y1f,1));
% D1f_den=zpk(tf(x1f,1));

% % L2(s)
% L1f_num=D1f_num*G1_num;
% L1f_den=D1f_den*G1_den;
% L1f=L1f_num/L1f_den;

% % sanity check
% [mag_Wg1, phase_Wg1]=bode(L1f,Wg1);  % [abs amplitute]
% gainWg1=20*log10(mag_Wg1)           % [dB]
% phase_Wg1;
% PM=(phase_Wg1+180)

% bode plots
figure(4)
bode(G1,'k',D1,'r',L1*L1k,'g-.',D1lead,'b--',D1lag,'m')
legend('G1(s)','D1(s)','L1(s)','D1Lead(s)','D1Lag(s)',...
    'Location','Best')
title('Bode Plots')

% closed-loop transfer function
T1_num=L1_num;
T1_den=L1_num+L1_den;
T1=T1_num/T1_den;
% step(T1,t2)
P1=(1/1.02)*(1/.997);
T1=P1*T1;

% step response
% figure(5)
% step(T1,0:t1/100:1)
% title('T1(s) Step Response')
linearSystemAnalyzer('step',T1,0:t2/100:t2)
% linearSystemAnalyzer('step',T1,0:t2/100:10*t2)

% tustin's approx w/ prewarping
% [b1z,a1z]=C2DTustin(y1f,x1f,t1,Wg1); b1z_roots=Roots(b1z); a1z_roots=Roots(a1z); mag1=abs(a1z_roots);
D1z=c2d(D1*D1k,t1)

% D1 discrete time
% D1z=tf(b1z,a1z,t1);
% D1zNum=b1z/b1z(1)
% D1zDen=a1z/b1z(1)

%% Outer Loop
b2=k*Vb*G/(R*2*Iw);
a2=[1 k^2*G^2/(R*2*Iw) 0];
G2=tf(b2,a2);
rootsG2=rlocus(G2,0)

% G2(s) root locus
figure(1)
rlocus(G2)
title('G2(s)')