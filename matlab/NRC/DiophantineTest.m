clear
clc

% script <a href="matlab:DiophantineTest">DiophantineTest</a>
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

for j=1:4
  switch j
    case 1   % NR Example 19.9 for improper D(s)
       b=[1 0 -4], a=[1 0 -10 0 9], f=PolyConv([1 1],[1 1],[1 3],[1 3])
    case 2   % NR Example 19.9 for proper D(s)
       b=[1 0 -4], a=[1 0 -10 0 9],
       f=PolyConv([1 1],[1 1],[1 3],[1 3],[1 30],[1 30],[1 30],[1 30])
    case 3
       b=[0.0306 0.0455]; a=[1 -3.9397 3.3201]; f=[1 0 0 0];
    case 4
       b=[0.0306 0.0455]; a=[1 -3.9397 3.3201]; f=[1 0 0 0];
  end
  [g,q,n,a,b] = GCF(a,b);     % Apply Euclid's alorithm to find the GCF g
  [x,y] = Bezout(a,b,g,q,n);  % Apply the extended Euclidean algorithm to solve a*x+b*y=g
  % Now compute solution {X,Y}, of greatest relative degree, of Diophantine equation a*X+b*Y=f.
  [X,Y] = Diophantine(a,b,g,PolyDiv(f,g),x,y), poles=roots(X)', zeros=roots(Y)'
  f_test=PolyAdd(PolyConv(a,X),PolyConv(b,Y)); f_test=f_test(find(abs(f_test)>1e-8,1):end)
  cl_poles=roots(f_test)', residual=norm(PolyAdd(f,-f_test))
  if j<4, disp(' '), pause, end
end
