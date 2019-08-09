% script <a href="matlab:TriDiagTest">TriDiagTest</a>
% Illustrates how the code <a href="matlab:help TriDiag">TriDiag</a> may be used to construct tridiagonal
% and tridiagonal circulant matrices.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.9.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

n=7; a=randn(n,1); b=randn(n,1); c=randn(n,1);
A_tridiagonal=TriDiag([0; a(2:n)], b, [c(1:n-1); 0]) 
A_tridiagonal_circulant=TriDiag(a,b,c)
% end script TriDiagTest
