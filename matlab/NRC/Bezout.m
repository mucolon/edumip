function [x,y] = Bezout(a,b,g,q,n)
% function [x,y] = Bezout(a,b,g,q,n)
% Find {x,y} satisfying Bezout identity a*x+b*y=g via the Extended Euclidian algorithm.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Based on result from GCF.  Uses PolyAdd, PolyConv.  See BezoutTest.

x=0; y=1; for j=n-1:-1:1
  t=x; x=y; y=PolyAdd(t,-PolyConv(q{j},y));  % Using q from the GCF computation, compute
end, y=y(find(y,1):end); x=x(find(x,1):end); % {x,y} via the Extended Euclidean algorithm
end % function Bezout
