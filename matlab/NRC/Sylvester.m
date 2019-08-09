function X=Sylvester(A,B,C,g,m,n)
% function X=Sylvester(A,B,C,g,m,n)
% Compute the X=X_(mxn) that satisfies A X - X B = g C, where A=A_(mxm), B=B_(nxn), and
% C=C_(mxn) are full and g is a scaler with 0 < g <= 1.
% See <a href="matlab:web('http://numerical-renaissance.com')">Numerical Renaissance: simulation, optimization, & control</a>, Section 4.5.1.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap04">Chapter 4</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Sylvester. Depends on Schur, GaussPP.
% Verify with SylvesterTest.

[U,A0]=Schur(A); [V,B0]=Schur(B); C0=U'*C*V; X0=SylvesterTri(A0,B0,C0,g,m,n); X=U*X0*V';
end % function Sylvester
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X=SylvesterTri(A,B,C,g,m,n)                 % Numerical Renaissance Codebase 1.0
% Compute the X=X_(mxn) that satisfies A X - X B = g C, where A=A_(mxm) and B=B_(nxn) are
% upper triangular, g is a scaler with 0 < g <= 1, and C=C_(mxn) is full.
for b=m:-1:max(1,m-n+1);    s=m-b+1;   % b=initially big index, s=initially small index
  X(b,s)        = g*C(b,s) / (A(b,b)-B(s,s));  
  X(1:b-1,s)    = (A(1:b-1,1:b-1)-B(s,s)*eye(b-1,b-1)) \ (g*C(1:b-1,s)-A(1:b-1,b)*X(b,s));
  X(b,s+1:n)    = (g*C(b,s+1:n)+X(b,s)*B(s,s+1:n)) / (A(b,b)*eye(n-s,n-s)-B(s+1:n,s+1:n));
  C(1:b-1,s+1:n)= C(1:b-1,s+1:n) + (X(1:b-1,s)*B(s,s+1:n)-A(1:b-1,b)*X(b,s+1:n)) /g;
end
end % function SylvesterTri
