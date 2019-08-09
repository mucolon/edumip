function [sig,w] = ReflectCompute(x)
% function [sig,w] = ReflectCompute(x)
% Compute the parameters {sig,w} of a Householder reflection matrix designed to reflect
% the vector x to (*;0;0;...;0).
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.9.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Reflect. Verify with ReflectTest.

if real(x(1))<0, s=-1; else, s=1; end, nu=s*norm(x);   % (1.8b)
if nu==0, sig=0; w=0;  else, sig=(x(1)+nu)/nu; w=[x(1)+nu; x(2:end)]/(x(1)+nu); end
end % function ReflectCompute
