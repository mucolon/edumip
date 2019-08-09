function [G,a,b,c,d,e] = Circulant(a,b,c,G,n)
% function [G,a,b,c,d,e] = Circulant(a,b,c,G,n)
% This function solves the tridiagonal circulant system AX=G for X.  On exit, the matrix G
% is replaced by the solution X and (if requested), {a,b,c,d,e} contain the m_ij and U.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 2.3.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap02">Chapter 2</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also CirculantLU.  Verify with CirculantTest.

d(1) = a(1);    e(1) = c(n);            % Initialize d and e vectors
for j = 1:n-2,                          % FORWARD SWEEP
   a(j+1)   = - a(j+1) / b(j);
   b(j+1)   = b(j+1)   + a(j+1)*c(j);
   d(j+1)   = a(j+1) * d(j);     
   G(j+1,:) = G(j+1,:) + a(j+1)*G(j,:);
   e(j)     = - e(j) / b(j);
   e(j+1)   = e(j) * c(j);
   b(n)     = b(n)  + e(j) * d(j);
   G(n,:)   = G(n,:) + e(j)*G(j,:);
end
d(n-1) = d(n-1) + c(n-1);               % Fix d and e vectors in their n-1 components.
e(n-1) = e(n-1) + a(n); 
a(n)   = - e(n-1) / b(n-1);             % Now handle j=n-1 case of the loop seperately,
b(n)   = b(n) + a(n) * d(n-1);          % as variables have different names in the corner.
G(n,:) = G(n,:) + a(n) * G(n-1,:);
G(n,:)   = G(n,:) / b(n);               % BACK SUBSTITUTION
G(n-1,:) = ( G(n-1,:) - d(n-1) * G(n,:) ) / b(n-1);
for i = n-2:-1:1,
   G(i,:) = ( G(i,:) - c(i) * G(i+1,:) - d(i) * G(n,:) ) / b(i);
end
end % function Circulant
