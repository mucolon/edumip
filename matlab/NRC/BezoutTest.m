% script <a href="matlab:BezoutTest">BezoutTest</a>
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

b=[1 0 -4], a=[1 0 -10 0 9],
[g,q,n,a,b] = GCF(a,b);    % Apply Euclid's alorithm to find the GCF g
[x,y] = Bezout(a,b,g,q,n)  % Apply the extended Euclidean algorithm to solve a+by=g
g, a_times_x_plus_b_times_y=PolyAdd(PolyConv(a,x),PolyConv(b,y))
