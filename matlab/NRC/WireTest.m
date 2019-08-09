function WireTest               
% function <a href="matlab:WireTest">WireTest</a>
% This function computes, plots, & animates the leading modes of vibration of a wire.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 4.3.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap04">Chapter 4</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Depends on <a href="matlab:help Eig">Eig</a> and <a href="matlab:help MergeSort">MergeSort</a>.

disp('Now computing, ploting, & animating the leading modes of vibration of a wire.')
clear; close all; c=1; L=1; n=128; numplots=3;  % Initialize the simulation parameters 
DeltaX=L/n;  X=[0:DeltaX:L];                    % Set up grid and the A matrix
A=(c^2/DeltaX^2)*(diag(ones(n-2,1),-1) - 2*diag(ones(n-1,1),0) + diag(ones(n-2,1),1));
[lam,S]=Eig(A);  [scratch,index]=MergeSort(abs(lam),0,n-1); S=S(:,index); lam=lam(index);
omega_exact=[1:numplots]*pi*c/L, n, omega_numerical=sqrt(-lam(1:numplots))'
for m=1:numplots, disp(sprintf('This is a plot of mode %d',m))
   amp=1/max(abs(S(:,m))); clf; plot(X,amp*[0 S(:,m)' 0],'*'), axis([0 1 -1 1]), pause
end, WireAnimate(lam,S,X,n,DeltaX), disp(' ')
end % function WireTest
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function WireAnimate(Ds,Vs,X,n,DeltaX) 
omega=sqrt(-Ds); maxframes=400; tmax=8; p=2; a=0.95/max(abs(Vs(:,p))); clf;        
disp('This is the motion of a single mode.')
for t=0:tmax/maxframes:tmax
  plot(X,a*[0 Vs(:,p)' 0]*sin(omega(p)*t),'Linewidth',2);
  axis([0 1 -1 1]); pause(0.02);
end; pause; p=2; a=0.5/max(abs(Vs(:,p))); q=3; b=0.5/max(abs(Vs(:,q)));
disp('This is the motion of a linear combination of two modes.')
for t=0:tmax/maxframes:tmax
  plot(X,a*[0 Vs(:,p)' 0]*sin(omega(p)*t)+b*[0 Vs(:,q)' 0]*sin(omega(q)*t),'Linewidth',2);
  axis([0 1 -1 1]); pause(0.02);
end; pause; imax=round(n/3); fmax=0.95;              
for i=0:imax; c(i+1)=fmax*i/imax; end, for i=imax+1:n; c(i+1)=fmax*(n-i)/(n-imax); end
disp('This is the motion of a combination of modes that add, initially, to a triangular')
disp('deflection of the wire with zero velocity, correspongind to a "pluck" of the wire.')
for k=1:n-1
  f=[0 Vs(:,k)' 0]*[0 Vs(:,k)' 0]'*DeltaX;  chat(k)=(1/f)*([0 Vs(:,k)' 0]*c')*DeltaX;
end
for t=0:tmax/maxframes:tmax
  shape=0.; for k=1:n-1; shape=shape+chat(k)*[0 Vs(:,k)' 0]*cos(omega(k)*t); end 
  plot(X,shape,'Linewidth',2); axis([0 1 -1 1]); pause(0.02);
end;
end % function WireAnimate
