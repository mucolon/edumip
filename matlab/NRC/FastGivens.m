function [X]=FastGivens(X,a,b,gamma,donothing,i,k,p,q,which)
% function [X]=FastGivens(X,a,b,gamma,donothing,i,k,p,q,which)
% Apply a fast Givens transformation F(gamma;a,b), embedded in elements (i,k) and (k,i) of
% an identiy matrix, to the matrix X, with {gamma;a,b} as given by FastGivensCompute.m
% Use which='L' to premultiply by F^H, 'R' to postmultiply by F, 'B' to do both.
% Note: the elements outside the range p:q in the columns of X (if premultiplying) and/or
% the rows of X (if postmultiplying) are assumed to be zero, and thus left untouched.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.11.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also FastGivensCompute. Verify with FastGivensTest.

if ~donothing, if or(which=='L',which=='B')
    if gamma<=1
      X([i k],p:q)=[conj(b)*X(i,p:q)+X(k,p:q); X(i,p:q)+a*X(k,p:q)]; % (1.12a), modified
    else 
      X([i k],p:q)=[X(i,p:q)+conj(b)*X(k,p:q); a*X(i,p:q)+X(k,p:q)]; % (1.12a), modified
    end
  end, if or(which=='R',which=='B')
    if gamma<=1
      X(p:q,[i k])=[b*X(p:q,i)+X(p:q,k), X(p:q,i)+conj(a)*X(p:q,k)]; % (1.12b), modified
    else 
      X(p:q,[i k])=[X(p:q,i)+b*X(p:q,k), conj(a)*X(p:q,i)+X(p:q,k)]; % (1.12b), modified
    end
end, end
end % function FastGivens
