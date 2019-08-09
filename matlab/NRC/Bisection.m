function [x,evals]=Bisection(x1,x2,Compute_f,tol,verbose,p)     
% function [x,evals]=Bisection(x1,x2,Compute_f,tol,verbose,p)
% This function refines the bracket of a root with the bisection algorithm.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 3.1.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap03">Chapter 3</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also FindRootBracket, FalsePosition.  Verify with BisectionTest.

f1=Compute_f(x1,verbose,p); f2=Compute_f(x2,verbose,p); evals=2;
while x2-x1>tol
   x = (x2 + x1)/2; f=Compute_f(x,verbose,p); evals=evals+1;
   if f1*f<0, x2=x; f2=f;
   else,      x1=x; f1=f; end
end
x=(x2+x1)/2;
end % function Bisection
