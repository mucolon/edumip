function [qs,energy]=SolarSystemSimulator(method)
% function <a href="matlab:SolarSystemSimulator">SolarSystemSimulator</a>
% Simulate the evolution of the solar system using method=SI4 or method=RK4.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 10.6.3.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap10">Chapter 10</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

if nargin<1, method='SI4', end       % Try 'SI4' or 'RK4' (but check Figure 10.24 first!)
Tmax=1.8808;                         % Exact total simulation time, in sidereal years
kmax=round(Tmax*365); h=Tmax/kmax;   % Timestep (will be about 1 earth day)
% Set constants to convert distances to AU and times to sidereal years, 
AU=149597870700;       % Astronomical Unit = mean orbital distance of earth from sun in m
sy=365.256363004;      % Number of days in a sidereal year
% Gravitational constant (converted from m^3/kg/s^2 to AU^3/kg/year^2)
G =6.67428e-11*(60*60*24*sy)^2/AU^3; 
% Masses (kg)  [Data from Champion et al. (2010)]
M(1)=1.988920e+30;             % Sun
M(2)=3.29846e+23;              % Mercury 
M(3)=4.86854e+24;              % Venus
M(4)=5.9736e+24 + 0.07349e+24; % Earth + Moon
M(5)=6.41665e+23;              % Mars    
M(6)=1.899005e+27;             % Jupiter 
M(7)=5.686069e+26;             % Saturn  
M(8)=8.6832e+25;               % Uranus
M(9)=1.0243e+26;               % Neptune
% Note: Pluto is now just a planette, and thus isn't included in this simulation...
% Initial positions (AU) and initial velocities (AU/day)
% [Data from Arminjon, M (2002), 00:00:00.0 on February 26, 2000.]
q=[0, 0, 0;                                                       % Sun
  -2.503321047836E-01, +1.873217481656E-01, +1.260230112145E-01;  % Mercury 
  +1.747780055994E-02, -6.624210296743E-01, -2.991203277122E-01;  % Venus
  -9.091916173950E-01, +3.592925969244E-01, +1.557729610506E-01;  % Earth + Moon
  +1.203018828754E+00, +7.270712989688E-01, +3.009561427569E-01;  % Mars    
  +3.733076999471E+00, +3.052424824299E+00, +1.217426663570E+00;  % Jupiter 
  +6.164433062913E+00, +6.366775402981E+00, +2.364531109847E+00;  % Saturn  
  +1.457964661868E+01, -1.236891078519E+01, -5.623617280033E+00;  % Uranus
  +1.695491139909E+01, -2.288713988623E+01, -9.789921035251E+00]; % Neptune
p=[0, 0, 0;                                                       % Sun
  -2.438808424736E-02, -1.850224608274E-02, -7.353811537540E-03;  % Mercury 
  +2.008547034175E-02, +8.365454832702E-04, -8.947888514893E-04;  % Venus
  -7.085843239142E-03, -1.455634327653E-02, -6.310912842359E-03;  % Earth + Moon
  -7.124453943885E-03, +1.166307407692E-02, +5.542098698449E-03;  % Mars
  -5.086540617947E-03, +5.493643783389E-03, +2.478685100749E-03;  % Jupiter
  -4.426823593779E-03, +3.394060157503E-03, +1.592261423092E-03;  % Saturn  
  +2.647505630327E-03, +2.487457379099E-03, +1.052000252243E-03;  % Uranus
  +2.568651772461E-03, +1.681832388267E-03, +6.245613982833E-04]; % Neptune
