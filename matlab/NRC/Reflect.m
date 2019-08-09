function [X] = Reflect(X,sig,w,i,k,p,q,which)
% function [X] = Reflect(X,sig,w,i,k,p,q,which)
% Apply a Householder reflection H(sig,w), embedded in rows i:k and columns i:k of an
% identiy matrix, to the matrix X, with {sig,w} as given by ReflectCompute.m  
% Use which='L' to premultiply by H^H, 'R' to postmultiply by H, 'B' to do both.
% Note: the elements outside the range p:q in the columns of X (if premultiplying) and/or
% the rows of X (if postmultiplying) are assumed to be zero, and thus left untouched.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.9.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also ReflectCompute. Verify with ReflectTest.

if or(which=='L',which=='B')
  X(i:k,p:q)=X(i:k,p:q)-(conj(sig)*w)*(w'*X(i:k,p:q));  % (1.10a)
end, if or(which=='R',which=='B')                      
  X(p:q,i:k)=X(p:q,i:k)-(X(p:q,i:k)*w)*(sig*w');        % (1.10b)
end
end % function Reflect
