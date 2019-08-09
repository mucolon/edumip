% script <a href="matlab:GCFTest">GCFTest</a>
% See <a href="matlab:NRweb">Numerical Renaissance: simulation, optimization, & control</a>, Section B.2.
% Part of <a href="matlab:help NRC">Numerical Renaissance Codebase 1.0</a>, <a href="matlab:help NRchapAB">Appendix B</a>; please read the <a href="matlab:help NRcopyleft">copyleft</a>.

a=PolyConv([1 2],[1 3],[1 4],[1 5]),  b=PolyConv([1 2],[1 6],[1 7],[1 8],[1 9])
[g,q,n,a,b] = GCF(a,b);    % Apply Euclid's alorithm to find the GCF g
a, b, g
disp('Note that {a,b} are sorted to put the highest order polynomial first,')
disp('and g is found up to an arbitrary multiplicative constant.')
