function [x] = NewtonRaphson(x,n,Compute_f,Compute_A,tol,verbose)         
% function [x] = NewtonRaphson(x,n,Compute_f,Compute_A,tol,verbose)         
% This function solves f(x)=0 using the Newton Raphson method given an initial guess for
% x, where the function f(x) and its Jacobian are defined in Compute_f and Compute_A.
% Take verbose=1 for printing progress reports to screen, or verbose=0 to suppress.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 3.1.1.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap03">Chapter 3</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Verify with <a href="matlab:help NewtonRaphsonTest">NewtonRaphsonTest</a>, which shows how to pass function handles into this code.

if nargin<5, tol=1e-10; end, residual=2*tol;
if nargin<6, verbose=1; end, if verbose, disp('Convergence:'), end
while (residual>tol)
   f=Compute_f(x);  A=Compute_A(x);  residual=norm(f);  x=x+GaussPP(A,-f,n);
   if verbose, disp(sprintf('%20.13f ',x(1:n),residual)); end
end
end % function NewtonRaphson
