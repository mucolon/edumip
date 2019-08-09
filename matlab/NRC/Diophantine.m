function [X,Y,r,t] = Diophantine(a,b,g,c,x,y)
% function [X,Y,r,t] = Diophantine(a,b,g,c,x,y)
% Find the general solution {X-r*k,Y+t*k}, for any polynomial k, of the polynomial Diophantine
% equation a*x+b*y=c*g. The solution {X,Y} is that of the lowest possible order for Y.
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.
% Based on results from GCF, Bezout.  Uses PolyConv, PolyDiv, PolyAdd.  See DiophantineTest.

x=PolyConv(x,c); y=PolyConv(y,c); r=PolyDiv(b,g); t=PolyDiv(a,g); [k,Y]=PolyDiv(y,t);
X=PolyAdd(x,PolyConv(r,k)); e=1e-8; Y=Y(find(abs(Y)>e,1):end); X=X(find(abs(X)>e,1):end);
end % function Diophantine
