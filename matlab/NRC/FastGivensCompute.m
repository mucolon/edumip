function [a,b,gamma,donothing,dnew]=FastGivensCompute(f,g,di,dk)
% function [a,b,gamma,donothing,dnew]=FastGivensCompute(f,g,di,dk)
% Compute the parameters {a,b,gamma,donothing} of a Fast Givens transformation matrix
% designed to transform the vector (f;g) to (*;0).
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.11.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also FastGivens. Verify with FastGivensTest.

if g==0, donothing=1; else                                  % see sentence before (1.16)
  a=-f/g; b=-a*dk/di; gamma=-(real(a)*real(b)+imag(a)*imag(b)); donothing=0;
  if gamma<=1, dnew=(1+gamma)*[dk di]; else dnew=(1+1/gamma)*[di dk]; a=1/a; b=1/b; end
end
end % function FastGivensCompute
