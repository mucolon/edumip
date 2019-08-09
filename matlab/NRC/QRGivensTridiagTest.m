% script <a href="matlab:QRGivensTridiagTest">QRGivensTridiagTest</a>
% Test <a href="matlab:help QRGivensTridiag">QRGivensTridiag</a> on a random (square) tridiagonal matrix.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 2.3.4.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap04">Chapter 2</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

disp('Now testing QRGivensTridiag on a random (square) tridiagonal matrix.')
clear; n=10; a=[0; randn(n-1,1)]; b=randn(n,1); c=[randn(n-1,1); 0];
A=diag(a(2:n),-1)+diag(b,0)+diag(c(1:n-1),1), [b,c,a,cc,ss] = QRGivensTridiag(a,b,c);
R=diag(b,0)+diag(c(1:n-1),1)+diag(a(1:n-2),2), Q=eye(n);
for i=1:n-1; [Q]=Rotate(Q,cc(i),ss(i),i,i+1,1,max(i+1,n),'R'); end
Q, residual=norm(Q*R-A), disp(' ')

% end script QRGivensTridiagTest