% Convert initial velocities (AU/day) to initial momenta (AU*kg/year)
for i=1:9, p(i,:)=M(i)*p(i,:)*sy; end
% Remove the drift of the entire system.
drift=sum(p,1)/sum(M); for i=1:9, for j=1:3, p(i,j)=p(i,j)-M(i)*drift(j); end, end
% Shift center of mass of system to the origin.
cm=[M*q(:,1) M*q(:,2) M*q(:,3)]/sum(M); for j=1:3, q(:,j)=q(:,j)-cm(j); end
% Reflect system such that [1 0 0] is normal to the plane of the ecliptic
n=0; for i=1:9, n=n+cross(q(i,:),p(i,:)); end
[s,w]=ReflectCompute(n'); [q]=Reflect(q,s,w,1,3,1,9,'R');  [p]=Reflect(p,s,w,1,3,1,9,'R');
a=q(4,2); b=q(4,3); % Rotate system such that earth is initially at 0 degrees
[c,s]=RotateCompute(a,b); [q]=Rotate(q,-c,-s,2,3,1,9,'R'); [p]=Rotate(p,-c,-s,2,3,1,9,'R');
% Set up a vector to save the simulation result, and check the initial energy
qs(:,:,1)=q; energy(1)=CheckEnergy(p,q,M,G,0,method);
% Initialize constants for SI4 time marching method of Ruth
f=2^(1/3); c(1)=1/(2*(2-f)); c(4)=c(1); c(2)=(1-f)/(2*(2-f)); c(3)=c(2);
d(1)=1/(2-f);     d(3)=d(1); d(2)=-f/(2-f);        d(4)=0; 
for P=1:2, figure(P); clf; if P==1; n=5; else; n=9; end                 % Initialize plots
plot3(q(1:n,1),q(1:n,2),q(1:n,3),'k+'); hold on; view(90,0), j=1; end
for k=1:Tmax/h, t=k*h;                           % Now perform time march using SI4 or RK4
  if method=='SI4'
    for ss=1:4, q=q+c(ss)*h*dqdt(p,M);  if ss<4, p=p+d(ss)*h*dpdt(q,M,G); end, end   % SI4
    % Note: the SI4 implementation above may be accelerated by combining the last substep
    % of each timestep with the first substep of the next, as suggested in the text.
  elseif method=='RK4'
    k1q=dqdt(p,M);                   k1p=dpdt(q,M,G);                                % RK4
    k2q=dqdt(p+(h/2)*k1p,M);         k2p=dpdt(q+(h/2)*k1q,M,G);
    k3q=dqdt(p+(h/2)*k2p,M);         k3p=dpdt(q+(h/2)*k2q,M,G);
    k4q=dqdt(p+h*k3p,M);             k4p=dpdt(q+h*k3q,M,G);
    q=q+h*(k1q/6+(k2q+k3q)/3+k4q/6); p=p+h*(k1p/6+(k2p+k3p)/3+k4p/6); 
  end
  qs(:,:,k+1)=q;
  if (mod(k,5)==0 & k<=730) | mod(k,365)==0 | k==Tmax/h, l=k+1; for P=1:2, figure(P),
    if P==1, n=5; m=1; title(sprintf('Inner planets, Day=%0.2f, Year=%0.5g',t*sy,t))
    else,    n=9; m=5; title(sprintf('Outer planets, Day=%0.2f, Year=%0.5g',t*sy,t)), end
    for i=1:n
      plot3(shiftdim(qs(i,1,j:m:l)),shiftdim(qs(i,2,j:m:l)),shiftdim(qs(i,3,j:m:l)),'k-')
    end
    axis tight, axis equal, pause(0.0001);
  end, j=l; end
  if mod(k,365)==0 | k==Tmax/h, energy(end+1)=CheckEnergy(p,q,M,G,t,method); end
end
for P=1:2, figure(P), plot3(q(1:n,1),q(1:n,2),q(1:n,3),'k*'), hold off,end % Finalize plots                                          
end % function SolarSystemSimulator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x] = dqdt(p,M);
for i=1:9; for j=1:3; x(i,j)=p(i,j)/M(i); end, end
end % function dqdt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x] = dpdt(q,M,G);
x=zeros(9,3); for i=1:9; for j=1:3; for k=1:9; if k~=i
  x(i,j)=x(i,j)+G*M(i)*M(k)*(q(k,j)-q(i,j))/norm(q(k,:)'-q(i,:)')^3;
end, end, end, end
end % function dpdt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function TE=CheckEnergy(p,q,M,G,t,method);
KE=0; for i=1:9, KE=KE+norm(p(i,:)')^2/(2*M(i)); end
PE=0; for i=1:8, for k=i+1:9, PE=PE-G*M(i)*M(k)/norm(q(k,:)'-q(i,:)'); end, end
TE=KE+PE; disp(sprintf('%s, Year= %0.5g, Total energy %0.9g',method,t,TE))
end % function CheckEnergy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%