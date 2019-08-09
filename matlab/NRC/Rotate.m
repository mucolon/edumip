function [X] = Rotate(X,c,s,i,k,p,q,which)
% function [X] = Rotate(X,c,s,i,k,p,q,which)
% Apply a Givens rotation G(c,s), embedded in elements (i,i) (i,k) (k,i) and (k,k)
% of an identiy matrix, to the matrix X, with {c,s} as given by RotateCompute.  
% Use which='L' to premultiply by G^H, 'R' to postmultiply by G, 'B' to do both.
% Note: the elements outside the range p:q in the columns of X (if premultiplying) and/or
% the rows of X (if postmultiplying) are assumed to be zero, and thus left untouched.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.10.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also RotateCompute. Verify with RotateTest.

if or(which=='L',which=='B')
  X([i k],p:q)=[conj(c)*X(i,p:q)-conj(s)*X(k,p:q); s*X(i,p:q)+c*X(k,p:q)];
end, if or(which=='R',which=='B')                        
  X(p:q,[i k])=[c*X(p:q,i)-s*X(p:q,k), conj(s)*X(p:q,i)+conj(c)*X(p:q,k)];
end
end % function Rotate
