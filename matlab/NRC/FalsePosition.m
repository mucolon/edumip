function [x,evals]=FalsePosition(x1,x2,Compute_f,tol,verbose,p)
% function [x,evals]=FalsePosition(x1,x2,Compute_f,tol,verbose,p)
% This function refines the bracket of a root with the false position algorithm.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 3.1.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap03">Chapter 3</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also FindRootBracket, Bisection.  Verify with FalsePositionTest.

f1=Compute_f(x1,1,p); f2=Compute_f(x2,1,p); evals=2;
while x2-x1>tol
   if verbose, plot([x1 x2],[f1 f2],'r-'); end
   interval=x2-x1;  fprime=(f2-f1)/interval;  x=x1 - f1/fprime;
   % Ad hoc check:  reset to bisection technique if update by false position is too small.
   tol1 = interval/8;  if ((x-x1) < tol1 | (x2-x) < tol1), x = (x1+x2)/2;  end
   % Now perform the function evaluation and update the bracket.
   f = Compute_f(x,1,p); evals=evals+1;
   if f1*f < 0,  x2=x;  f2=f;
   else,         x1=x;  f1=f;  end
end
x=(x2+x1)/2;
end % function FalsePosition
