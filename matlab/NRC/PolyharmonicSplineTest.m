% script <a href="matlab:PolyharmonicSplineTest">PolyharmonicSplineTest</a>
% Test <a href="matlab:help PolyharmonicSpline">PolyharmonicSpline</a> on data from a smooth fn.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 7.4.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap07">Chapter 7</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
 
clear; Lx=17; Ly=30; Nx=85; Ny=150; N=150; kmax=6;  % Lx*Ly domain, k=order of RBFs
x=[-Lx/2:Lx/(Nx-1):Lx/2]; y=[-Ly/2:Ly/(Ny-1):Ly/2];  % Nx*Ny grid on Lx*Ly domain
c(1,:)=Lx*rand(1,N)-Lx/2; c(2,:)=Ly*rand(1,N)-Ly/2;  % N random points in domain
for i=1:Nx, for j=1:Ny,
  r=sqrt(x(i)^2+y(j)^2)+eps;   F(i,j)=sin(r)/r;      % F = test function on grid
end, end                    
f=sqrt(c(1,:).^2+c(2,:).^2)+eps;   f=sin(f)./f;      % f = test function on random points

close all; figure(kmax*2+1), grid on, hold on, title('Original function = sin(x)/x')
plot3(c(2,:),c(1,:),f,'ko','markerfacecolor','k'), surf(y,x,F), axis tight, view(-11.5,14)
for k=1:kmax, figure(k), grid on, hold on
  [w,v]=PolyharmonicSplineSetup(c,f,k);                 % initialize weights of the spline
  for i=1:Nx, for j=1:Ny
    fi(i,j,k)=PolyharmonicSpline([x(i); y(j)],c,v,w,k); % calculate interpolant
  end, end, e=abs(fi(:,:,k)-F); maxe(k)=max(max(e)); rmse(k)=norm(e,'fro')/sqrt(Nx*Ny);
  title(sprintf('Polyharmonic spline interpolant, k=%d',k)), surf(y,x,fi(:,:,k))
  plot3(c(2,:),c(1,:),f(:,:),'ko','markerfacecolor','k'), axis tight, view(-11.5,14)
%  figure(kmax+k), grid on, hold on
%  title(sprintf('Error of k=%d polyharmonic spline interpolant',k)), surf(y,x,e)
%  plot3(c(2,:),c(1,:),f*0+maxe(k),'ko','markerfacecolor','k'), axis tight
end
maxe, rmse, figure(kmax*2+2), plot(maxe,'k-'); hold on; plot(rmse,'k--')

% end script PolyharmonicSplineTest
