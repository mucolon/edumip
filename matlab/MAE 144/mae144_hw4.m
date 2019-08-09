close all; clear, clc

% Part 1.A
DT=.01; % 100hz controller loop [s]
freq=100; % 100hz controller loop [Hz]
m_w=.027; % mass of one wheel [Kg]
r=.034; % radius of wheel [m]
N=35.5777; % gearbox ratio
T_s=0.003; % Motor armature stall Torque @ V_nominal (without gearbox)
w_f=1760; % Motor armature free run speed at nominal (without gearbox)
V_s=7.4; % motor nominal drive voltage [V]
I_arm=3.6*10^-8; % inertia of one motor armature [kg*m^2] (without gearbox)
phi_dot=w_f/N;

% design requirements
Wg=phi_dot;  % target controller frequency [rad/s]


I_wheel=m_w*r^2/2 + N^2*I_arm;
I_s=I_wheel*2;
k=V_s/w_f;
R=k*V_s/T_s;
% G(s)=b(s)/a(s)
b=k*V_s*N/(R*I_s);
a=[1 k^2*N^2/(R*I_s) 0];
pG=-a(2);
G=tf(b,a);

% D(s)=K*y(s)/x(s)
% D_lead=(s+z)/(s+p)    z<p
% D_lag=(s+z)/(s+p)    p<z

% sqrt(pz)=Wg
pLead0=-150; % upper bound
zeta=1;
a1=-2*zeta*Wg;
pLag0=a1-pLead0;
while pLag0>0
    pLead0=pLead0+0.1;
    pLag0=a1-pLead0;
    if pLag0>pG && pLag0<0
        pLag=a1-pLead0; % lower bound
        pLead=pLead0;   % upper bound
        break
    end
end

zLead=Wg^2/pLead;  % lower bound
zLag=pLag*1.2;  % upper bound
yLead=[1 -zLead];
xLead=[1 -pLead];
yLag=[1 -zLag];
xLag=[1 -pLag];
Dlead=tf(yLead,xLead);
Dlag=tf(yLag,xLag);
Dy=PolyConv(yLead,yLag);
Dx=PolyConv(xLead,xLag);
D=tf(Dy,Dx);

% L(s)=G(s)*D(s)=[K*b(s)*y(s)]/[a(s)*x(s)+K*b(s)*y(s)]
L_num=PolyConv(Dy,b);
L_den=PolyConv(Dx,a);
L=tf(L_num,L_den);

[mag_Wg0, phase_Wg0]=bode(L,Wg);  % [abs amplitute]
gain0=20*log10(mag_Wg0);          % [dB]
K=10^((1-gain0)/20);
roots=rlocus(L,0);
poles=rlocus(L,K);

D1=K*D; % controller transfer function
[D1y,D1x]=tfdata(D1,'v');
L1_num=PolyConv(K*Dy,b);
L1_den=PolyConv(Dx,a);
L1=tf(L1_num,L1_den); % open-loop transfer function

[mag_Wg, phase_Wg]=bode(L1,Wg);  % [abs amplitute]
gain=20*log10(mag_Wg);           % [dB]
phase_Wg;

figure(1)
bode(D1)
title('D(s) Controller Bode Plot')

figure(2)
bode(G,'k--',D1,'r',...
    L1,'g-.',Dlead,'b',Dlag,'m')
legend('Plant','Controller','Open-Loop','Lead','Lag','Location','Best')
title('Open-Loop Bode Plot')

figure(3)
rlocus(L)
title('Open-Loop Root Locus')

% closed-loop transfer function
T_num=L1_num;
T_den=PolyAdd(L1_num,L1_den);
T=tf(T_num,T_den);

% step response
% figure(4)
% step(T,0:DT/1000:1)
% linearSystemAnalyzer('step',T,0:DT/1000:1)
% title('Closed-Loop Step Response')


% Part 1.B
[bz,az]=C2DTustin(D1y,D1x,DT,Wg); bz_roots=Roots(bz); az_roots=Roots(az); mag=abs(az_roots);


% Part 1.C
Dz=tf(bz,az,DT);
DzNum=bz/bz(1)
DzDen=az/bz(1)
Dkz0=tf(bz,az,DT,'Variable','z^-1');