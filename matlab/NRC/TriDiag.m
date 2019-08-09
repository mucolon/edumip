function [A]=TriDiag(a,b,c)
% function [A]=TriDiag(a,b,c)
% Construct a tridiagonal or tridiagonal circulant matrix from the vectors {a,b,c}.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.7.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

n=length(b); A=diag(a(2:n),-1)+diag(b,0)+diag(c(1:n-1),1); A(1,n)=a(1); A(n,1)=c(n);
end % function TriDiag
