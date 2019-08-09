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

theta_ref=-.43; % [rad] center of gravity angle for 

a=2*Iw+(2*Mw+Mb)*r^2;
b=Mb*r*l;
c=Ib+Mb*l^2;
d=Mb*g*l;
k1=2*G*sbar;
k2=2*G*k;
k3=k1/(a*s^2 + k2*s);
k4=(k2*s - b*s^2)/(k2*s * a*s^2);
k5=-k1/(b*s^2 - s*k2);
k6=(d - k2*s - c*s^2)/(b*s^2 - k2*s);

%% Inner Loop with grad student plant
% model of edumip system from input normalized voltage to output theta
%   angle of edumip body
% G1(s) = theta(s)/u(s)
close all; clc
G1=minreal(-74.1*s/(s^3+34.7*s^2-128.4*s-1555.4));
[~,G1p,~]=zpkdata(G1,'v');

% G1(s) root locus
figure(1)
rlocus(G1)
title('G1(s) Root Locus')

% making D1 controller
% D(s) = u(s)/error_theta(s)
% D1 Gain
D1=minreal(((s-G1p(1))*(s-G1p(3)))/(s*(s+60)));
% D1=D1*-46.8;
D1=D1*-20;

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)]
L1=minreal(G1*D1);
polesD1=rlocus(D1,1)
polesL1=rlocus(L1,1)

% D1(s) root locus
figure(2)
rlocus(D1)
title('D1(s) Root Locus')
% L1(s) root locus
figure(3)
rlocus(L1)
title('L1(s) Root Locus')
% L1(s) bode
figure(4)
bode(L1,'b')
hold on
bode(D1,'r')
bode(G1,'k')
legend('L1(s)','D1(s)','G1(s)','Location','Best')
title('Bodes')

% closed-loop transfer function

prescaler = 1.4572;
T1=minreal(G1*D1/(1+G1*D1));

% inner loop prefactor
% P1=1/(1.33)
P1 = 1/(2);

% step response
figure(5)
step(T1,1)
title('T1(s) Step Response')

% exact coversion from D(s) to D(z)
% D(s) = error_theta(s)/u(s)
D1z=c2d(D1,t1);
[y1z,x1z]=tfdata(D1z,'v');
u1z=x1z
etheta1z=y1z

%% Inner Loop
% model of edumip system from input normalized voltage to output theta
%   angle of edumip body
% G1(s) = theta(s)/u(s)
clc
G1=minreal((k3-k5)/(k6-k4));
[G1z,G1p,G1k]=zpkdata(G1,'v');
[b1,a1]=tfdata(G1,'v'); % polynomial form
G1_num=zpk(tf(b1,1));   % zpk form
G1_den=zpk(tf(a1,1));

% G1(s) root locus
figure(1)
rlocus(G1)
title('G1(s) Root Locus')
rootsG1=rlocus(G1,0);
polesG1=rlocus(G1,1);

% making D1 controller
% D(s) = u(s)/error_theta(s)
% D1=((s-G1p(1))*(s-G1p(2))*(s-G1p(3)))/(s^2*(s+G1p(4)+2));
D1=((s-G1p(1))*(s-G1p(2)))/s^2;
D1=D1*-4*1.1872;
D1=minreal(D1);

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)]
L1=minreal(G1*D1);
polesD1=rlocus(D1,1)
polesL1=rlocus(L1,1)

% D1(s) root locus
figure(2)
rlocus(D1)
title('D1(s) Root Locus')
% L1(s) root locus
figure(3)
rlocus(L1)
title('L1(s) Root Locus')
% L1(s) bode
figure(4)
bode(L1)
title('L1(s) Bode')

% closed-loop transfer function
T1=minreal(G1*D1/(1+G1*D1));
% P1=1/266
% step response
figure(5)
step(T1,10)
title('T1(s) Step Response')

% exact coversion from D(s) to D(z)
% D(s) = error_theta(s)/u(s)
D1z=c2d(D1,t1);
[D1zz,D1zp,D1zk]=zpkdata(D1z,'v');
[y1z,x1z]=tfdata(D1z,'v');
u1z=x1z
etheta1z=y1z/y1z(1)
K1z=y1z(1)

%% Outer Loop
% G2(s) = phi(s)/theta(s)
close all; clc
G2=(d-s^2*(b+c))/(s^2*(a+b));
G2=minreal(G2);
[G2z,G2p,G2k]=zpkdata(G2,'v');

figure(1)
rlocus(G2)
title('G2(s) Root Locus')

% making D2 controller
% D2(s) = theta(s)/error_phi(s)
D2=s/((s+G2z(2))*(s+10));
D2 = D2*4*.37;

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)]
L2=minreal(G2*D2);
polesD2=rlocus(D2,1)
polesL2=rlocus(L2,1)

% D2(s) root locus
figure(2)
rlocus(D2)
title('D2(s) Root Locus')
% L2(s) root locus
figure(3)
rlocus(L2)
title('L2(s) Root Locus')
% L2(s) bode
figure(4)
bode(L2)
title('L2(s) Bode')

% closed-loop transfer function
T2=minreal(G2*D2/(1+G2*D2));
% step response
figure(5)
step(T2,3)
title('T2(s) Step Response')

% D2(s) = error_phi(s)/theta(s)
D2z=c2d(D2,t1);
[y2z,x2z]=tfdata(D2z,'v');
theta2z=x2z
ephi2z=y2z
