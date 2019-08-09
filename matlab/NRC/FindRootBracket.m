function [x1,x2] = FindRootBracket(x1,x2,Compute_f,p)
% function [x1,x2] = FindRootBracket(x1,x2,Compute_f,p)
% Assuming the scalar function defined in Compute_f is smooth, bounded, and has opposite
% signs for sufficiently large and small arguments, find x1 and x2 that bracket a root.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 3.1.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap03">Chapter 3</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Bisection, FalsePosition.  Verify with FindRootBracketTest.

while Compute_f(x1,0,p)*Compute_f(x2,0,p)>=0, int=x2-x1; x1=x1-0.5*int; x2=x2+0.5*int; end
end % function FindRootBracket
