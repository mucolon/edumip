% script <a href="matlab:InvDistanceInterpTest">InvDistanceInterpTest</a>
% Test <a href="matlab:help InvDistanceInterp">InvDistanceInterp</a> on data from a smooth fn.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.4.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
 
clear; Lx=17; Ly=30; Nx=85; Ny=150; N=150; k=2;      % Lx*Ly domain, k=order of RBFs
x=[-Lx/2:Lx/(Nx-1):Lx/2]; y=[-Ly/2:Ly/(Ny-1):Ly/2];  % Nx*Ny grid on Lx*Ly domain
c(1,:)=Lx*rand(1,N)-Lx/2; c(2,:)=Ly*rand(1,N)-Ly/2;  % N random points in domain
for i=1:Nx, for j=1:Ny,
  r=sqrt(x(i)^2+y(j)^2)+eps;   F(i,j)=sin(r)/r;      % F = test function on grid
end, end                    
f=sqrt(c(1,:).^2+c(2,:).^2)+eps;   f=sin(f)./f;      % f = test function on random points

close all; figure(1), grid on, hold on, title('Original function = sin(x)/x'), surf(y,x,F)
plot3(c(2,:),c(1,:),f,'ko','markerfacecolor','k'), axis tight, view(-11.5,14)

for k=2:5, if k<5, p=k; else, p=20; end, figure(k)
  for i=1:Nx, for j=1:Ny
    fn(i,j)=InvDistanceInterp([x(i); y(j)],c,f,p,100); % inverse distance interpolant
  end, end
  grid on, hold on, title(sprintf('Inverse distance interpolant, p=%d',p)), surf(y,x,fn)
  plot3(c(2,:),c(1,:),f+.01,'ko','markerfacecolor','k'), axis tight, view(-11.5,14)
end
% end script InvDistanceInterpTest
