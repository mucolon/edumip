%% Variables
close all; clear, clc
Vb=7.4;     % nominal voltage [V]
Wf=1760;    % motor free run speed [rad/s]
sbar=0.003; % stall torque @ Vb [N*m]
G=35.56;    % gearbox ratio
Im=3.6e-8;  % motor armature inertia [kg*m^2]
r=34e-3;    % wheel radius [m]
Mw=27e-3;   % wheel mass [kg]
Mb=180e-3;  % MiP body mass [kg]
l=47.7e-3;  % center of MiP mass to wheel axle [m]
Ib=2.63e-4; % MiP body inertia [kg*m^2]
g=9.80665;  % gravitational accel [m^2/s]
k=Vb/Wf;    % motor cte [V*s = N*m/A]
Iw=(1/2)*Mw*r^2+Im*G^2;   % wheel inertia [kg*m^2]
R=k*Vb/sbar;    % motor resistance [ohm]
% k1=2*Iw+(Mb+2*Mw)*r^2;
% k2=Mb*r*l;
% k3=Ib+Mb*l^2;
% k4=Mb*g*l;
% k5=2*G*sbar;
% k6=2*k*G^2;
s=zpk(0,[],1);
% A1=-k5/(k3*s^2+s*k6-k4);
% A2=(-k2*s^2+s*k6)/(k3*s^2+s*k6-k4);
% A3=k5/(k1*s^2+s*k6);
% A4=(-k2*s^2+s*k1)/(k1*s^2+s*k6);

freq1=200;  % inner loop frequency [Hz] 
freq2=20;   % outer loop frequency [Hz]
t1=1/freq1; % inner loop period [s]
t2=1/freq2; % outer loop period [s]

%% Inner Loop
% G1=(A1+A2*A3)/(1-A2*A4);
G1=-74.1*s/(s^3+34.7*s^2-128.4*s-1555.4);
[G1z,G1p,G1k]=zpkdata(G1,'v');
[b1,a1]=tfdata(G1,'v'); % polynomial form
G1_num=zpk(tf(b1,1));   % zpk form
G1_den=zpk(tf(a1,1));
% G1z(1:7)=[];
% G1p(1:7)=[];

% G1z_len=length(G1z{1});
% G1p_len=length(G1p{1});
% i=1;
% while i<=G1z_len
%     j=1;
%     while j<=G1p_len
%         if G1z{1}(i)-G1p{1}(j) <= 1e-34
%             G1z{1}(i)=[];
%             G1p{1}(j)=[];
%             G1z_len=G1z_len-1;
%             G1p_len=G1p_len-1;
%             break
%         else
%             j=j+1;
%             if j == G1p_len+1
%                 i=i+1;
%             end
%         end
%     end
% end

% G1_num=1;
% G1_den=1;
% for i=length(G1z):-1:1
%     G1_num=G1_num*(s-G1z(i));
% end
% for i=length(G1p):-1:1
%     G1_den=G1_den*(s-G1p(i));
% end
% G1=(G1k*G1_num)/G1_den;

% G1(s) root locus
figure(1)
rlocus(G1)
title('G1(s)')
rootsG1=rlocus(G1,0);
polesG1=rlocus(G1,abs(G1k));

% linearSystemAnalyzer('impulse',G1,0:t2/100:.5)

sigma1=4.6/t2;
zeta1=1;
Wg1=sigma1/zeta1;
% Wg1=1.8/t1;
% a11=2*zeta1*Wg1;
sig2=-2*sigma1;
p1lag=0;
p1lead=sig2;

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
z1lead=Wg1^2/p1lead;  % lower bound
% z1lead=rootsG1(3);
if z1lead < p1lead
    disp('ERROR: D1lead is not behaving as intended.')
    pause
end
% p1lag=0;
% z1lag=1.1*p1lag;
z1lag=rootsG1(1);
% z1lag=z1lead-0.7*z1lead;  % upper bound
D1lead=(s-z1lead)/(s-p1lead);
% D1zeros=(s-G1p(2))*(s-G1p(1));
% D1low=300^2/(s^2+2*300*s+300^2);
% D1low=600/(s+600);
D1lag=(s-z1lag)/(s-p1lag);
D1=D1lead*D1lag;%*D1zeros*D1low^2*(1200/(s+1200));
[y1,x1]=tfdata(D1,'v'); % polynomial form
D1_num=zpk(tf(y1,1));   % zpk form
D1_den=zpk(tf(x1,1));

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)]
L1_num=D1_num*G1_num;
L1_den=D1_den*G1_den;
L1=L1_num/L1_den;

% initial D2(s)
[mag_Wg1i,phase_Wg1i]=bode(L1,Wg1);  % [abs amplitute]
gain1i=20*log10(mag_Wg1i);          % [dB]
K1=10^((1-gain1i)/20)
rootsL1=rlocus(L1,0);
polesL1=rlocus(L1,K1)

% improved D2(s)
D1f=K1*D1; % controller transfer function
[y1f,x1f]=tfdata(D1f,'v');
D1f_num=zpk(tf(y1f,1));
D1f_den=zpk(tf(x1f,1));

% L2(s)
L1f_num=D1f_num*G1_num;
L1f_den=D1f_den*G1_den;
L1f=L1f_num/L1f_den;

% sanity check
[mag_Wg1, phase_Wg1]=bode(L1f,Wg1);  % [abs amplitute]
gainWg1=20*log10(mag_Wg1)           % [dB]
phase_Wg1;
PM=(phase_Wg1+180)

% D1(s) root locus
figure(2)
rlocus(D1f)
title('D1(s)')

% L1(s) root locus
figure(3)
rlocus(L1f)
title('L1(s)')

% bode plots
figure(4)
bode(G1,'k',D1f,'r',L1f,'g-.',D1lead,'b--',D1lag,'m')
legend('G1(s)','D1(s)','L1(s)','D1Lead(s)','D1Lag(s)',...
    'Location','Best')
title('Bode Plots')

% closed-loop transfer function
T1_num=L1f_num;
T1_den=L1f_num+L1f_den;
T1=T1_num/T1_den;

% step response
% figure(5)
% step(T1,0:t1/100:1)
% title('T1(s) Step Response')
linearSystemAnalyzer('step',T1,0:t2/100:t2)
linearSystemAnalyzer('step',T1,0:t2/100:10*t2)

% tustin's approx w/ prewarping
[b1z,a1z]=C2DTustin(y1f,x1f,t1,Wg1); b1z_roots=Roots(b1z); a1z_roots=Roots(a1z); mag1=abs(a1z_roots);

% D2 discrete time
D1z=tf(b1z,a1z,t1);
D1zNum=b1z/b1z(1)
D1zDen=a1z/b1z(1)

%% Outer Loop
b2=k*Vb*G/(R*2*Iw);
a2=[1 k^2*G^2/(R*2*Iw) 0];
G2=tf(b2,a2);
rootsG2=rlocus(G2,0)

% G2(s) root locus
figure(1)
rlocus(G2)
title('G2(s)')