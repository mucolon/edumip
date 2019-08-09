function [c,s] = RotateCompute(f,g)
% function [c,s] = RotateCompute(f,g)
% Compute the parameters {c,s} of a Givens rotation matrix designed to rotate
% the vector (f;g) to (*;0).
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section 1.2.10.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchap01">Chapter 1</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% See also Rotate. Verify with RotateTest.

gs=real(g)^2+imag(g)^2;
if gs==0, c=1; s=0; else, fs=real(f)^2+imag(f)^2;
  if fs>=gs, c=1/sqrt(1+gs/fs); s=-c*g/f;
  else,      s=1/sqrt(1+fs/gs); c=-s*f/g;  end
end
end % function RotateCompute
